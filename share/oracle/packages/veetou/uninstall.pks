CREATE OR REPLACE PACKAGE VEETOU_Uninstall AUTHID CURRENT_USER AS
    PROCEDURE Uninstall(purge IN BOOLEAN := FALSE);
END VEETOU_Uninstall;

-- vim: set ft=sql ts=4 sw=4 et:
