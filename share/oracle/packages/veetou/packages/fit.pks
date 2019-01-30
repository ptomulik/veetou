CREATE OR REPLACE PACKAGE V2U_Fit AUTHID CURRENT_USER AS
    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_t := NULL
            , subject_entity IN V2u_Ko_Subject_Entity_t := NULL
            ) RETURN NUMBER;

    FUNCTION Attributes(
              specialty_map IN V2u_Specialty_Map_t
            , specialty_entity IN V2u_Ko_SpecSem_t
            ) RETURN NUMBER;
END V2U_Fit;

-- vim: set ft=sql ts=4 sw=4 et:
