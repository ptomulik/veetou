CREATE OR REPLACE PACKAGE BODY V2U_To AS
    FUNCTION Semester_Code(semester_id IN NUMBER)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN V2u_Semester_t.to_code(semester_id);
    END;

    FUNCTION Semester_Id(semester_code IN VARCHAR2)
        RETURN NUMBER
    IS
    BEGIN
        RETURN V2u_Semester_t.to_id(semester_code);
    END;


    FUNCTION Find_Threads(semesters IN V2u_Ko_Semesters_t)
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

    FUNCTION Threads(semesters IN V2u_Ko_Semesters_t)
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
            tt(tt.COUNT) := V2u_Ko_Semesters_t();
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF tn(j) = i THEN
                    tt(i).EXTEND(1);
                    tt(i)(tt(i).COUNT) := V2u_Ko_Semester_t(
                          job_uuid => s.job_uuid
                        , id => s.id
                        , semester_code => s.semester_code
                        , semester_number => s.semester_number
                        , ects_mandatory => s.ects_mandatory
                        , ects_other => s.ects_other
                        , ects_total => s.ects_total
                        --, ects_attained => s.ects_attained
                        --, ects_attained => NULL
                        --, sheet_id => s.sheet_id
                        -- , sheet_id => NULL
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


    FUNCTION Ko_Student(
              job_uuid IN RAW
            , id IN NUMBER := NULL
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t
    IS
    BEGIN
        RETURN V2u_Ko_Student_t(
              job_uuid => job_uuid
            , student_index => preamble.student_index
            , student_name => preamble.student_name
            , first_name => preamble.first_name
            , last_name => preamble.last_name
            );
    END;


    FUNCTION Ko_Semester(
          id IN NUMBER := NULL
        , job_uuid IN RAW
        , sheet IN V2u_Ko_Sheet_t
        , preamble IN V2u_Ko_Preamble_t
        )
        RETURN V2u_Ko_Semester_t
    IS
    BEGIN
        RETURN V2u_Ko_Semester_t(
                  id => id
                , job_uuid => job_uuid
                , semester_code => preamble.semester_code
                , semester_number => preamble.semester_number
                , ects_mandatory => sheet.ects_mandatory
                , ects_other => sheet.ects_other
                , ects_total => sheet.ects_total
                );
    END;

    FUNCTION Ko_Subject(
              id IN NUMBER := NULL
            , job_uuid IN RAW
            , tr IN V2u_Ko_Tr_t
            /*, subj_grades IN V2u_Subj_20Grades_t := NULL */
            , tr_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_t
    IS
    BEGIN
        RETURN V2u_Ko_Subject_t(
              id => id
            , job_uuid => job_uuid
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
            /*, subj_grades => subj_grades */
            , tr_ids => tr_ids
            );
    END;

--    FUNCTION Ko_Subject_Entity(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , header IN V2u_Ko_Header_t
--            , preamble IN V2u_Ko_Preamble_t
--            , tr IN V2u_Ko_Tr_t
--            , subj_grades IN V2u_Subj_20Grades_t := NULL
--            , tr_ids IN V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Subject_Entity_t
--    IS
--    BEGIN
--        RETURN V2u_Ko_Subject_Entity_t(
--              job_uuid => job_uuid
--            , id => id
--            , university => V2U_Get.University(name => header.university).abbriev
--            , faculty => V2U_Get.Faculty(name => header.faculty).abbriev
--            , studies_modetier => preamble.studies_modetier
--            , studies_field => preamble.studies_field
--            , studies_specialty => preamble.studies_specialty
--            , semester_code => preamble.semester_code
--            , subj_code => tr.subj_code
--            , subj_name => tr.subj_name
--            , subj_hours_w => tr.subj_hours_w
--            , subj_hours_c => tr.subj_hours_c
--            , subj_hours_l => tr.subj_hours_l
--            , subj_hours_p => tr.subj_hours_p
--            , subj_hours_s => tr.subj_hours_s
--            , subj_credit_kind => tr.subj_credit_kind
--            , subj_ects => tr.subj_ects
--            , subj_tutor => tr.subj_tutor
--            , subj_grades => subj_grades
--            , tr_ids => tr_ids
--            );
--    END;

--    FUNCTION Ko_Specialty_Semester(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , specialty IN REF V2u_Ko_Specialty_t
--            , sheet IN V2u_Ko_Sheet_t
--            , preamble IN V2u_Ko_Preamble_t
--            , sheet_ids V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Specialty_Semester_t
--    IS
--    BEGIN
--        RETURN V2u_Ko_Specialty_Semester_t(
--                  job_uuid => job_uuid
--                , id => id
--                /*, university => specialty.university
--                , faculty => specialty.faculty
--                , studies_modetier => specialty.studies_modetier
--                , studies_field => specialty.studies_field
--                , studies_specialty => specialty.studies_specialty */
--                , specialty => specialty
--                , semester_number => preamble.semester_number
--                , semester_code => preamble.semester_code
--                , ects_mandatory => sheet.ects_mandatory
--                , ects_other => sheet.ects_other
--                , ects_total => sheet.ects_total
--                , sheet_ids => sheet_ids
--                );
--    END;


--    FUNCTION Ko_Specialty_Semester(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , sheet IN V2u_Ko_Sheet_t
--            , header IN V2u_Ko_Header_t
--            , preamble IN V2u_Ko_Preamble_t
--            , sheet_ids V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Specialty_Semester_t
--    IS
--    BEGIN
--        RETURN V2u_Ko_Specialty_Semester_t(
--                  job_uuid => job_uuid
--                , id => id
--                , university => V2U_Get.University(name => header.university).abbriev
--                , faculty => V2U_Get.Faculty(name => header.faculty).abbriev
--                , studies_modetier => preamble.studies_modetier
--                , studies_field => preamble.studies_field
--                , studies_specialty => preamble.studies_specialty
--                , semester_number => preamble.semester_number
--                , semester_code => preamble.semester_code
--                , ects_mandatory => sheet.ects_mandatory
--                , ects_other => sheet.ects_other
--                , ects_total => sheet.ects_total
--                , sheet_ids => sheet_ids
--                );
--    END;


    FUNCTION Ko_Specialty(
              job_uuid IN RAW
            , id IN NUMBER := NULL
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN V2u_Ko_Specialty_t
    IS
    BEGIN
        RETURN V2u_Ko_Specialty_t(
                  job_uuid => job_uuid
                , id => id
                , university => V2U_Get.University(name => header.university).abbriev
                , faculty => V2U_Get.Faculty(name => header.faculty).abbriev
                , studies_modetier => preamble.studies_modetier
                , studies_field => preamble.studies_field
                , studies_specialty => preamble.studies_specialty
                );
    END;

--    FUNCTION Ko_Mapped_Subject(
--              subject_entity IN V2u_Ko_Subject_Entity_t
--            , subject_map IN V2u_Subject_Map_t
--            , matching_score IN NUMBER := NULL
--            ) RETURN V2u_Ko_Mapped_Subject_t
--    IS
--    BEGIN
--        RETURN V2u_Ko_Mapped_Subject_t(
--              job_uuid => subject_entity.job_uuid
--            , subject_entity_id => subject_entity.id
--            , subject_map_id => subject_map.id
--            , matching_score => matching_score
--            , subj_code => subject_entity.subj_code
--            , mapped_subj_code => subject_map.mapped_subj_code
--            , subj_name => subject_entity.subj_name
--            , expr_subj_name => subject_map.expr_subj_name
--            , university => subject_entity.university
--            , expr_university => subject_map.expr_university
--            , faculty => subject_entity.faculty
--            , expr_faculty => subject_map.expr_faculty
--            , studies_modetier => subject_entity.studies_modetier
--            , expr_studies_modetier => subject_map.expr_studies_modetier
--            , studies_field => subject_entity.studies_field
--            , expr_studies_field => subject_map.expr_studies_field
--            , studies_specialty => subject_entity.studies_specialty
--            , expr_studies_specialty => subject_map.expr_studies_specialty
--            , semester_code => subject_entity.semester_code
--            , expr_semester_code => subject_map.expr_semester_code
--            , subj_hours_w => subject_entity.subj_hours_w
--            , expr_subj_hours_w => subject_map.expr_subj_hours_w
--            , subj_hours_c => subject_entity.subj_hours_c
--            , expr_subj_hours_c => subject_map.expr_subj_hours_c
--            , subj_hours_l => subject_entity.subj_hours_l
--            , expr_subj_hours_l => subject_map.expr_subj_hours_l
--            , subj_hours_p => subject_entity.subj_hours_p
--            , expr_subj_hours_p => subject_map.expr_subj_hours_p
--            , subj_hours_s => subject_entity.subj_hours_s
--            , expr_subj_hours_s => subject_map.expr_subj_hours_s
--            , subj_credit_kind => subject_entity.subj_credit_kind
--            , expr_subj_credit_kind => subject_map.expr_subj_credit_kind
--            , subj_ects => subject_entity.subj_ects
--            , expr_subj_ects => subject_map.expr_subj_ects
--            , subj_tutor => subject_entity.subj_tutor
--            , expr_subj_tutor => subject_map.expr_subj_tutor
--        );
--    END;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
