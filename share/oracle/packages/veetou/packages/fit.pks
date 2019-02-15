CREATE OR REPLACE PACKAGE V2U_Fit AUTHID CURRENT_USER AS
    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER;

    FUNCTION Attributes(
              classes_map IN V2u_Classes_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER;

      FUNCTION Attributes(
                specialty_map IN V2u_Specialty_Map_B_t
              , semester IN V2u_Ko_Semester_t
              ) RETURN INTEGER;
END V2U_Fit;

-- vim: set ft=sql ts=4 sw=4 et:
