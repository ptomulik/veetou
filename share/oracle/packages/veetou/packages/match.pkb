CREATE OR REPLACE PACKAGE BODY V2U_Match AS

    FUNCTION Strip_Person_Degrees(value IN VARCHAR)
        RETURN VARCHAR
    IS
        SUBTYPE Degree_Typ IS VARCHAR(10);
        TYPE Degrees_Array IS VARRAY(20) OF Degree_Typ;
        n NUMBER;
        s VARCHAR(1024);
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

    FUNCTION String_Like(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
    BEGIN
        RETURN CASE (value LIKE expr) WHEN TRUE THEN 1 ELSE 0 END;
    END;

    FUNCTION String_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;

        DBMS_Output.Put_Line('smin: ' || smin || ', smax: ' || smax);

        IF smin IS NOT NULL AND V2U_Util.StrCmp(smin, value) > 0 THEN
            RETURN 0;
        ELSIF smax IS NOT NULL AND V2U_Util.StrCmp(value, smax) > 0 THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;


    FUNCTION Code_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
    BEGIN
        RETURN String_Range(UPPER(expr), UPPER(value));
    END;

    FUNCTION Number_Range(expr IN VARCHAR, value IN NUMBER)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
        nmin NUMBER;
        nmax NUMBER;
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;
        nmin := V2U_Util.To_Number_Or_Null(smin);
        nmax := V2U_Util.To_Number_Or_Null(smax);
        IF nmin IS NOT NULL AND nmin > value THEN
            RETURN 0;
        ELSIF nmax IS NOT NULL AND value > nmax THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;

    FUNCTION Number_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
        nval NUMBER;
    BEGIN
        nval := V2U_Util.To_Number_Or_Null(value);
        IF nval IS NULL THEN
            RETURN -1;
        ELSE
            RETURN Number_Range(expr, nval);
        END IF;
    END;

    FUNCTION Person_Name(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        name VARCHAR(1024);
    BEGIN
        name := Strip_Person_Degrees(value);
        RETURN String_Like(expr, name);
    END;

    FUNCTION Expr_Fields(
              subject_mapping IN V2u_Subject_Mapping_t
            , subject_instance IN V2u_Ko_Subject_Instance_t
            ) RETURN NUMBER
    IS
    BEGIN
        RETURN subject_mapping.match_expr_fields(
                  subj_name => subject_instance.subj_name
                , university => subject_instance.university
                , faculty => subject_instance.faculty
                , studies_modetier => subject_instance.studies_modetier
                , studies_field => subject_instance.studies_field
                , studies_specialty => subject_instance.studies_specialty
                , semester_code => subject_instance.semester_code
                , subj_hours_w => subject_instance.subj_hours_w
                , subj_hours_c => subject_instance.subj_hours_c
                , subj_hours_l => subject_instance.subj_hours_l
                , subj_hours_p => subject_instance.subj_hours_p
                , subj_hours_s => subject_instance.subj_hours_s
                , subj_credit_kind => subject_instance.subj_credit_kind
                , subj_ects => subject_instance.subj_ects
                , subj_tutor => subject_instance.subj_tutor
                );
    END;
END V2U_Match;

-- vim: set ft=sql ts=4 sw=4 et:
