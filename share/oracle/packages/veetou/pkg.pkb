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
        cmd VARCHAR(1024);
    BEGIN
        cmd := 'DROP ' || UPPER(schema_type) || ' ' || name || ' ' || how;
        DBMS_Utility.Exec_DDL_Statement(cmd);
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


    PROCEDURE Drop_Type(type_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('TYPE', 'Veetou_' || type_name);
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
        IF how <> 'KEEP' THEN
            Drop_If_Exists('TABLE', 'veetou_' || table_name, how);
        END IF;
        IF type_name IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || type_name);
        END IF;
    END;


    PROCEDURE Drop_View(primary_view IN VARCHAR,
                        type_name IN VARCHAR := NULL,
                        secondary_view IN VARCHAR := NULL)
    IS
    BEGIN
        IF secondary_view IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'veetou_' || secondary_view);
        END IF;
        IF primary_view IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'veetou_' || primary_view);
        END IF;
        IF type_name IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || type_name);
        END IF;
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

    PROCEDURE Uninstall(how IN VARCHAR := 'KEEP')
    IS
    BEGIN
        Drop_View('ko_unmapped_programs_ov', NULL, 'ko_unmapped_programs');
        Drop_View('ko_ambiguous_programs_ov', NULL, 'ko_ambiguous_programs');

        Drop_View('ko_mapped_programs_ov', NULL, 'ko_mapped_programs');
        IF how <> 'KEEP' THEN
            Drop_Index('program_mappings_idx1');
            Drop_Index('program_mappings_idx2');
            Drop_Trigger('program_mappings_tr1');
            Drop_Sequence('program_mappings_sq1');
        END IF;
        Drop_Type('Program_Mappings_Typ');
        Drop_Table('program_mappings', 'Program_Mapping_Typ', 'program_mappings_ov', how);
        Drop_View('ko_program_instances_ov', 'Ko_Program_Instance_Typ', 'ko_program_instances');

        Drop_View('ko_unmapped_subjects_ov', NULL, 'ko_unmapped_subjects');
        Drop_View('ko_ambiguous_subjects_ov', NULL, 'ko_ambiguous_subjects');

        Drop_View('ko_mapped_subjects_ov', NULL, 'ko_mapped_subjects');
        IF how <> 'KEEP' THEN
            Drop_Index('subject_mappings_idx1');
            Drop_Index('subject_mappings_idx2');
            Drop_Trigger('subject_mappings_tr1');
            Drop_Sequence('subject_mappings_sq1');
        END IF;
        Drop_Type('Subject_Mappings_Typ');
        Drop_Table('subject_mappings', 'Subject_Mapping_Typ', 'subject_mappings_ov', how);
        Drop_View('ko_subject_instances_ov', 'Ko_Subject_Instance_Typ', 'ko_subject_instances');

        Drop_View('ko_students', 'Ko_Student_Typ', 'ko_students_ov');
        Drop_View('ko_refined', 'Ko_Refined_Typ', 'ko_refined_ov');
        Drop_View('ko_full', 'Ko_Full_Typ', 'ko_full_ov');

        IF how <> 'KEEP' THEN
            Drop_Index('ko_headers_idx1');
            Drop_Index('ko_preambles_idx1');
            Drop_Index('ko_preambles_idx2');
            Drop_Index('ko_preambles_idx3');
            Drop_Index('ko_preambles_idx4');
            Drop_Index('ko_preambles_idx5');
            Drop_Index('ko_trs_idx1');
            Drop_Index('ko_trs_idx2');
        END IF;

        Drop_Table('ko_page_footer', how => how);
        Drop_Table('ko_page_header', how => how);
        Drop_Table('ko_page_preamble', how => how);
        Drop_Table('ko_page_tbody', how => how);
        Drop_Table('ko_report_sheets', how => how);
        Drop_Table('ko_sheet_pages', how => how);
        Drop_Table('ko_tbody_trs', how => how);

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
        Drop_Package('Match');
        Drop_Package('Util');
    END;

END VEETOU_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
