CREATE OR REPLACE TYPE BODY V2u_Subject_Map_Base_t AS
    CONSTRUCTOR FUNCTION V2u_Subject_Map_Base_t(
          SELF IN OUT NOCOPY V2u_Subject_Map_Base_t
        , id IN NUMBER
        , subj_code IN VARCHAR2
        , map_subj_code IN VARCHAR2
        , map_subj_lang IN VARCHAR2
        , map_org_unit IN VARCHAR2
        , map_org_unit_recipient IN VARCHAR2
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
        , subj_code => subj_code
        , map_subj_code => map_subj_code
        , map_subj_lang => map_subj_lang
        , map_org_unit => map_org_unit
        , map_org_unit_recipient => map_org_unit_recipient
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
              SELF IN OUT NOCOPY V2u_Subject_Map_Base_t
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
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
        SELF.subj_code := subj_code;
        SELF.map_subj_code := map_subj_code;
        SELF.map_subj_lang := map_subj_lang;
        SELF.map_org_unit := map_org_unit;
        SELF.map_org_unit_recipient := map_org_unit_recipient;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Subject_Map_Base_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Subject_Map_Base_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(subj_code, other.subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_subj_code, other.map_subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_subj_lang, other.map_subj_lang);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_org_unit, other.map_org_unit);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_org_unit_recipient, other.map_org_unit_recipient);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN (SELF AS V2u_Map_Base_t).cmp_val(other);
    END;

    OVERRIDING MEMBER FUNCTION match_xpr_attrs(
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
            )
        RETURN INTEGER
    IS
        total INTEGER;
    BEGIN
        total := (SELF AS V2u_Map_Base_t).match_xpr_attrs(
              subj_name => subj_name
            , subj_hours_w => subj_hours_w
            , subj_hours_c => subj_hours_c
            , subj_hours_l => subj_hours_l
            , subj_hours_p => subj_hours_p
            , subj_hours_s => subj_hours_s
            , subj_credit_kind => subj_credit_kind
            , subj_ects => subj_ects
            , subj_tutor => subj_tutor
            , university => university
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
        IF total < 1 THEN
            RETURN total;
        END IF;
        -- bonus for map_subj_code being not NULL
        IF map_subj_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
