--CREATE OR REPLACE TYPE BODY V2u_Classes_Map_t AS
--    CONSTRUCTOR FUNCTION V2u_Classes_Map_t(
--              SELF IN OUT NOCOPY V2u_Classes_Map_t
--            , id IN NUMBER
--            , classes_type IN VARCHAR2
--            , map_classes_type IN VARCHAR2
--            , expr_subj_code IN VARCHAR2
--            , expr_subj_name IN VARCHAR2
--            , expr_subj_hours_w IN VARCHAR2
--            , expr_subj_hours_c IN VARCHAR2
--            , expr_subj_hours_l IN VARCHAR2
--            , expr_subj_hours_p IN VARCHAR2
--            , expr_subj_hours_s IN VARCHAR2
--            , expr_subj_credit_kind IN VARCHAR2
--            , expr_subj_ects IN VARCHAR2
--            , expr_subj_tutor IN VARCHAR2
--            , expr_university IN VARCHAR2
--            , expr_faculty IN VARCHAR2
--            , expr_studies_modetier IN VARCHAR2
--            , expr_studies_field IN VARCHAR2
--            , expr_studies_specialty IN VARCHAR2
--            , expr_semester_code IN VARCHAR2
--            , expr_semester_number IN VARCHAR2
--            , expr_ects_mandatory IN VARCHAR2
--            , expr_ects_other IN VARCHAR2
--            , expr_ects_total IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              id => id
--            , classes_type => classes_type
--            , map_classes_type => map_classes_type
--            , expr_subj_code => expr_subj_code
--            , expr_subj_name => expr_subj_name
--            , expr_subj_hours_w => expr_subj_hours_w
--            , expr_subj_hours_c => expr_subj_hours_c
--            , expr_subj_hours_l => expr_subj_hours_l
--            , expr_subj_hours_p => expr_subj_hours_p
--            , expr_subj_hours_s => expr_subj_hours_s
--            , expr_subj_credit_kind => expr_subj_credit_kind
--            , expr_subj_ects => expr_subj_ects
--            , expr_subj_tutor => expr_subj_tutor
--            , expr_university => expr_university
--            , expr_faculty => expr_faculty
--            , expr_studies_modetier => expr_studies_modetier
--            , expr_studies_field => expr_studies_field
--            , expr_studies_specialty => expr_studies_specialty
--            , expr_semester_code => expr_semester_code
--            , expr_semester_number => expr_semester_number
--            , expr_ects_mandatory => expr_ects_mandatory
--            , expr_ects_other => expr_ects_other
--            , expr_ects_total => expr_ects_total
--            );
--        RETURN;
--    END;
--END;

-- vim: set ft=sql ts=4 sw=4 et:
