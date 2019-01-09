CREATE OR REPLACE PACKAGE VEETOU_KO_Schema AUTHID CURRENT_USER AS
    PROCEDURE Create_Tables;
    PROCEDURE Create_Indexes;
    PROCEDURE Create_Views;

    -- Creates the whole schema
    PROCEDURE Create_Schema;

    -- Drop the schema
    PROCEDURE Drop_Schema(purge IN BOOLEAN := FALSE);
END VEETOU_KO_Schema;

-- vim: ft=sql ts=4 sw=4 et:
