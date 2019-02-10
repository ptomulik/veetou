CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Subject_Map_V_t AS
    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Subject_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subject_Map_V_t
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
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
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
            , job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Subject_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subject_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Subject_Map_V_t
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
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            )
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
        SELF.job_uuid := job_uuid;
        SELF.subject_id := subject_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
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
            , map_subj_lang => NULL
            , map_org_unit => NULL
            , map_org_unit_recipient => NULL
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

-- vim: set ft=sql ts=4 sw=4 et:
