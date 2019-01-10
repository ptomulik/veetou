CREATE OR REPLACE PACKAGE VEETOU_Uninstall AS
    PROCEDURE Drop_Schemas(purge IN BOOLEAN := FALSE);
    PROCEDURE Drop_Other_Packages;
    PROCEDURE Uninstall(purge IN BOOLEAN := FALSE);
END VEETOU_Uninstall;

-- vim: ft=sql ts=4 sw=4 et:
