CREATE OR REPLACE PACKAGE V2U_Drop AUTHID CURRENT_USER AS
    PROCEDURE Tier1_Dz;
    PROCEDURE Tier1_Ko;
    PROCEDURE Tier1_Basis;
    PROCEDURE Tier1;
    PROCEDURE Tier2;
    PROCEDURE Tier3;
END V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
