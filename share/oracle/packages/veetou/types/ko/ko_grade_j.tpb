CREATE OR REPLACE TYPE BODY V2u_Ko_Grade_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Grade_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , student_id => student_id
            , subj_grade => subj_grade
            , subj_grade_date => subj_grade_date
            , tr_id => tr_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Grade_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
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
        SELF.subj_grade := subj_grade;
        SELF.subj_grade_date := subj_grade_date;
        SELF.tr_id := tr_id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: