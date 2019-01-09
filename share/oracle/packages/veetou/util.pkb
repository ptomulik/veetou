CREATE OR REPLACE PACKAGE BODY VEETOU_Util AS
    FUNCTION Not_Exists_Errcode(schema_type IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        IF (UPPER(schema_type) = 'TABLE') OR (UPPER(schema_type) = 'VIEW') THEN
            RETURN(-942);
        ELSIF UPPER(schema_type) = 'SEQUENCE' THEN
            RETURN(-2289);
        ELSIF UPPER(schema_type) = 'TRIGGER' THEN
            RETURN(-4080);
        ELSIF UPPER(schema_type) = 'INDEX' THEN
            RETURN(-1418);
        ELSIF UPPER(schema_type) = 'COLUMN' THEN
            RETURN(-904);
        ELSIF UPPER(schema_type) = 'DATABASE LINK' THEN
            RETURN(-2024);
        ELSIF UPPER(schema_type) = 'MATERIALIZED VIEW' THEN
            RETURN(-12003);
        ELSIF UPPER(schema_type) = 'CONSTRAINT' THEN
            RETURN(-2443);
        ELSIF UPPER(schema_type) = 'USER' THEN
            RETURN(-1918);
        ELSIF (UPPER(schema_type) = 'TYPE') OR
              (UPPER(schema_type) = 'PACKAGE') OR
              (UPPER(schema_type) = 'PROCEDURE') OR
              (UPPER(schema_type) = 'FUNCTION') THEN
            RETURN(-4043);
        ELSIF UPPER(schema_type) = 'TABLESPACE' THEN
            RETURN(-959);
        ELSE
            RAISE PROGRAM_ERROR;
        END IF;
    END;


    PROCEDURE Drop_DB_Object(schema_type IN VARCHAR,
                             name IN VARCHAR,
                             how IN VARCHAR := '') IS
    BEGIN
        DBMS_Utility.Exec_DDL_Statement(
            'DROP ' || UPPER(schema_type) || ' ' || name || ' ' || how
        );
    END;



    PROCEDURE Drop_If_Exists(schema_type IN VARCHAR,
                             name IN VARCHAR,
                             how IN VARCHAR := '') IS
    BEGIN
        Drop_DB_Object(schema_type, name, how);
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != Not_Exists_Errcode(schema_type) THEN
                RAISE;
            END IF;
    END;



    PROCEDURE Create_DB_Object(schema_type IN VARCHAR,
                               name IN VARCHAR,
                               decl IN VARCHAR) IS
    BEGIN
        DBMS_Utility.Exec_DDL_Statement(
            'CREATE ' || UPPER(schema_type) || ' ' || name || ' ' || decl
        );
    END;

    PROCEDURE Create_If_Not_Exists(schema_type IN VARCHAR,
                                   name IN VARCHAR,
                                   decl IN VARCHAR) IS
    BEGIN
        Create_DB_Object(schema_type, name, decl);
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -955 THEN
                RAISE;
            END IF;
    END;


    PROCEDURE Drop_Table_If_Exists(name IN VARCHAR, how IN VARCHAR := '') IS
    BEGIN
        Drop_If_Exists('TABLE', name, how);
    END;


    PROCEDURE Drop_Index_If_Exists(name IN VARCHAR, how IN VARCHAR := '') IS
    BEGIN
        Drop_If_Exists('INDEX', name, how);
    END;


    PROCEDURE Drop_View_If_Exists(name IN VARCHAR, how IN VARCHAR := '') IS
    BEGIN
        Drop_If_Exists('VIEW', name, how);
    END;


    PROCEDURE Create_Table_If_Not_Exists(name IN VARCHAR, decl IN LONG) IS
    BEGIN
        Create_If_Not_Exists('TABLE', name, decl);
    END;


    PROCEDURE Create_Index_If_Not_Exists(name IN VARCHAR, decl IN LONG) IS
    BEGIN
        Create_If_Not_Exists('INDEX', name, decl);
    END;


    PROCEDURE Create_View_If_Not_Exists(name IN VARCHAR, decl IN LONG) IS
    BEGIN
        Create_If_Not_Exists('VIEW', name, decl);
    END;


    PROCEDURE Comment_On_Table(name IN VARCHAR, str IN VARCHAR) IS
    BEGIN
        DBMS_Utility.Exec_DDL_Statement(
            'COMMENT ON TABLE ' || name || ' IS ''' || str || ''''
        );
    END;


    PROCEDURE Comment_On_Column(name IN VARCHAR, str IN VARCHAR) IS
    BEGIN
        DBMS_Utility.Exec_DDL_Statement(
            'COMMENT ON COLUMN ' || name || ' IS ''' || str || ''''
        );
    END;
END VEETOU_Util;

-- vim: ft=sql ts=4 sw=4 et:
