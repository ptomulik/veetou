CREATE OR REPLACE PACKAGE BODY V2U_Util AS
    PROCEDURE Give_Grants(to_user IN VARCHAR2)
    IS
    BEGIN
        FOR i IN (SELECT view_name FROM user_views)
        LOOP
            EXECUTE IMMEDIATE 'GRANT SELECT ON ' || i.view_name || ' TO ' || to_user;
        END LOOP;
        FOR i IN (
                    SELECT table_name FROM user_tables
                        WHERE table_name NOT IN
                        (
                            SELECT table_name FROM user_nested_tables
                        )
                    UNION ALL
                    SELECT table_name FROM user_object_tables
                        WHERE table_name NOT IN
                        (
                            SELECT table_name FROM user_nested_tables
                        )
                 )
        LOOP
            EXECUTE IMMEDIATE 'GRANT SELECT ON ' || i.table_name || ' TO ' || to_user;
        END LOOP;
        FOR i IN (
                    SELECT object_name FROM user_procedures
                        WHERE object_type IN ('PACKAGE', 'TYPE')
                 )
        LOOP
            EXECUTE IMMEDIATE 'GRANT EXECUTE ON ' || i.object_name || ' TO ' || to_user;
        END LOOP;
    END;
END V2U_Util;
/
-- vim: set ft=sql ts=4 sw=4 et:
