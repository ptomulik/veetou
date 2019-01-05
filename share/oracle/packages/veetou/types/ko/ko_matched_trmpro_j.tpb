CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Trmpro_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade_date IN DATE
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , student_id => student_id
            , subj_grade_date => subj_grade_date
            , prot_id => prot_id
            , nr => nr
            , data_zwrotu => data_zwrotu
            , reason => reason
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subj_grade_date IN DATE
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
            , reason IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , student_id => student_id
            );
        SELF.subj_grade_date := subj_grade_date;
        SELF.prot_id := prot_id;
        SELF.nr := nr;
        SELF.data_zwrotu := data_zwrotu;
        SELF.reason := reason;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
