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
                         ov_name IN VARCHAR := NULL,
                         obj_type IN VARCHAR := NULL,
                         tab_type IN VARCHAR := NULL,
                         how IN VARCHAR := '')
    IS
    BEGIN
        IF ov_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'veetou_' || ov_name);
        END IF;
        IF how <> 'KEEP' THEN
            Drop_If_Exists('TABLE', 'veetou_' || table_name, how);
        END IF;
        IF tab_type IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || tab_type);
        END IF;
        IF obj_type IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'Veetou_' || obj_type);
        END IF;
    END;


    PROCEDURE Drop_View(primary_view IN VARCHAR,
                        secondary_view IN VARCHAR := NULL,
                        type_name IN VARCHAR := NULL)
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
        Drop_Table('program_mappings', 'program_mappings_ov', 'Program_Mapping_Typ', 'Program_Mappings_Typ', how);
        Drop_View('ko_specialty_instances_ov', 'ko_specialty_instances', 'Ko_Specialty_Instance_Typ');

        Drop_View('ko_unmapped_subjects_ov', NULL, 'ko_unmapped_subjects');
        Drop_View('ko_ambiguous_subjects_ov', NULL, 'ko_ambiguous_subjects');

        Drop_View('ko_mapped_subjects_ov', NULL, 'ko_mapped_subjects');
        IF how <> 'KEEP' THEN
            Drop_Index('subject_mappings_idx1');
            Drop_Index('subject_mappings_idx2');
            Drop_Trigger('subject_mappings_tr1');
            Drop_Sequence('subject_mappings_sq1');
        END IF;
        Drop_Table('subject_mappings', 'subject_mappings_ov', 'Subject_Mapping_Typ', 'Subject_Mappings_Typ', how);
        Drop_View('ko_subject_instances_ov', 'ko_subject_instances', 'Ko_Subject_Instance_Typ');

        Drop_View('ko_sheet_infos_ov', 'ko_sheet_infos', 'Ko_Sheet_Info_Typ');
        Drop_View('ko_xsheets_ov', 'ko_xsheets', 'Ko_Xsheet_Typ');
        Drop_View('ko_students_ov', 'ko_students', 'Ko_Student_Typ');
        Drop_View('ko_refined', 'ko_refined_ov', 'Ko_Refined_Typ');
        Drop_View('ko_full', 'ko_full_ov', 'Ko_Full_Typ');

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

        Drop_Table('ko_footers', 'ko_footers_ov', 'Ko_Footer_Typ', 'Ko_Footers_Typ', how);
        Drop_Table('ko_headers', 'ko_headers_ov', 'Ko_Header_Typ', 'Ko_Headers_Typ', how);
        Drop_Table('ko_pages', 'ko_pages_ov', 'Ko_Page_Typ', 'Ko_Pages_Typ', how);
        Drop_Table('ko_preambles', 'ko_preambles_ov', 'Ko_Preamble_Typ', 'Ko_Preambles_Typ', how);
        Drop_Table('ko_reports', 'ko_reports_ov', 'Ko_Report_Typ', 'Ko_Reports_Typ', how);
        Drop_Table('ko_sheets', 'ko_sheets_ov', 'Ko_Sheet_Typ', 'Ko_Sheets_Typ', how);
        Drop_Table('ko_tbodies', 'ko_tbodies_ov', 'Ko_Tbody_Typ', 'Ko_Tbodies_Typ', how);
        Drop_Table('ko_trs', 'ko_trs_ov', 'Ko_Tr_Typ', 'Ko_Trs_Typ', how);
        Drop_Table('ko_jobs', 'ko_jobs_ov', 'Ko_Job_Typ', 'Ko_Jobs_Typ', how);

        Drop_Type('Semester_Codes_Typ');
        Drop_Table('semesters', 'semesters_ov', 'Semester_Typ', 'Semesters_Typ', how);

        -- PACKAGES (all, except the VEETOU_Pkg package)
        Drop_Package('Match');
        Drop_Package('Util');
    END;

END VEETOU_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
