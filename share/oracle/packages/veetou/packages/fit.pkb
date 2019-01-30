CREATE OR REPLACE PACKAGE BODY V2U_Fit AS
    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_t := NULL
            , subject_entity IN V2u_Ko_Subject_Entity_t := NULL
            ) RETURN NUMBER
    IS
    BEGIN
        IF subject_map IS NOT NULL AND subject_entity IS NOT NULL THEN
            RETURN subject_map.match_expr_fields(
                      subj_name => subject_entity.subj_name
                    , university => subject_entity.university
                    , faculty => subject_entity.faculty
                    , studies_modetier => subject_entity.studies_modetier
                    , studies_field => subject_entity.studies_field
                    , studies_specialty => subject_entity.studies_specialty
                    , semester_code => subject_entity.semester_code
                    , subj_hours_w => subject_entity.subj_hours_w
                    , subj_hours_c => subject_entity.subj_hours_c
                    , subj_hours_l => subject_entity.subj_hours_l
                    , subj_hours_p => subject_entity.subj_hours_p
                    , subj_hours_s => subject_entity.subj_hours_s
                    , subj_credit_kind => subject_entity.subj_credit_kind
                    , subj_ects => subject_entity.subj_ects
                    , subj_tutor => subject_entity.subj_tutor
                    );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              specialty_map IN V2u_Specialty_Map_t
            , specialty_entity IN V2u_Ko_SpecSem_t
            ) RETURN NUMBER
    IS
    BEGIN
        IF specialty_map IS NOT NULL AND specialty_entity IS NOT NULL THEN
            RETURN specialty_map.match_expr_fields(
              semester_number => specialty_entity.semester_number
            , semester_code => specialty_entity.semester_code
            , ects_mandatory => specialty_entity.ects_mandatory
            , ects_other => specialty_entity.ects_other
            , ects_total => specialty_entity.ects_total
            );
        ELSE
            RETURN 0;
        END IF;
    END;
END V2U_Fit;

-- vim: set ft=sql ts=4 sw=4 et:
