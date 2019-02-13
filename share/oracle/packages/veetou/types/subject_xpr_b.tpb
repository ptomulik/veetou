CREATE OR REPLACE TYPE BODY V2u_Subject_Xpr_B_t AS
    CONSTRUCTOR FUNCTION V2u_Subject_Xpr_B_t(
              SELF IN OUT NOCOPY V2u_Subject_Xpr_B_t
            , id IN NUMBER
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
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
            , expr_subj_name => expr_subj_name
            , expr_subj_hours_w => expr_subj_hours_w
            , expr_subj_hours_c => expr_subj_hours_c
            , expr_subj_hours_l => expr_subj_hours_l
            , expr_subj_hours_p => expr_subj_hours_p
            , expr_subj_hours_s => expr_subj_hours_s
            , expr_subj_credit_kind => expr_subj_credit_kind
            , expr_subj_ects => expr_subj_ects
            , expr_subj_tutor => expr_subj_tutor
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
              SELF IN OUT NOCOPY V2u_Subject_Xpr_B_t
            , id IN NUMBER := NULL
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
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
        SELF.expr_subj_name := expr_subj_name;
        SELF.expr_subj_hours_w := expr_subj_hours_w;
        SELF.expr_subj_hours_c := expr_subj_hours_c;
        SELF.expr_subj_hours_l := expr_subj_hours_l;
        SELF.expr_subj_hours_p := expr_subj_hours_p;
        SELF.expr_subj_hours_s := expr_subj_hours_s;
        SELF.expr_subj_credit_kind := expr_subj_credit_kind;
        SELF.expr_subj_ects := expr_subj_ects;
        SELF.expr_subj_tutor := expr_subj_tutor;
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
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Subject_Xpr_B_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Subject_Xpr_B_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(expr_subj_name, other.expr_subj_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_hours_w, other.expr_subj_hours_w);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_hours_c, other.expr_subj_hours_c);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_hours_l, other.expr_subj_hours_l);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_hours_p, other.expr_subj_hours_p);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_hours_s, other.expr_subj_hours_s);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_credit_kind, other.expr_subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_ects, other.expr_subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_tutor, other.expr_subj_tutor);
        IF ord <> 0 THEN RETURN ord; END IF;
        -- delegate rest of the work to the supertype
        RETURN (SELF AS V2u_Specialty_Xpr_B_t).cmp_val(other);
    END;

    MEMBER FUNCTION match_xpr_attrs(
              subj_name IN VARCHAR2
            , subj_hours_w IN VARCHAR2
            , subj_hours_c IN VARCHAR2
            , subj_hours_l IN VARCHAR2
            , subj_hours_p IN VARCHAR2
            , subj_hours_s IN VARCHAR2
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN VARCHAR2
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
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
        IF expr_subj_name IS NOT NULL THEN
            local := match_subj_name(subj_name);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_hours_w IS NOT NULL THEN
            local := match_subj_hours_w(subj_hours_w);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_hours_c IS NOT NULL THEN
            local := match_subj_hours_c(subj_hours_c);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_hours_l IS NOT NULL THEN
            local := match_subj_hours_l(subj_hours_l);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_hours_p IS NOT NULL THEN
            local := match_subj_hours_p(subj_hours_p);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_hours_s IS NOT NULL THEN
            local := match_subj_hours_s(subj_hours_s);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_credit_kind IS NOT NULL THEN
            local := match_subj_credit_kind(subj_credit_kind);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_ects IS NOT NULL THEN
            local := match_subj_ects(subj_ects);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_tutor IS NOT NULL THEN
            local := match_subj_tutor(subj_tutor);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;

        local := SELF.match_xpr_attrs(
                      university => university
                    , faculty => faculty
                    , studies_modetier => studies_modetier
                    , studies_field => studies_field
                    , studies_specialty => studies_specialty
                    , semester_code => semester_code
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


    MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_name, subj_name);
    END;


    MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_w, subj_hours_w);
    END;


    MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_c, subj_hours_c);
    END;


    MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_l, subj_hours_l);
    END;


    MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_p, subj_hours_p);
    END;


    MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_s, subj_hours_s);
    END;


    MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_credit_kind, subj_credit_kind);
    END;


    MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_ects, subj_ects);
    END;


    MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Person_Name(expr_subj_tutor, subj_tutor);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
