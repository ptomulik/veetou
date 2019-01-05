DECLARE
    PROCEDURE DROP_TABLE_IF_EXISTS(table_name IN VARCHAR)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE ' || table_name;
        DBMS_Output.Put_Line(' table dropped');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                RAISE;
            ELSE
                DBMS_Output.Put_Line(' table not exists');
            END IF;
    END;

    PROCEDURE DROP_INDEX_IF_EXISTS(index_name IN VARCHAR)
    IS
    BEGIN
        EXECUTE IMMEDIATE 'DROP INDEX ' || index_name;
        DBMS_Output.Put_Line(' index dropped');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -1418 THEN
                RAISE;
            ELSE
                DBMS_Output.Put_Line(' index not exists');
            END IF;
    END;

BEGIN

    -- DROP INDEXES
    DROP_INDEX_IF_EXISTS('veetou_ko_headers_idx1');
    DROP_INDEX_IF_EXISTS('veetou_ko_preambles_idx1');
    DROP_INDEX_IF_EXISTS('veetou_ko_preambles_idx2');
    DROP_INDEX_IF_EXISTS('veetou_ko_preambles_idx3');
    DROP_INDEX_IF_EXISTS('veetou_ko_preambles_idx4');
    DROP_INDEX_IF_EXISTS('veetou_ko_preambles_idx5');
    DROP_INDEX_IF_EXISTS('veetou_ko_trs_idx1');
    DROP_INDEX_IF_EXISTS('veetou_ko_trs_idx2');

    -- DELETE JUNCTION TABLES

    DROP_TABLE_IF_EXISTS('veetou_ko_page_footer');
    DROP_TABLE_IF_EXISTS('veetou_ko_page_header');
    DROP_TABLE_IF_EXISTS('veetou_ko_page_preamble');
    DROP_TABLE_IF_EXISTS('veetou_ko_page_tbody');
    DROP_TABLE_IF_EXISTS('veetou_ko_report_sheets');
    DROP_TABLE_IF_EXISTS('veetou_ko_sheet_pages');
    DROP_TABLE_IF_EXISTS('veetou_ko_tbody_trs');


    -- DELETE DATA TABLES

    DROP_TABLE_IF_EXISTS('veetou_ko_footers');
    DROP_TABLE_IF_EXISTS('veetou_ko_headers');
    DROP_TABLE_IF_EXISTS('veetou_ko_pages');
    DROP_TABLE_IF_EXISTS('veetou_ko_preambles');
    DROP_TABLE_IF_EXISTS('veetou_ko_reports');
    DROP_TABLE_IF_EXISTS('veetou_ko_sheets');
    DROP_TABLE_IF_EXISTS('veetou_ko_tbodies');
    DROP_TABLE_IF_EXISTS('veetou_ko_trs');
    DROP_TABLE_IF_EXISTS('veetou_exports');
END;

