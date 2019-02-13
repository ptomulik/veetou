CREATE OR REPLACE TYPE BODY V2u_Specialty_Xpr_B_t AS
    CONSTRUCTOR FUNCTION V2u_Specialty_Xpr_B_t(
          SELF IN OUT NOCOPY V2u_Specialty_Xpr_B_t
        , id IN NUMBER
        , expr_university IN VARCHAR2
        , expr_faculty IN VARCHAR2
        , expr_studies_modetier IN VARCHAR2
        , expr_studies_field IN VARCHAR2
        , expr_studies_specialty IN VARCHAR2
        , expr_semester_code IN VARCHAR2
        , expr_semester_number IN VARCHAR2
        , expr_ects_mandatory IN VARCHAR2
        , expr_ects_other IN VARCHAR2
        , expr_ects_total IN VARCHAR2
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
          id => id
        , expr_university => expr_university
        , expr_faculty => expr_faculty
        , expr_studies_modetier => expr_studies_modetier
        , expr_studies_field => expr_studies_field
        , expr_studies_specialty => expr_studies_specialty
        , expr_semester_code => expr_semester_code
        , expr_semester_number => expr_semester_number
        , expr_ects_mandatory => expr_ects_mandatory
        , expr_ects_other => expr_ects_other
        , expr_ects_total => expr_ects_total
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Xpr_B_t
            , id IN NUMBER := NULL
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_university := expr_university;
        SELF.expr_faculty := expr_faculty;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.expr_studies_field := expr_studies_field;
        SELF.expr_studies_specialty := expr_studies_specialty;
        -- call base init() of base class
        SELF.init(
              id => id
            , expr_semester_code => expr_semester_code
            , expr_semester_number => expr_semester_number
            , expr_ects_mandatory => expr_ects_mandatory
            , expr_ects_other => expr_ects_other
            , expr_ects_total => expr_ects_total
        );
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Specialty_Xpr_B_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Specialty_Xpr_B_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(expr_university, other.expr_university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_faculty, other.expr_faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_studies_modetier, other.expr_studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_studies_field, other.expr_studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_studies_specialty, other.expr_studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        -- delegate rest of the job to the supertype
        RETURN (SELF as V2u_Semester_Xpr_B_t).cmp_val(other);
    END;

    MEMBER FUNCTION match_xpr_attrs(
          university IN VARCHAR2
        , faculty IN VARCHAR2
        , studies_modetier IN VARCHAR2
        , studies_field IN VARCHAR2
        , studies_specialty IN VARCHAR2
        , semester_code IN VARCHAR2
        , semester_number IN VARCHAR2
        , ects_mandatory IN VARCHAR2
        , ects_other IN VARCHAR2
        , ects_total IN VARCHAR2
        ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        total := 1;     -- if all expressions are NULL, then match is positive
        IF expr_university IS NOT NULL THEN
            local := match_university(university);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_faculty IS NOT NULL THEN
            local := match_faculty(faculty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_modetier IS NOT NULL THEN
            local := match_studies_modetier(studies_modetier);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_field IS NOT NULL THEN
            local := match_studies_field(studies_field);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_specialty IS NOT NULL THEN
            local := match_studies_specialty(studies_specialty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;

        local := SELF.match_xpr_attrs(
                          semester_code => semester_code
                        , semester_number => semester_number
                        , ects_mandatory => ects_mandatory
                        , ects_other => ects_other
                        , ects_total => ects_total
                        );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        RETURN total;
    END;


    MEMBER FUNCTION match_university(university IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_university, university);
    END;


    MEMBER FUNCTION match_faculty(faculty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_faculty, faculty);
    END;


    MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_modetier, studies_modetier);
    END;


    MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_field, studies_field);
    END;


    MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_specialty, studies_specialty);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
