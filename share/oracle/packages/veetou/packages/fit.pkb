CREATE OR REPLACE PACKAGE BODY V2U_Fit AS
    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_t := NULL
            , subject_issue IN V2u_Ko_Subject_Issue_t := NULL
            ) RETURN NUMBER
    IS
    BEGIN
        IF subject_map IS NOT NULL AND subject_issue IS NOT NULL THEN
            RETURN subject_map.match_expr_fields(
                      subj_name => subject_issue.subj_name
                    , university => subject_issue.university
                    , faculty => subject_issue.faculty
                    , studies_modetier => subject_issue.studies_modetier
                    , studies_field => subject_issue.studies_field
                    , studies_specialty => subject_issue.studies_specialty
                    , semester_code => subject_issue.semester_code
                    , subj_hours_w => subject_issue.subj_hours_w
                    , subj_hours_c => subject_issue.subj_hours_c
                    , subj_hours_l => subject_issue.subj_hours_l
                    , subj_hours_p => subject_issue.subj_hours_p
                    , subj_hours_s => subject_issue.subj_hours_s
                    , subj_credit_kind => subject_issue.subj_credit_kind
                    , subj_ects => subject_issue.subj_ects
                    , subj_tutor => subject_issue.subj_tutor
                    );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              specialty_map IN V2u_Specialty_Map_t
            , specialty_issue IN V2u_Ko_Specialty_Issue_t
            ) RETURN NUMBER
    IS
    BEGIN
        IF specialty_map IS NOT NULL AND specialty_issue IS NOT NULL THEN
            RETURN specialty_map.match_expr_fields(
              semester_number => specialty_issue.semester_number
            , semester_code => specialty_issue.semester_code
            , ects_mandatory => specialty_issue.ects_mandatory
            , ects_other => specialty_issue.ects_other
            , ects_total => specialty_issue.ects_total
            );
        ELSE
            RETURN 0;
        END IF;
    END;
END V2U_Fit;

-- vim: set ft=sql ts=4 sw=4 et:
