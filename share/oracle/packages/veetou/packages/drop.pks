CREATE OR REPLACE PACKAGE V2U_Drop AUTHID CURRENT_USER AS
    PROCEDURE Primaries;
    PROCEDURE Secondaries;
END V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
