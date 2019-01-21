CREATE OR REPLACE PACKAGE V2U_Match AUTHID CURRENT_USER AS
    FUNCTION String_Like(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION String_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Code_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Number_Range(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
    FUNCTION Number_Range(expr IN VARCHAR, value IN NUMBER) RETURN INTEGER;
    FUNCTION Person_Name(expr IN VARCHAR, value IN VARCHAR) RETURN INTEGER;
END V2U_Match;

-- vim: set ft=sql ts=4 sw=4 et:
