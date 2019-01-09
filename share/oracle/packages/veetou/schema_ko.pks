--
-- This only contains tables/view/indices that are specific to KO.
--
CREATE OR REPLACE PACKAGE VEETOU_Schema_KO AUTHID CURRENT_USER AS
    -- Create/Drop the KO schema
    PROCEDURE Create_Schema;
    PROCEDURE Drop_Schema(purge IN BOOLEAN := FALSE);
END VEETOU_Schema_KO;

-- vim: ft=sql ts=4 sw=4 et:
