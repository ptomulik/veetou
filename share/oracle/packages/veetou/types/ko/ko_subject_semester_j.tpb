CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Semester_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , semester_code IN VARCHAR2
            , subj_grades IN V2u_Subj_20Grades_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , subj_code => subj_code
            , map_subj_code => map_subj_code
            , semester_code => semester_code
            , subj_grades => subj_grades
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subj_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , semester_code IN VARCHAR2
            , subj_grades IN V2u_Subj_20Grades_t
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.subj_code := subj_code;
        SELF.map_subj_code := map_subj_code;
        SELF.semester_code := semester_code;
        SELF.subj_grades := subj_grades;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
