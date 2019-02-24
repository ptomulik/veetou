CREATE OR REPLACE PACKAGE BODY V2U_Get AS
    FUNCTION University(abbriev IN VARCHAR2 := NULL, name IN VARCHAR2 := NULL)
        RETURN V2u_University_t
    IS
        l_university V2u_University_t;
    BEGIN
        -- Parameter names are prefixed with 'University.' to resolve the
        -- problem with column name precedence in SELECT INTO query.
        -- https://docs.oracle.com/database/121/LNPLS/nameresolution.htm#LNPLS2154
        IF abbriev IS NOT NULL THEN
            IF name IS NOT NULL THEN
                SELECT VALUE(u) INTO l_university FROM v2u_universities u
                    WHERE u.abbriev = University.abbriev AND
                          UPPER(u.name) = UPPER(University.name);
            ELSE
                SELECT VALUE(u) INTO l_university FROM v2u_universities u
                    WHERE u.abbriev = University.abbriev;
            END IF;
        ELSIF name is NOT NULL THEN
            SELECT VALUE(u) INTO l_university FROM v2u_universities u
                WHERE UPPER(u.name) = UPPER(University.name);
        ELSE
            RAISE VALUE_ERROR;
        END IF;
        RETURN l_university;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.Put_Line('University not found for name="' || name || '"');
            RAISE;
    END;


    FUNCTION Faculty(abbriev IN VARCHAR2 := NULL, name IN VARCHAR2 := NULL)
        RETURN V2u_Faculty_t
    IS
        l_faculty V2u_Faculty_t;
    BEGIN
        -- Parameter names are prefixed with 'Faculty.' to resolve the
        -- problem with column name precedence in SELECT INTO query.
        -- https://docs.oracle.com/database/121/LNPLS/nameresolution.htm#LNPLS2154
        IF abbriev IS NOT NULL THEN
            IF name IS NOT NULL THEN
                SELECT VALUE(u) INTO l_faculty FROM v2u_faculties u
                    WHERE u.abbriev = Faculty.abbriev AND
                          UPPER(u.name) = UPPER(Faculty.name);
            ELSE
                SELECT VALUE(u) INTO l_faculty FROM v2u_faculties u
                    WHERE u.abbriev = Faculty.abbriev;
            END IF;
        ELSIF name is NOT NULL THEN
            SELECT VALUE(u) INTO l_faculty FROM v2u_faculties u
                WHERE UPPER(u.name) = UPPER(Faculty.name);
        ELSE
            RAISE VALUE_ERROR;
        END IF;
        RETURN l_faculty;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.Put_Line('Faculty not found for name="' || name || '"');
            RAISE;
    END;


    FUNCTION Semester(code IN VARCHAR2)
        RETURN V2u_Semester_t
    IS
        l_semester V2u_Semester_t;
    BEGIN
        SELECT VALUE(s) INTO l_semester FROM v2u_semesters s
            WHERE UPPER(s.code) = UPPER(Semester.code);
        RETURN l_semester;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.Put_Line('Semester not found for code="' || code || '"');
            RAISE;
    END;


    FUNCTION Semester(id IN NUMBER)
        RETURN V2u_Semester_t
    IS
        l_semester V2u_Semester_t;
    BEGIN
        SELECT VALUE(s) INTO l_semester FROM v2u_semesters s
            WHERE s.id = Semester.id;
        RETURN l_semester;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.Put_Line('Semester not found for id="' || id || '"');
            RAISE;
    END;


    FUNCTION Tpro_Kod(
              subj_credit_kind IN VARCHAR2
            , subj_grades IN V2u_Subj_Grades_t
            ) RETURN VARCHAR2
    IS
        code VARCHAR2(1 CHAR);
        cred VARCHAR2(3 CHAR);
        num_grades V2u_Subj_Grades_t := V2u_Subj_Grades_t(
              '2,0'
            , '2,5'
            , '3,0'
            , '3,5'
            , '4,0'
            , '4,5'
            , '5,0'
        );
        sym_grades V2u_Subj_Grades_t := V2u_Subj_Grades_t(
              'Zal'
            , 'Nzal'
            , 'Zw'
        );
        num_grades_i V2u_Subj_Grades_t := V2u_Subj_Grades_t();
        sym_grades_i V2u_Subj_Grades_t := V2u_Subj_Grades_t();
        num_cnt INTEGER;
        sym_cnt INTEGER;
    BEGIN
        cred := UPPER(SUBSTR(subj_credit_kind, 1, 3));
        num_grades_i := (subj_grades MULTISET INTERSECT num_grades);
        sym_grades_i := (subj_grades MULTISET INTERSECT sym_grades);
        num_cnt := num_grades_i.COUNT;
        sym_cnt := sym_grades_i.COUNT;
        IF num_cnt > 0 AND sym_cnt = 0 THEN
            CASE cred
                WHEN 'EGZ' THEN code := 'E';
                WHEN 'ZAL' THEN code := 'S';
                ELSE code := '?';
            END CASE;
        ELSIF num_cnt = 0 AND sym_cnt > 0 THEN
            CASE cred
                WHEN 'EGZ' THEN code := '?';
                WHEN 'ZAL' THEN code := 'Z';
                ELSE code := '?';
            END CASE;
        ELSE
            code := '?';
        END IF;
        RETURN code;
    END;


    FUNCTION Utw_Id(job_uuid IN RAW)
            RETURN VARCHAR2
    IS
    BEGIN
        RETURN Mod_Id(job_uuid => job_uuid);
    END;


    FUNCTION Mod_Id(job_uuid IN RAW)
            RETURN VARCHAR2
    IS
    BEGIN
        RETURN SUBSTR(('V2U:' || RAWTOHEX(job_uuid)), 1, 30);
    END;

    FUNCTION Alt_Prg_Code(specialty IN V2u_Ko_Specialty_t)
            RETURN VARCHAR2 DETERMINISTIC
    IS
    BEGIN
        RETURN
            specialty.university
            || ':' ||
            specialty.faculty
            || ':' ||
            specialty.studies_modetier
            || ':' ||
            specialty.studies_field
            || ':' ||
            specialty.studies_specialty
            ;
    END;


    FUNCTION Studies_Mode(studies_modetier IN VARCHAR2)
            RETURN VARCHAR2
    IS
        l_mode VARCHAR2(256 CHAR);
        r1 CONSTANT VARCHAR2(100 CHAR) := 'studia +((stacjonarne)|(niestacjonarne( +(zaoczne|wieczorowe))?))';
        r2 CONSTANT VARCHAR2(100 CHAR) := '\w+( +\w+)*';
    BEGIN
        l_mode := REGEXP_REPLACE(
                  studies_modetier
                , r1 || ' +' || r2
                , '\1', 1, 0, 'i'
            );
        IF l_mode <> studies_modetier THEN
            l_mode := LOWER(l_mode);
            l_mode := REGEXP_REPLACE(l_mode, ' +', ' ');
            RETURN l_mode;
        END IF;
        RETURN '?';
    END;


    FUNCTION Studies_Tier(studies_modetier IN VARCHAR2)
            RETURN VARCHAR2
    IS
        l_tier VARCHAR2(256 CHAR);
        r1 CONSTANT VARCHAR2(100 CHAR) := 'studia +\w+( +\w+)*';
        r2 CONSTANT VARCHAR2(100 CHAR) := '((\w+ +stopnia)|(\w+ +jednolite)|podyplomowe)';
    BEGIN
        l_tier := REGEXP_REPLACE(
              studies_modetier
            , r1 || ' +' || r2
            , '\2' , 1, 0, 'i'
        );
        IF l_tier <> studies_modetier THEN
            l_tier := LOWER(l_tier);
            l_tier := REGEXP_REPLACE(l_tier, ' +', ' ');
            l_tier := REGEXP_REPLACE(l_tier, '(\w+) +jednolite', 'jednolite \1');
            RETURN l_tier;
        END IF;
        RETURN '?';
    END;


    FUNCTION Studies_Program_Description(
              studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            ) RETURN VARCHAR2
    IS
        l_mode VARCHAR2(256 CHAR);
        l_tier VARCHAR2(256 CHAR);
        l_desc VARCHAR2(1000 CHAR);
    BEGIN
        l_mode := Studies_Mode(studies_modetier);
        IF l_mode = '?' THEN
            RETURN '?';
        END IF;
        l_tier := Studies_Tier(studies_modetier);
        IF l_tier = '?' THEN
            RETURN '?';
        END IF;
        l_desc := studies_field;
        IF l_tier <> 'podyplomowe' THEN
            l_desc := l_desc || ', studia ' || l_mode || ' ' || l_tier;
        END IF;
        RETURN l_desc;
    END;


    FUNCTION Studies_Program_Description(specialty IN V2u_Ko_Specialty_t)
            RETURN VARCHAR2
    IS
    BEGIN
        RETURN Studies_Program_Description(
                  studies_modetier => specialty.studies_modetier
                , studies_field => specialty.studies_field
                , studies_specialty => specialty.studies_specialty
                );
    END;


    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semesters_t)
        RETURN VARCHAR2
    IS
        lowest V2u_Ko_Semester_t;
    BEGIN
        SELECT VALUE(s) INTO lowest
            FROM TABLE(semesters) s
            WHERE ROWNUM <= 1
            ORDER BY 1;
        RETURN V2u_Semester_t.sem_sub(lowest.semester_code, (lowest.semester_number-1));
    END;
END V2U_Get;

-- vim: set ft=sql ts=4 sw=4 et:
