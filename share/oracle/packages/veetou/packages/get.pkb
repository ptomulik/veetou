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
END V2U_Get;

-- vim: set ft=sql ts=4 sw=4 et: