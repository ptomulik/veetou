CREATE OR REPLACE PACKAGE V2U_Pkg AUTHID CURRENT_USER AS
    PROCEDURE Uninstall(how IN VARCHAR := 'KEEP');
END V2U_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
