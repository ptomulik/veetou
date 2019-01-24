CREATE OR REPLACE PACKAGE BODY V2U_To AS
    FUNCTION Number_Or_Null(value IN VARCHAR)
        RETURN INTEGER
    IS
    BEGIN
        RETURN TO_NUMBER(value);
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RETURN NULL;
    END;

    FUNCTION Semester_Code(semester_id IN NUMBER)
        RETURN VARCHAR
    IS
        y NUMBER;
        s CHARACTER(1);
    BEGIN
        y := TRUNC(semester_id/2);
        IF semester_id IS NULL OR y < 1900 OR y > 2099 THEN
            RETURN NULL;
        END IF;
        s := CASE MOD(semester_id, 2) WHEN 1 THEN 'Z' ELSE 'L' END;
        RETURN TO_CHAR(y, '0999') || s;
    END;

    FUNCTION Semester_Id(semester_code IN VARCHAR)
        RETURN NUMBER
    IS
        y NUMBER;
        s CHARACTER(1);
    BEGIN
        IF REGEXP_INSTR(UPPER(semester_code), '^(19|20)[0-9]{2}[LZ]$') <> 1
        THEN
            RETURN NULL;
        END IF;
        y := TO_NUMBER(SUBSTR(semester_code, 1, 4));    -- year as number
        s := SUBSTR(semester_code, 5, 1);               -- season (L/Z)
        RETURN (2 * y + CASE UPPER(s) WHEN 'Z' THEN 1 ELSE 0 END);
    END;


    FUNCTION Find_Threads(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN V2u_Ko_Thread_Indices_t
    IS
        t V2u_Ko_Thread_Indices_t := V2u_Ko_Thread_Indices_t();
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        sn NUMBER(2);
        prev NUMBER(2);
    BEGIN
        t.EXTEND(semesters.COUNT);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            prev := 0;
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF t(j) IS NULL THEN
                    sn := s.semester_number;
                    IF sn >= prev AND ((prev = 0) OR (sn - prev <= 1)) THEN
                        t(j) := i;
                        prev := sn;
                        n := n + 1;
                    ELSE
                        EXIT;
                    END IF;
                END IF;
                j := j+1;
            END LOOP;
            i := i+1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN t;
    END;

    FUNCTION Threads(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN V2u_Ko_Semester_Threads_t
    IS
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        tn V2u_Ko_Thread_Indices_t;
        tt V2u_Ko_Semester_Threads_t := V2u_Ko_Semester_Threads_t();
    BEGIN
        tn := Find_Threads(semesters);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            tt.EXTEND(1);
            tt(tt.COUNT) := V2u_Ko_Semester_Instances_t();
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF tn(j) = i THEN
                    tt(i).EXTEND(1);
                    tt(i)(tt(i).COUNT) := V2u_Ko_Semester_Instance_t(
                          job_uuid => s.job_uuid
                        , id => s.id
                        , semester_code => s.semester_code
                        , semester_number => s.semester_number
                        , ects_mandatory => s.ects_mandatory
                        , ects_other => s.ects_other
                        , ects_total => s.ects_total
                        , ects_attained => s.ects_attained
                        , sheet_id => s.sheet_id
                    );
                    n := n + 1;
                END IF;
                j := j + 1;
            END LOOP;
            i := i + 1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN tt;
    END;

    FUNCTION Ko_Semester_Instance(
          job_uuid IN RAW
        , id IN NUMBER
        , x_sheet IN V2u_Ko_X_Sheet_t
        )
        RETURN V2u_Ko_Semester_Instance_t
    IS
        sheet V2u_Ko_Sheet_t;
        preamble V2u_Ko_Preamble_t;
    BEGIN
        SELECT DEREF(x_sheet.preamble) INTO preamble FROM dual;
        SELECT DEREF(x_sheet.sheet) INTO sheet FROM dual;
        RETURN V2u_Ko_Semester_Instance_t(
                  job_uuid => job_uuid
                , id => id
                , semester_code => preamble.semester_code
                , semester_number => preamble.semester_number
                , ects_mandatory => sheet.ects_mandatory
                , ects_other => sheet.ects_other
                , ects_total => sheet.ects_total
                , ects_attained => sheet.ects_attained
                , sheet_id => sheet.id
                );
    END;


    FUNCTION Ko_Subject_Instance(
              job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , tr IN V2u_Ko_Tr_t
            , subj_grades IN V2u_Grade_Scale_t := NULL
            , tr_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Instance_t
    IS
    BEGIN
        RETURN V2u_Ko_Subject_Instance_t(
              job_uuid => job_uuid
            , id => id
            , university => header.university
            , faculty => header.faculty
            , studies_modetier => preamble.studies_modetier
            , studies_field => preamble.studies_field
            , studies_specialty => preamble.studies_specialty
            , semester_code => preamble.semester_code
            , subj_code => tr.subj_code
            , subj_name => tr.subj_name
            , subj_hours_w => tr.subj_hours_w
            , subj_hours_c => tr.subj_hours_c
            , subj_hours_l => tr.subj_hours_l
            , subj_hours_p => tr.subj_hours_p
            , subj_hours_s => tr.subj_hours_s
            , subj_credit_kind => tr.subj_credit_kind
            , subj_ects => tr.subj_ects
            , subj_tutor => tr.subj_tutor
            , subj_grades => subj_grades
            , tr_ids => tr_ids
            );
    END;


    FUNCTION Ko_Specialty(
              job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_t
    IS
    BEGIN
        RETURN V2u_Ko_Specialty_t(
                  job_uuid => job_uuid
                , id => id
                , university => header.university
                , faculty => header.faculty
                , studies_modetier => preamble.studies_modetier
                , studies_field => preamble.studies_field
                , studies_specialty => preamble.studies_specialty
                , sheet_ids => sheet_ids
                );
    END;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
