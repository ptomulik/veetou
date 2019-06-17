CREATE OR REPLACE PACKAGE V2U_Fit AUTHID CURRENT_USER AS
    FUNCTION Attributes(
              protocol_map IN V2u_Protocol_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , grade_i IN V2u_Ko_Grade_I_t
            ) RETURN INTEGER DETERMINISTIC;

    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER DETERMINISTIC;

    FUNCTION Attributes(
              classes_map IN V2u_Classes_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER DETERMINISTIC;

    FUNCTION Attributes(
              specialty_map IN V2u_Specialty_Map_B_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER DETERMINISTIC;

    FUNCTION Attributes(
              grade_i IN V2u_Ko_Grade_I_t
            , wartosc_oceny IN V2u_Dz_Wartosc_Oceny_B_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_B_t
            , data_zwrotu_rank IN NUMBER
            ) RETURN INTEGER DETERMINISTIC;
END V2U_Fit;
/
-- vim: set ft=sql ts=4 sw=4 et:
