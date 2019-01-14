CREATE OR REPLACE PACKAGE BODY VEETOU_Pkg AS
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
                             how IN VARCHAR := '')
    IS
    BEGIN
        DBMS_Utility.Exec_DDL_Statement(
            'DROP ' || UPPER(schema_type) || ' ' || name || ' ' || how
        );
    END;


    PROCEDURE Drop_If_Exists(schema_type IN VARCHAR,
                             name IN VARCHAR,
                             how IN VARCHAR := '')
    IS
    BEGIN
        Drop_DB_Object(schema_type, name, how);
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != Not_Exists_Errcode(schema_type) THEN
                RAISE;
            END IF;
    END;


    PROCEDURE Drop_Table(table_name IN VARCHAR,
                         type_name IN VARCHAR := NULL,
                         ov_name IN VARCHAR := NULL,
                         how IN VARCHAR := '')
    IS
    BEGIN
        IF ov_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'veetou_' || ov_name);
        END IF;
        IF type_name IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || type_name);
        END IF;
        Drop_If_Exists('TABLE', 'veetou_' || table_name, how);
    END;


    PROCEDURE Drop_View(view_name IN VARCHAR,
                        type_name IN VARCHAR := NULL,
                        ov_name IN VARCHAR := NULL)
    IS
    BEGIN
        IF ov_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'veetou_' || ov_name);
        END IF;
        IF type_name IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || type_name);
        END IF;
        Drop_If_Exists('VIEW', 'veetou_' || view_name);
    END;


    PROCEDURE Drop_Index(index_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('INDEX', 'veetou_' || index_name);
    END;


    PROCEDURE Drop_Sequence(sequence_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('SEQUENCE', 'veetou_' || sequence_name);
    END;


    PROCEDURE Drop_Trigger(sequence_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('TRIGGER', 'veetou_' || sequence_name);
    END;


    PROCEDURE Drop_Package(package_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('PACKAGE', 'VEETOU_' || package_name);
    END;


    PROCEDURE Uninstall(how IN VARCHAR := 'PURGE')
    IS
    BEGIN
        Drop_Index('subject_mappings_idx1');
        Drop_Index('subject_mappings_idx2');
        Drop_Trigger('subject_mappings_tr1');
        Drop_Sequence('subject_mappings_sq1');
        Drop_Table('subject_mappings', 'Subject_Mapping_Typ', 'subject_mappings_ov', how);

        Drop_View('ko_subject_instances', 'Ko_Subject_Instance_Typ', 'ko_subject_instances_ov');
        Drop_View('ko_refined', 'Ko_Refined_Typ', 'ko_refined_ov');
        Drop_View('ko_full', 'Ko_Full_Typ', 'ko_full_ov');


        Drop_Index('ko_headers_idx1');
        Drop_Index('ko_preambles_idx1');
        Drop_Index('ko_preambles_idx2');
        Drop_Index('ko_preambles_idx3');
        Drop_Index('ko_preambles_idx4');
        Drop_Index('ko_preambles_idx5');
        Drop_Index('ko_trs_idx1');
        Drop_Index('ko_trs_idx2');


        Drop_Table('ko_page_footer', how);
        Drop_Table('ko_page_header', how);
        Drop_Table('ko_page_preamble', how);
        Drop_Table('ko_page_tbody', how);
        Drop_Table('ko_report_sheets', how);
        Drop_Table('ko_sheet_pages', how);
        Drop_Table('ko_tbody_trs', how);


        Drop_Table('ko_footers', 'Ko_Footer_Typ', 'ko_footers_ov', how);
        Drop_Table('ko_headers', 'Ko_Header_Typ', 'ko_headers_ov', how);
        Drop_Table('ko_pages', 'Ko_Page_Typ', 'ko_pages_ov', how);
        Drop_Table('ko_preambles', 'Ko_Preamble_Typ', 'ko_preambles_ov', how);
        Drop_Table('ko_reports', 'Ko_Report_Typ', 'ko_reports_ov', how);
        Drop_Table('ko_sheets', 'Ko_Sheet_Typ', 'ko_sheets_ov', how);
        Drop_Table('ko_tbodies', 'Ko_Tbody_Typ', 'ko_tbodies_ov', how);
        Drop_Table('ko_trs', 'Ko_Tr_Typ', 'ko_trs_ov', how);
        Drop_Table('ko_jobs', 'Ko_Job_Typ', 'ko_jobs_ov', how);

        -- PACKAGES (all, except the VEETOU_Pkg package)
    END;

END VEETOU_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
