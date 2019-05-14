CREATE OR REPLACE TYPE BODY V2u_Subject_Map_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Subject_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_subj_ects IN NUMBER
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subj_code => subj_code
            , map_subj_code => map_subj_code
            , map_subj_lang => map_subj_lang
            , map_subj_ects => map_subj_ects
            , map_org_unit => map_org_unit
            , map_org_unit_recipient => map_org_unit_recipient
            , subject_pattern => subject_pattern
            , specialty_pattern => specialty_pattern
            , semester_pattern => semester_pattern
            );
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Subject_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subject_map IN V2u_Subject_Map_B_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(subject_map);
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_subj_lang IN VARCHAR2
            , map_subj_ects IN NUMBER
            , map_org_unit IN VARCHAR2
            , map_org_unit_recipient IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            )
    IS
    BEGIN
        SELF.subj_code := subj_code;
        SELF.map_subj_code := map_subj_code;
        SELF.map_subj_lang := map_subj_lang;
        SELF.map_subj_ects := map_subj_ects;
        SELF.map_org_unit := map_org_unit;
        SELF.map_org_unit_recipient := map_org_unit_recipient;
        SELF.subject_pattern := subject_pattern;
        SELF.specialty_pattern := specialty_pattern;
        SELF.semester_pattern := semester_pattern;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Subject_Map_Pattern_t
            , subject_map IN V2u_Subject_Map_B_t
            )
    IS
    BEGIN
        SELF.init(
              subj_code => subject_map.subj_code
            , map_subj_code => subject_map.map_subj_code
            , map_subj_lang => subject_map.map_subj_lang
            , map_subj_ects => subject_map.map_subj_ects
            , map_org_unit => subject_map.map_org_unit
            , map_org_unit_recipient => subject_map.map_org_unit_recipient
            , subject_pattern => V2u_Subject_Pattern_t(
                      expr_subj_name => subject_map.expr_subj_name
                    , expr_subj_hours_w => subject_map.expr_subj_hours_w
                    , expr_subj_hours_c => subject_map.expr_subj_hours_c
                    , expr_subj_hours_l => subject_map.expr_subj_hours_l
                    , expr_subj_hours_p => subject_map.expr_subj_hours_p
                    , expr_subj_hours_s => subject_map.expr_subj_hours_s
                    , expr_subj_credit_kind => subject_map.expr_subj_credit_kind
                    , expr_subj_ects => subject_map.expr_subj_ects
                    , expr_subj_tutor => subject_map.expr_subj_tutor
                    )
            , specialty_pattern => V2u_Specialty_Pattern_t(
                      expr_university => subject_map.expr_university
                    , expr_faculty => subject_map.expr_faculty
                    , expr_studies_modetier => subject_map.expr_studies_modetier
                    , expr_studies_field => subject_map.expr_studies_field
                    , expr_studies_specialty => subject_map.expr_studies_specialty
                    )
            , semester_pattern => V2u_Semester_Pattern_t(
                      expr_semester_code => subject_map.expr_semester_code
                    , expr_semester_number => subject_map.expr_semester_number
                    , expr_ects_mandatory => subject_map.expr_ects_mandatory
                    , expr_ects_other => subject_map.expr_ects_other
                    , expr_ects_total => subject_map.expr_ects_total
                    )
            );
    END;

    MEMBER FUNCTION match_attributes(
              subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        total := 1;
        local := subject_pattern.match_attributes(
                      subj_name => subj_name
                    , subj_hours_w => subj_hours_w
                    , subj_hours_c => subj_hours_c
                    , subj_hours_l => subj_hours_l
                    , subj_hours_p => subj_hours_p
                    , subj_hours_s => subj_hours_s
                    , subj_credit_kind => subj_credit_kind
                    , subj_ects => subj_ects
                    , subj_tutor => subj_tutor
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := specialty_pattern.match_attributes(
                      university => university
                    , faculty => faculty
                    , studies_modetier => studies_modetier
                    , studies_field => studies_field
                    , studies_specialty => studies_specialty
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := semester_pattern.match_attributes(
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

        -- bonus for map_subj_code being NOT NULL
        IF map_subj_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
