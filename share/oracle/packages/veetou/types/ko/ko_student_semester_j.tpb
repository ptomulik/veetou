CREATE OR REPLACE TYPE BODY V2u_Ko_Student_Semester_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_Semester_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , student_id => student_id
            , ects_attained => ects_attained
            );
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Ko_Student_Semester_J_t(
--              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , student IN V2u_Ko_Student_t
--            , ects_attained IN NUMBER
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , student => student
--            , ects_attained => ects_attained
--            );
--        RETURN;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            );
        SELF.student_id := student_id;
        SELF.ects_attained := ects_attained;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , student IN V2u_Ko_Student_t
--            , ects_attained IN NUMBER
--            )
--    IS
--    BEGIN
--        IF semester.job_uuid <> student.job_uuid THEN
--            RAISE_APPLICATION_ERROR(
--                  -20101
--                , 'job_uuid missmatch in V2u_Ko_Student_Semester_J_t.init:' ||
--                  ' semester.job_uuid='  || RAWTOHEX(semester.job_uuid) ||
--                  ' student.job_uuid=' || RAWTOHEX(student.job_uuid)
--                );
--        END IF;
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            );
--        SELF.student_id := student.id;
--        SELF.ects_attained := ects_attained;
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
