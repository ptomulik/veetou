CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Subject_Map_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Subject_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subject_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subject_Map_V_t
            , id IN NUMBER := NULL
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    IS
    BEGIN
        IF semester.job_uuid <> subject.job_uuid THEN
            RAISE_APPLICATION_ERROR(
                  -20101
                , 'job_uuid missmatch in V2u_Ko_Missing_Subject_Map_V_t.init:' ||
                  ' semester.job_uuid='  || RAWTOHEX(semester.job_uuid) ||
                  ' subject.job_uuid=' || RAWTOHEX(subject.job_uuid)
                );
        END IF;
        IF specialty.job_uuid <> subject.job_uuid THEN
            RAISE_APPLICATION_ERROR(
                  -20101
                , 'job_uuid missmatch in V2u_Ko_Missing_Subject_Map_V_t.init:' ||
                  ' specialty.job_uuid='  || RAWTOHEX(specialty.job_uuid) ||
                  ' subject.job_uuid=' || RAWTOHEX(subject.job_uuid)
                );
        END IF;
        SELF.init(
              id => id
            , subj_code => subject.subj_code
            , map_subj_code => NULL
            , usr_subj_name => NULL
            , map_subj_lang => NULL
            , map_subj_ects => NULL
            , map_subj_name => NULL
            , map_org_unit => NULL
            , map_org_unit_recipient => NULL
            , map_proto_type => NULL
            , map_grade_type => NULL
            , expr_subj_name => subject.subj_name
            , expr_subj_hours_w => subject.subj_hours_w
            , expr_subj_hours_c => subject.subj_hours_c
            , expr_subj_hours_l => subject.subj_hours_l
            , expr_subj_hours_p => subject.subj_hours_p
            , expr_subj_hours_s => subject.subj_hours_s
            , expr_subj_credit_kind => subject.subj_credit_kind
            , expr_subj_ects => TO_CHAR(subject.subj_ects)
            , expr_subj_tutor => TO_CHAR(subject.subj_tutor)
            , expr_university => specialty.university
            , expr_faculty => specialty.faculty
            , expr_studies_modetier => specialty.studies_modetier
            , expr_studies_field => specialty.studies_field
            , expr_studies_specialty => specialty.studies_specialty
            , expr_semester_code => semester.semester_code
            , expr_semester_number => semester.semester_number
            , expr_ects_mandatory => TO_CHAR(semester.ects_mandatory)
            , expr_ects_other => TO_CHAR(semester.ects_other)
            , expr_ects_total => TO_CHAR(semester.ects_total)
            );
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
