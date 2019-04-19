CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Ocena_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Ocena_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , student_id => student_id
            , classes_type => classes_type
            , subj_grade => subj_grade
            , subj_grade_date => subj_grade_date
            , os_id => os_id
            , prot_id => prot_id
            , term_prot_nr => term_prot_nr
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.student_id := student_id;
        SELF.classes_type := classes_type;
        SELF.subj_grade := subj_grade;
        SELF.subj_grade_date := subj_grade_date;
        SELF.os_id := os_id;
        SELF.prot_id := prot_id;
        SELF.term_prot_nr := term_prot_nr;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
