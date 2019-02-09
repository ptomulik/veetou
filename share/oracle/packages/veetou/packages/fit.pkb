CREATE OR REPLACE PACKAGE BODY V2U_Fit AS
    FUNCTION Attributes(
              classes_map IN V2u_Classes_Map_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN NUMBER
    IS
    BEGIN
        IF classes_map IS NOT NULL AND
           subject IS NOT NULL AND
           specialty IS NOT NULL AND
           semester IS NOT NULL
        THEN
            RETURN classes_map.match_expr_fields(
                      subj_code => subject.subj_code
                    , subj_name => subject.subj_name
                    , subj_hours_w => subject.subj_hours_w
                    , subj_hours_c => subject.subj_hours_c
                    , subj_hours_l => subject.subj_hours_l
                    , subj_hours_p => subject.subj_hours_p
                    , subj_hours_s => subject.subj_hours_s
                    , subj_credit_kind => subject.subj_credit_kind
                    , subj_ects => subject.subj_ects
                    , subj_tutor => subject.subj_tutor
                    , university => specialty.university
                    , faculty => specialty.faculty
                    , studies_modetier => specialty.studies_modetier
                    , studies_field => specialty.studies_field
                    , studies_specialty => specialty.studies_specialty
                    , semester_code => semester.semester_code
                    , semester_number => semester.semester_number
                    , ects_mandatory => semester.ects_mandatory
                    , ects_other => semester.ects_other
                    , ects_total => semester.ects_total
                    );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN NUMBER
    IS
    BEGIN
        IF subject_map IS NOT NULL AND
           subject IS NOT NULL AND
           specialty IS NOT NULL AND
           semester IS NOT NULL
        THEN
            RETURN subject_map.match_expr_fields(
                      subj_name => subject.subj_name
                    , subj_hours_w => subject.subj_hours_w
                    , subj_hours_c => subject.subj_hours_c
                    , subj_hours_l => subject.subj_hours_l
                    , subj_hours_p => subject.subj_hours_p
                    , subj_hours_s => subject.subj_hours_s
                    , subj_credit_kind => subject.subj_credit_kind
                    , subj_ects => subject.subj_ects
                    , subj_tutor => subject.subj_tutor
                    , university => specialty.university
                    , faculty => specialty.faculty
                    , studies_modetier => specialty.studies_modetier
                    , studies_field => specialty.studies_field
                    , studies_specialty => specialty.studies_specialty
                    , semester_code => semester.semester_code
                    , semester_number => semester.semester_number
                    , ects_mandatory => semester.ects_mandatory
                    , ects_other => semester.ects_other
                    , ects_total => semester.ects_total
                    );
        ELSE
            RETURN 0;
        END IF;
    END;


    FUNCTION Attributes(
                  specialty_map IN V2u_Specialty_Map_t
                , semester IN V2u_Ko_Semester_t
                ) RETURN NUMBER
    IS
    BEGIN
        IF specialty_map IS NOT NULL AND semester IS NOT NULL THEN
            RETURN specialty_map.match_expr_fields(
              semester_number => semester.semester_number
            , semester_code => semester.semester_code
            , ects_mandatory => semester.ects_mandatory
            , ects_other => semester.ects_other
            , ects_total => semester.ects_total
            );
        ELSE
            RETURN 0;
        END IF;
    END;
END V2U_Fit;

-- vim: set ft=sql ts=4 sw=4 et:
