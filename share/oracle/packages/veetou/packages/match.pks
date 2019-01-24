CREATE OR REPLACE PACKAGE V2U_Match AUTHID CURRENT_USER AS
    FUNCTION String_Like(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION String_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Code_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Number_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Number_Range(expr IN VARCHAR, value IN NUMBER) RETURN INTEGER;
    FUNCTION Person_Name(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;

    FUNCTION Expr_Fields(
              subject_mapping IN V2u_Subject_Mapping_t := NULL
            , subject_instance IN V2u_Ko_Subject_Instance_t := NULL
            ) RETURN NUMBER;

--    FUNCTION Expr_Fields(
--              program_mapping IN V2u_Program_Mapping_t
--            , specialty_instance IN V2u_Ko_Specialty_Instance_t
--            ) RETURN NUMBER;
END V2U_Match;

-- vim: set ft=sql ts=4 sw=4 et:
