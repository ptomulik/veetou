CREATE OR REPLACE TYPE BODY V2u_Classes_Map_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Classes_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Classes_Map_Pattern_t
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , classes_pattern IN V2u_Classes_Pattern_t
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              classes_type => classes_type
            , map_classes_type => map_classes_type
            , classes_pattern => classes_pattern
            , subject_pattern => subject_pattern
            , specialty_pattern => specialty_pattern
            , semester_pattern => semester_pattern
            );
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Classes_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Classes_Map_Pattern_t
            , classes_map IN V2u_Classes_Map_B_t
            ) RETURN SELF AS RESULT

    IS
    BEGIN
        SELF.init(classes_map);
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Map_Pattern_t
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , classes_pattern IN V2u_Classes_Pattern_t
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            )
    IS
    BEGIN
        SELF.classes_type := classes_type;
        SELF.map_classes_type := map_classes_type;
        SELF.expr_subj_code := expr_subj_code;
        SELF.classes_pattern := classes_pattern;
        SELF.subject_pattern := subject_pattern;
        SELF.specialty_pattern := specialty_pattern;
        SELF.semester_pattern := semester_pattern;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Map_Pattern_t
            , classes_map IN V2u_Classes_Map_B_t
            )
    IS
    BEGIN
        SELF.init(
              classes_type => classes_map.classes_type
            , map_classes_type => classes_map.map_classes_type
            , classes_pattern => V2u_Classes_Pattern_t(
                      expr_subj_code => classes_map.expr_subj_code
                    )
            , subject_pattern => V2u_Subject_Pattern_t(
                      expr_subj_name => classes_map.expr_subj_name
                    , expr_subj_hours_w => classes_map.expr_subj_hours_w
                    , expr_subj_hours_c => classes_map.expr_subj_hours_c
                    , expr_subj_hours_l => classes_map.expr_subj_hours_l
                    , expr_subj_hours_p => classes_map.expr_subj_hours_p
                    , expr_subj_hours_s => classes_map.expr_subj_hours_s
                    , expr_subj_credit_kind => classes_map.expr_subj_credit_kind
                    , expr_subj_ects => classes_map.expr_subj_ects
                    , expr_subj_tutor => classes_map.expr_subj_tutor
                    )
            , specialty_pattern => V2u_Specialty_Pattern_t(
                      expr_university => classes_map.expr_university
                    , expr_faculty => classes_map.expr_faculty
                    , expr_studies_modetier => classes_map.expr_studies_modetier
                    , expr_studies_field => classes_map.expr_studies_field
                    , expr_studies_specialty => classes_map.expr_studies_specialty
                    )
            , semester_pattern => V2u_Semester_Pattern_t(
                      expr_semester_code => classes_map.expr_semester_code
                    , expr_semester_number => classes_map.expr_semester_number
                    , expr_ects_mandatory => classes_map.expr_ects_mandatory
                    , expr_ects_other => classes_map.expr_ects_other
                    , expr_ects_total => classes_map.expr_ects_total
                    )
            );
    END;


    MEMBER FUNCTION match_attributes(
          subj_code IN VARCHAR2
        , subj_name IN VARCHAR2
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
        local := classes_pattern.match_attributes(
                       subj_code => subj_code
                     );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

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

        -- bonus for map_classes_type being not NULL
        IF map_classes_type IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;

    MEMBER FUNCTION match_subj_code(subj_code IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_code, subj_code);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
