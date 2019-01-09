CREATE OR REPLACE PACKAGE VEETOU_Schema AUTHID CURRENT_USER AS
    -- Create/drop schema defined by VEETOU_Schema
    PROCEDURE Create_Schema;
    PROCEDURE Drop_Schema(purge IN BOOLEAN := FALSE);

    -- Create/Drop all VEETOU schemas
    PROCEDURE Create_All_Schemas;
    PROCEDURE Drop_All_Schemas(purge IN BOOLEAN := FALSE);
END VEETOU_Schema;

-- vim: ft=sql ts=4 sw=4 et:
