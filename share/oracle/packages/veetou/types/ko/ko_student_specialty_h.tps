CREATE OR REPLACE TYPE V2u_Ko_Student_Specialty_H_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , student_id NUMBER(38)
    , specsem_id NUMBER(38)
    , specmap_id NUMBER(38)
    , matching_score NUMBER(38)
    , student V2u_Ko_Student_t
    , specialty_entity V2u_Ko_SpecSem_t
    , specialty_map V2u_Specialty_Map_t
    , ects_attained NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_Specialty_H_t(
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
    );

-- vim: set ft=sql ts=4 sw=4 et:
