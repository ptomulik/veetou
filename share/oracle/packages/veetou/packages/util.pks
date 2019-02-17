CREATE OR REPLACE PACKAGE V2U_Util AUTHID CURRENT_USER AS
    PROCEDURE Give_Grants(to_user IN VARCHAR2);
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
