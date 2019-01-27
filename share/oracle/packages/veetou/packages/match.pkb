CREATE OR REPLACE PACKAGE BODY V2U_Match AS

    FUNCTION Strip_Person_Degrees(value IN VARCHAR2)
        RETURN VARCHAR2
    IS
        SUBTYPE Degree_Typ IS VARCHAR2(10);
        TYPE Degrees_Array IS VARRAY(20) OF Degree_Typ;
        n NUMBER;
        s VARCHAR2(1024);
        i NUMBER;
        d Degree_Typ;
        degrees Degrees_Array := Degrees_Array('prof. ',
                                                'dr ',
                                                'hab. ',
                                                'mgr ',
                                                'inż. ',
                                                'lic. ',
                                                'doc. ',
                                                'nzw. ',
                                                ' prof.',
                                                ', ',
                                                ' PW');
    BEGIN
        s := value;
        FOR i IN 1 .. degrees.COUNT LOOP
            d := degrees(i);
            n := INSTR(UPPER(s), UPPER(d));
            IF n != 0 THEN
                s := TRIM(SUBSTR(s, 1, n-1) || ' ' || SUBSTR(s, n + LENGTH(d)));
            END IF;
        END LOOP;
        --
        RETURN s;
    END;

    FUNCTION String_Like(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN CASE (value LIKE expr) WHEN TRUE THEN 1 ELSE 0 END;
    END;

    FUNCTION String_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;

        IF smin IS NOT NULL AND V2U_Util.StrCmp(smin, value) > 0 THEN
            RETURN 0;
        ELSIF smax IS NOT NULL AND V2U_Util.StrCmp(value, smax) > 0 THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;


    FUNCTION Code_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
    BEGIN
        RETURN String_Range(UPPER(expr), UPPER(value));
    END;

    FUNCTION Number_Range(expr IN VARCHAR2, value IN NUMBER)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
        nmin NUMBER;
        nmax NUMBER;
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;
        nmin := V2U_To.Number_Or_Null(smin);
        nmax := V2U_To.Number_Or_Null(smax);
        IF nmin IS NOT NULL AND nmin > value THEN
            RETURN 0;
        ELSIF nmax IS NOT NULL AND value > nmax THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;

    FUNCTION Number_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
        nval NUMBER;
    BEGIN
        nval := V2U_To.Number_Or_Null(value);
        IF nval IS NULL THEN
            RETURN -1;
        ELSE
            RETURN Number_Range(expr, nval);
        END IF;
    END;

    FUNCTION Person_Name(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        name VARCHAR2(1024);
    BEGIN
        name := Strip_Person_Degrees(value);
        RETURN String_Like(expr, name);
    END;

    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_t := NULL
            , subject_issue IN V2u_Ko_Subject_Issue_t := NULL
            ) RETURN NUMBER
    IS
    BEGIN
        IF subject_map IS NOT NULL AND subject_issue IS NOT NULL THEN
            RETURN subject_map.match_expr_fields(
                      subj_name => subject_issue.subj_name
                    , university => subject_issue.university
                    , faculty => subject_issue.faculty
                    , studies_modetier => subject_issue.studies_modetier
                    , studies_field => subject_issue.studies_field
                    , studies_specialty => subject_issue.studies_specialty
                    , semester_code => subject_issue.semester_code
                    , subj_hours_w => subject_issue.subj_hours_w
                    , subj_hours_c => subject_issue.subj_hours_c
                    , subj_hours_l => subject_issue.subj_hours_l
                    , subj_hours_p => subject_issue.subj_hours_p
                    , subj_hours_s => subject_issue.subj_hours_s
                    , subj_credit_kind => subject_issue.subj_credit_kind
                    , subj_ects => subject_issue.subj_ects
                    , subj_tutor => subject_issue.subj_tutor
                    );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              specialty_map IN V2u_Specialty_Map_t
            , specialty_issue IN V2u_Ko_Specialty_Issue_t
            ) RETURN NUMBER
    IS
    BEGIN
        IF specialty_map IS NOT NULL AND specialty_issue IS NOT NULL THEN
            RETURN specialty_map.match_expr_fields(
              semester_number => specialty_issue.semester_number
            , semester_code => specialty_issue.semester_code
            , ects_mandatory => specialty_issue.ects_mandatory
            , ects_other => specialty_issue.ects_other
            , ects_total => specialty_issue.ects_total
            );
        ELSE
            RETURN 0;
        END IF;
    END;
END V2U_Match;

-- vim: set ft=sql ts=4 sw=4 et:
