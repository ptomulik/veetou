CREATE OR REPLACE TYPE BODY V2u_Ko_Student_Specialty_H_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_Specialty_H_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Specialty_H_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specsem_id IN NUMBER
            , specmap_id IN NUMBER
            , matching_score IN NUMBER
            , student IN V2u_Ko_Student_t
            , specialty_entity IN V2u_Ko_SpecSem_t
            , specialty_map IN V2u_Specialty_Map_t
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.student_id := student_id;
        SELF.specsem_id := specsem_id;
        SELF.specmap_id := specmap_id;
        SELF.matching_score := matching_score;
        SELF.student := student;
        SELF.specialty_entity := specialty_entity;
        SELF.specialty_map := specialty_map;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
