CREATE OR REPLACE TYPE BODY V2u_Ko_Classes_Semester_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subj_code IN VARCHAR2
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
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subj_code => subj_code
            , subj_name => subj_name
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
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subj_code IN VARCHAR2
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
            , classes_type VARCHAR2
            , classes_hours NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subj_code => subj_code
            , subj_name => subj_name
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
        SELF.classes_type := classes_type;
        SELF.classes_hours := classes_hours;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Semester_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            );
        SELF.classes_type := classes_type;
        SELF.classes_hours := classes_hours;
    END;

    OVERRIDING MEMBER FUNCTION cmp_impl(other IN V2u_Ko_Subject_Semester_V_t)
            RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_impl(TREAT(other AS V2u_Ko_Classes_Semester_V_t));
    END;

    MEMBER FUNCTION cmp_impl(other IN V2u_Ko_Classes_Semester_V_t)
            RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := (SELF AS V2u_Ko_Subject_Semester_V_t).cmp_impl(other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(classes_type, other.classes_type);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.NumN(classes_hours, other.classes_hours);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
