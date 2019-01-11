CREATE OR REPLACE PACKAGE BODY VEETOU_Uninstall AS
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


    PROCEDURE Drop_Common_Schema(purge IN BOOLEAN := FALSE) AS
        how VARCHAR(100);
    BEGIN

        --
        -- NOTE: the order is important here!
        --

        -- DROP VIEWS

        -- DROP INDEXES
        Drop_If_Exists('INDEX', 'veetou_subject_mappings_idx1');
        Drop_If_Exists('INDEX', 'veetou_subject_mappings_idx2');
        Drop_If_Exists('INDEX', 'veetou_subject_mappings_idx3');
        Drop_If_Exists('INDEX', 'veetou_subject_selectors_idx1');

        -- DROP TRIGGERS
        Drop_If_Exists('TRIGGER', 'veetou_subject_mappings_tr1');

        -- DROP SEQUENCES
        Drop_If_Exists('SEQUENCE', 'veetou_subject_mappings_sq1');


        IF purge THEN
            how := 'PURGE';
        ELSE
            how := '';
        END IF;

        -- DROP JUNCTION TABLES

        -- DROP DATA TABLES
        Drop_If_Exists('TABLE', 'veetou_subject_mappings', how);
        Drop_If_Exists('TABLE', 'veetou_subject_matchers', how);
    END;


    PROCEDURE Drop_Ko_Schema(purge IN BOOLEAN := FALSE) AS
        how VARCHAR(10 CHAR);
    BEGIN

        --
        -- NOTE: the order is important here!
        --

        -- DROP VIEWS

        Drop_If_Exists('VIEW', 'veetou_ko_subject_instances');
        Drop_If_Exists('VIEW', 'veetou_ko_refined');
        Drop_If_Exists('VIEW', 'veetou_ko_full');

        -- DROP INDEXES

        Drop_If_Exists('INDEX', 'veetou_ko_headers_idx1');
        Drop_If_Exists('INDEX', 'veetou_ko_preambles_idx1');
        Drop_If_Exists('INDEX', 'veetou_ko_preambles_idx2');
        Drop_If_Exists('INDEX', 'veetou_ko_preambles_idx3');
        Drop_If_Exists('INDEX', 'veetou_ko_preambles_idx4');
        Drop_If_Exists('INDEX', 'veetou_ko_preambles_idx5');
        Drop_If_Exists('INDEX', 'veetou_ko_trs_idx1');
        Drop_If_Exists('INDEX', 'veetou_ko_trs_idx2');

        IF purge THEN
            how := 'PURGE';
        ELSE
            how := '';
        END IF;

        -- DELETE JUNCTION TABLES

        Drop_If_Exists('TABLE', 'veetou_ko_page_footer', how);
        Drop_If_Exists('TABLE', 'veetou_ko_page_header', how);
        Drop_If_Exists('TABLE', 'veetou_ko_page_preamble', how);
        Drop_If_Exists('TABLE', 'veetou_ko_page_tbody', how);
        Drop_If_Exists('TABLE', 'veetou_ko_report_sheets', how);
        Drop_If_Exists('TABLE', 'veetou_ko_sheet_pages', how);
        Drop_If_Exists('TABLE', 'veetou_ko_tbody_trs', how);


        -- DELETE DATA TABLES

        Drop_If_Exists('TABLE', 'veetou_ko_footers', how);
        Drop_If_Exists('TABLE', 'veetou_ko_headers', how);
        Drop_If_Exists('TABLE', 'veetou_ko_pages', how);
        Drop_If_Exists('TABLE', 'veetou_ko_preambles', how);
        Drop_If_Exists('TABLE', 'veetou_ko_reports', how);
        Drop_If_Exists('TABLE', 'veetou_ko_sheets', how);
        Drop_If_Exists('TABLE', 'veetou_ko_tbodies', how);
        Drop_If_Exists('TABLE', 'veetou_ko_trs', how);
        Drop_If_Exists('TABLE', 'veetou_ko_jobs', how);
    END;

    PROCEDURE Drop_Types AS
    BEGIN
        --
        -- Types for TABLES
        --
        Drop_If_Exists('TYPE', 'Veetou_Subject_Mapping_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Subject_Matcher_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Matchable_Subject_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Matchable_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Refined_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Footer_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Header_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Job_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Page_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Preamble_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Report_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Sheet_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Tbody_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Tr_Typ');

        --
        -- Types for VIEWS
        --
        Drop_If_Exists('TYPE', 'Veetou_Ko_Full_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Refined_Typ');
        Drop_If_Exists('TYPE', 'Veetou_Ko_Subject_Instance_Typ');
    END;

    PROCEDURE Drop_Other_Packages AS
    BEGIN
        Drop_If_Exists('PACKAGE', 'VEETOU_Common');
    END;

    PROCEDURE Drop_Schemas(purge IN BOOLEAN := FALSE) AS
    BEGIN
        Drop_Ko_Schema(purge);
        Drop_Common_Schema(purge);
    END;

    PROCEDURE Uninstall(purge IN BOOLEAN := FALSE) AS
    BEGIN
        Drop_Schemas(purge);
        Drop_Other_Packages;
        Drop_Types;
    END;

END VEETOU_Uninstall;

-- vim: set ft=sql ts=4 sw=4 et:
