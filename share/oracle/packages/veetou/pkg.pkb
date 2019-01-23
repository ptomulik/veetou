CREATE OR REPLACE PACKAGE BODY V2U_Pkg AS
    FUNCTION Is_Not_Exists_Errcode(schema_type IN VARCHAR, err_code IN NUMBER)
        RETURN BOOLEAN
    IS
    BEGIN
        IF (UPPER(schema_type) = 'TABLE') OR (UPPER(schema_type) = 'VIEW') THEN
            RETURN (err_code = -942);
        ELSIF UPPER(schema_type) = 'SEQUENCE' THEN
            RETURN (err_code = -2289);
        ELSIF UPPER(schema_type) = 'TRIGGER' THEN
            RETURN (err_code = -4080);
        ELSIF UPPER(schema_type) = 'INDEX' THEN
            RETURN (err_code = -1418);
        ELSIF UPPER(schema_type) = 'COLUMN' THEN
            RETURN (err_code = -904);
        ELSIF UPPER(schema_type) = 'DATABASE LINK' THEN
            RETURN (err_code = -2024);
        ELSIF UPPER(schema_type) = 'MATERIALIZED VIEW LOG ON' THEN
            RETURN (err_code = -12002 OR err_code = -942);
        ELSIF UPPER(schema_type) = 'MATERIALIZED VIEW' THEN
            RETURN (err_code = -12003);
        ELSIF UPPER(schema_type) = 'CONSTRAINT' THEN
            RETURN (err_code = -2443);
        ELSIF UPPER(schema_type) = 'USER' THEN
            RETURN (err_code = -1918);
        ELSIF (UPPER(schema_type) = 'TYPE') OR
              (UPPER(schema_type) = 'PACKAGE') OR
              (UPPER(schema_type) = 'PROCEDURE') OR
              (UPPER(schema_type) = 'FUNCTION') THEN
            RETURN (err_code = -4043);
        ELSIF UPPER(schema_type) = 'TABLESPACE' THEN
            RETURN (err_code = -959);
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
            IF NOT Is_Not_Exists_Errcode(schema_type, SQLCODE) THEN
                RAISE;
            END IF;
    END;

    PROCEDURE Drop_Type(type_name IN VARCHAR,
                        dependent_type1 IN VARCHAR := NULL,
                        dependent_type2 IN VARCHAR := NULL)
    IS
    BEGIN
        DBMS_Output.Put_Line(type_name);
        IF dependent_type2 IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'V2u_' || dependent_type2);
        END IF;
        IF dependent_type1 IS NOT NULL THEN
            Drop_If_Exists('TYPE', 'V2u_' || dependent_type1);
        END IF;
        Drop_If_Exists('TYPE', 'V2u_' || type_name);
    END;


    PROCEDURE Drop_Collect_Types
    IS
        CURSOR types_cur
        IS SELECT OBJECT_NAME FROM USER_OBJECTS
           WHERE OBJECT_TYPE = 'TYPE' AND OBJECT_NAME LIKE 'ST0000%';
        name USER_OBJECTS.OBJECT_NAME%TYPE;
    BEGIN
        OPEN types_cur;
        LOOP
            FETCH types_cur INTO name;
            EXIT WHEN types_cur%NOTFOUND;
            Drop_If_Exists('TYPE', '"' || name || '"');
        END LOOP;
        CLOSE types_cur;
    END;


    PROCEDURE Drop_Table(table_name IN VARCHAR,
                         view_name IN VARCHAR := NULL,
                         how IN VARCHAR := '')
    IS
    BEGIN
        IF view_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'v2u_' || view_name);
        END IF;
        Drop_If_Exists('MATERIALIZED VIEW LOG ON', 'v2u_' || table_name);
        IF how <> 'KEEP' THEN
            Drop_If_Exists('TABLE', 'v2u_' || table_name, how);
        END IF;
    END;


    PROCEDURE Drop_View(view_name IN VARCHAR,
                        dependent_view IN VARCHAR := NULL,
                        dependent_kind IN VARCHAR := NULL)
    IS
    BEGIN
        IF dependent_view IS NOT NULL THEN
            IF dependent_kind IS NULL THEN
                Drop_If_Exists('VIEW', 'v2u_' || dependent_view);
            ELSE
                Drop_If_Exists(dependent_kind, 'v2u_' || dependent_view);
            END IF;
        END IF;
        IF view_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'v2u_' || view_name);
        END IF;
    END;

    PROCEDURE Drop_Materialized_View(view_name IN VARCHAR,
                                     dependent_view IN VARCHAR := NULL,
                                     dependent_kind IN VARCHAR := NULL)
    IS
    BEGIN
        IF dependent_view IS NOT NULL THEN
            IF dependent_kind is NULL THEN
                Drop_If_Exists('VIEW', 'v2u_' || dependent_view);
            ELSE
                Drop_If_Exists(dependent_kind, 'v2u_' || dependent_view);
            END IF;
        END IF;
        IF view_name IS NOT NULL THEN
            Drop_If_Exists('MATERIALIZED VIEW', 'v2u_' || view_name);
        END IF;
    END;


    PROCEDURE Drop_Index(index_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('INDEX', 'v2u_' || index_name);
    END;


    PROCEDURE Drop_Sequence(sequence_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('SEQUENCE', 'v2u_' || sequence_name);
    END;


    PROCEDURE Drop_Trigger(sequence_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('TRIGGER', 'v2u_' || sequence_name);
    END;


    PROCEDURE Drop_Package(package_name IN VARCHAR)
    IS
    BEGIN
        Drop_If_Exists('PACKAGE', 'V2U_' || package_name);
    END;

    PROCEDURE Uninstall(how IN VARCHAR := 'KEEP')
    IS
    BEGIN
        Drop_View('ko_subject_grades_dv', 'ko_subject_grades');
        Drop_View('ko_unmapped_programs_dv', 'ko_unmapped_programs');
        Drop_View('ko_ambiguous_programs_dv', 'ko_ambiguous_programs');
        Drop_View('ko_mapped_programs_dv', 'ko_mapped_programs');
        IF how <> 'KEEP' THEN
            Drop_Index('program_mappings_idx1');
            Drop_Index('program_mappings_idx2');
            Drop_Trigger('program_mappings_tr1');
            Drop_Sequence('program_mappings_sq1');
        END IF;
        Drop_View('ko_threads_dv', 'ko_threads');
        Drop_View('ko_student_threads_dv', 'ko_student_threads');
        Drop_View('ko_student_specialties_dv', 'ko_student_specialties');
        Drop_View('ko_specialty_instances_dv', 'ko_specialty_instances');
        Drop_View('ko_specialties_dv', 'ko_specialties', 'MATERIALIZED VIEW');
        Drop_View('ko_unmapped_subjects_dv', 'ko_unmapped_subjects');
        Drop_View('ko_ambiguous_subjects_dv', 'ko_ambiguous_subjects');
        Drop_View('ko_mapped_subjects_dv', 'ko_mapped_subjects');
        IF how <> 'KEEP' THEN
            Drop_Index('subject_mappings_idx1');
            Drop_Index('subject_mappings_idx2');
            Drop_Trigger('subject_mappings_tr1');
            Drop_Sequence('subject_mappings_sq1');
        END IF;
        Drop_View('ko_sheet_infos_dv', 'ko_sheet_infos');
        Drop_View('ko_x_sheets_dv', 'ko_x_sheets', 'MATERIALIZED VIEW');
        Drop_View('ko_students_dv', 'ko_students');
        Drop_View('ko_subject_instances_dv', 'ko_subject_instances', 'MATERIALIZED VIEW');
        Drop_View('ko_x_trs_dv', 'ko_x_trs', 'MATERIALIZED VIEW');

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

        Drop_Table('program_mappings', 'program_mappings_dv', how);
        Drop_Table('subject_mappings', 'subject_mappings_dv', how);
        Drop_Table('ko_page_footer', how => how);
        Drop_Table('ko_page_header', how => how);
        Drop_Table('ko_page_preamble', how => how);
        Drop_Table('ko_page_tbody', how => how);
        Drop_Table('ko_report_sheets', how => how);
        Drop_Table('ko_sheet_pages', how => how);
        Drop_Table('ko_tbody_trs', how => how);
        Drop_Table('ko_footers', 'ko_footers_dv', how);
        Drop_Table('ko_headers', 'ko_headers_dv', how);
        Drop_Table('ko_pages', 'ko_pages_dv', how);
        Drop_Table('ko_preambles', 'ko_preambles_dv', how);
        Drop_Table('ko_reports', 'ko_reports_dv', how);
        Drop_Table('ko_sheets', 'ko_sheets_dv', how);
        Drop_Table('ko_tbodies', 'ko_tbodies_dv', how);
        Drop_Table('ko_trs', 'ko_trs_dv', how);
        Drop_Table('ko_jobs', 'ko_jobs_dv', how);
        Drop_Trigger('semesters_tr1');
        Drop_Table('semesters', 'semesters_dv', how);

        -- PACKAGES: all, except the V2U_Pkg package
        Drop_Package('Match');
        Drop_Package('Util');
        Drop_Package('To');

        Drop_Collect_Types();

        IF how <> 'KEEP' THEN
            Drop_Type('Program_Mapping_t', 'Program_Mappings_t');
        END IF;
        Drop_Type('Ko_Specialty_t');
        IF how <> 'KEEP' THEN
            Drop_Type('Subject_Mapping_t', 'Subject_Mappings_t');
        END IF;
        Drop_Type('Ko_Subject_Instance_t');
        Drop_Type('Ko_Thread_Indices_t');
        Drop_Type('Ko_Semester_Threads_t');
        Drop_Type('Ko_Semester_Instance_t', 'Ko_Semester_Instances_t');
        Drop_Type('Ko_Sheet_Info_t');
        Drop_Type('Ko_Student_t');
        Drop_Type('Ko_X_Sheet_t', 'Ko_X_Sheets_t');
        Drop_Type('Ko_X_Tr_t', 'Ko_X_Trs_t');
        IF how <> 'KEEP' THEN
            Drop_Type('Ko_Footer_t', 'Ko_Footers_t');
            Drop_Type('Ko_Header_t', 'Ko_Headers_t');
            Drop_Type('Ko_Page_t', 'Ko_Pages_t', 'Ko_Page_Refs_t');
            Drop_Type('Ko_Preamble_t', 'Ko_Preambles_t');
            Drop_Type('Ko_Report_t', 'Ko_Reports_t');
            Drop_Type('Ko_Sheet_t', 'Ko_Sheets_t', 'Ko_Sheet_Refs_t');
            Drop_Type('Ko_Tbody_t', 'Ko_Tbodies_t');
            Drop_Type('Ko_Tr_t', 'Ko_Trs_t', 'Ko_Tr_Refs_t');
            Drop_Type('Ko_Job_t', 'Ko_Jobs_t');
            Drop_Type('Semester_Codes_t');
            Drop_Type('Semester_t', 'Semesters_t');
        END IF;
        Drop_Type('Ko_Subj_Grades_t');
        Drop_Type('Ko_Ids_t');
    END;

END V2U_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
