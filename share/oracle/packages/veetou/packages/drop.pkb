CREATE OR REPLACE PACKAGE BODY V2U_Drop AS
    FUNCTION Is_Not_Exists_Errcode(schema_type IN VARCHAR2, err_code IN NUMBER)
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


    PROCEDURE Drop_DB_Object(schema_type IN VARCHAR2,
                             name IN VARCHAR2,
                             how IN VARCHAR2 := '')
    IS
        cmd VARCHAR2(1024);
    BEGIN
        cmd := 'DROP ' || UPPER(schema_type) || ' ' || name || ' ' || how;
        DBMS_Utility.Exec_DDL_Statement(cmd);
    END;


    PROCEDURE Drop_If_Exists(schema_type IN VARCHAR2,
                             name IN VARCHAR2,
                             how IN VARCHAR2 := '')
    IS
    BEGIN
        Drop_DB_Object(schema_type, name, how=>how);
    EXCEPTION
        WHEN OTHERS THEN
            IF NOT Is_Not_Exists_Errcode(schema_type, SQLCODE) THEN
                RAISE;
            END IF;
    END;

    PROCEDURE Drop_Type(type_name IN VARCHAR2,
                        dependent_type1 IN VARCHAR2 := NULL,
                        dependent_type2 IN VARCHAR2 := NULL)
    IS
    BEGIN
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
            WHERE OBJECT_TYPE = 'TYPE' AND (
                OBJECT_NAME LIKE 'ST0000%' OR
                OBJECT_NAME LIKE 'SYSTP%'
            );
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


    PROCEDURE Drop_Table(table_name IN VARCHAR2,
                         view_name IN VARCHAR2 := NULL,
                         how IN VARCHAR2 := '')
    IS
    BEGIN
        IF view_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'v2u_' || view_name);
        END IF;
        Drop_If_Exists('MATERIALIZED VIEW LOG ON', 'v2u_' || table_name);
        IF how <> 'KEEP' THEN
            Drop_If_Exists('TABLE', 'v2u_' || table_name, how=>how);
        END IF;
    END;


    PROCEDURE Drop_View(view_name IN VARCHAR2,
                        dependent_view IN VARCHAR2 := NULL,
                        dependent_kind IN VARCHAR2 := NULL)
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

    PROCEDURE Drop_Materialized_View(view_name IN VARCHAR2,
                                     dependent_view IN VARCHAR2 := NULL,
                                     dependent_kind IN VARCHAR2 := NULL)
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


    PROCEDURE Drop_Index(index_name IN VARCHAR2)
    IS
    BEGIN
        Drop_If_Exists('INDEX', 'v2u_' || index_name);
    END;


    PROCEDURE Drop_Sequence(sequence_name IN VARCHAR2)
    IS
    BEGIN
        Drop_If_Exists('SEQUENCE', 'v2u_' || sequence_name);
    END;


    PROCEDURE Drop_Trigger(sequence_name IN VARCHAR2)
    IS
    BEGIN
        Drop_If_Exists('TRIGGER', 'v2u_' || sequence_name);
    END;


    PROCEDURE Drop_Package(package_name IN VARCHAR2)
    IS
    BEGIN
        Drop_If_Exists('PACKAGE', 'V2U_' || package_name);
    END;

    PROCEDURE Primaries
    IS
    BEGIN
        Drop_Index('specmap_idx1');
        Drop_Index('specmap_idx2');
        Drop_Index('specmap_idx3');
        Drop_Trigger('specialty_map_tr1');
        Drop_Sequence('specialty_map_sq1');
        Drop_Table('specialty_map', how => 'PURGE');

        Drop_Index('subject_map_idx1');
        Drop_Index('subject_map_idx2');
        Drop_Trigger('subject_map_tr1');
        Drop_Sequence('subject_map_sq1');
        Drop_Table('subject_map', how => 'PURGE');

        Drop_Index('ko_headers_idx1');
        Drop_Index('ko_preambles_idx1');
        Drop_Index('ko_preambles_idx2');
        Drop_Index('ko_preambles_idx3');
        Drop_Index('ko_preambles_idx4');
        Drop_Index('ko_preambles_idx5');
        Drop_Index('ko_trs_idx1');
        Drop_Index('ko_trs_idx2');

        Drop_Table('ko_page_footer_j', how => 'PURGE');
        Drop_Table('ko_page_header_j', how => 'PURGE');
        Drop_Table('ko_page_preamble_j', how => 'PURGE');
        Drop_Table('ko_page_tbody_j', how => 'PURGE');
        Drop_Table('ko_report_sheets_j', how => 'PURGE');
        Drop_Table('ko_sheet_pages_j', how => 'PURGE');
        Drop_Table('ko_tbody_trs_j', how => 'PURGE');
        Drop_Table('ko_footers', how => 'PURGE');
        Drop_Table('ko_headers', how => 'PURGE');
        Drop_Table('ko_pages', how => 'PURGE');
        Drop_Table('ko_preambles', how => 'PURGE');
        Drop_Table('ko_reports', how => 'PURGE');
        Drop_Table('ko_sheets', how => 'PURGE');
        Drop_Table('ko_tbodies', how => 'PURGE');
        Drop_Table('ko_trs', how => 'PURGE');
        Drop_Table('ko_jobs', how => 'PURGE');

        Drop_Trigger('semesters_tr1');
        Drop_Table('semesters', how => 'PURGE');

        Drop_Sequence('faculties_sq1');
        Drop_Trigger('faculties_tr1');
        Drop_Table('faculties', how => 'PURGE');

        Drop_Sequence('universities_sq1');
        Drop_Trigger('universities_tr1');
        Drop_Table('universities', how => 'PURGE');

        Drop_Package('Util');
        Drop_Package('Match');
        Drop_Package('Get');
        Drop_Package('Cmp');

        Drop_Type('Specialty_Map_t', 'Specialty_Maps_t');
        Drop_Type('Subject_Map_t', 'Subject_Maps_t');
        Drop_Type('Ko_Footer_t', 'Ko_Footers_t');
        Drop_Type('Ko_Header_t', 'Ko_Headers_t');
        Drop_Type('Ko_Page_t', 'Ko_Pages_t');
        Drop_Type('Ko_Preamble_t', 'Ko_Preambles_t');
        Drop_Type('Ko_Report_t', 'Ko_Reports_t');
        Drop_Type('Ko_Sheet_t', 'Ko_Sheets_t');
        Drop_Type('Ko_Tbody_t', 'Ko_Tbodies_t');
        Drop_Type('Ko_Tr_t', 'Ko_Trs_t');
        Drop_Type('Ko_Job_t', 'Ko_Jobs_t');
        Drop_Type('Semester_Codes_t');
        Drop_Type('Semester_t', 'Semesters_t');
        Drop_Type('Faculty_t', 'Faculties_t', 'Faculty_Codes_t');
        Drop_Type('University_t', 'Universities_t', 'University_Codes_t');

--        Drop_Type('Subj_Grades_t');
--        Drop_Type('Subj_Codes_t');
--        Drop_Type('Ids_t');
--        Drop_Type('Integers_t');
--        Drop_Type('Subj_20Grades_t');
--        Drop_Type('Subj_20Codes_t');
--        Drop_Type('5Ids_t');
    END;

    PROCEDURE Secondaries
    IS
    BEGIN
        Drop_View('ko_unmapped_specialties_v');
        Drop_View('ko_ambiguous_specialties_v');
        Drop_View('ko_mapped_specialties_v');
        Drop_View('ko_unmapped_subjects_v');
        Drop_View('ko_ambiguous_subjects_v');
        Drop_View('ko_mapped_subjects_v');
        Drop_View('ko_student_specialties_v');
        Drop_View('ko_student_specialties_h');
        Drop_Materialized_View('ko_sh_hdr_preamb_h');
        Drop_Materialized_View('ko_tr_hdr_preamb_h');
        Drop_View('ko_x_sheets_h');
        Drop_View('ko_x_sheets_v');
        Drop_View('ko_x_trs_h');
        Drop_View('ko_x_trs_v');

        --
        Drop_Table('ko_student_sheets_j', how => 'PURGE');
        Drop_Table('ko_student_specialties_j', how => 'PURGE');
        --
        Drop_Trigger('ko_students_tr1');
        Drop_Sequence('ko_students_sq1');
        Drop_Index('ko_students_idx1');
        Drop_Table('ko_students', how => 'PURGE');
        --
        Drop_Table('ko_subject_map_j', how => 'PURGE');
        Drop_Table('ko_subject_trs_j', how => 'PURGE');
        --
        Drop_Trigger('ko_subject_entities_tr1');
        Drop_Sequence('ko_subject_entities_sq1');
        Drop_Index('ko_subject_entities_idx1');
        Drop_Table('ko_subject_entities', how => 'PURGE');
        --
        Drop_Table('ko_specialty_map_j', how=>'PURGE');
        Drop_Table('ko_specialty_sheets_j', how => 'PURGE');
        --
        Drop_Trigger('ko_specialties_tr1');
        Drop_Sequence('ko_specialties_sq1');
        Drop_Table('ko_specialties', how => 'PURGE');
        --
        Drop_Trigger('ko_specialty_entities_tr1');
        Drop_Sequence('ko_specialty_entities_sq1');
        Drop_Sequence('ko_specialty_entities_idx1');
        Drop_Sequence('ko_specialty_entities_idx2');
        Drop_Table('ko_specialty_entities', how => 'PURGE');
        --

        --
        Drop_Package('Fit');
        Drop_Package('To');

        Drop_Collect_Types();

        Drop_Type('Ko_Mapped_Subject_t', 'Ko_Mapped_Subjects_t');
        Drop_Type('Ko_Mapped_Specialty_t', 'Ko_Mapped_Specialties_t');
        Drop_Type('Ko_Student_Specialty_H_t');
        Drop_Type('Ko_Specialty_t');
        Drop_Type('Ko_Specialty_Entity_t', 'Ko_Specialty_Entities_t');
        Drop_Type('Ko_Subject_Entity_t');
        Drop_Type('Ko_Thread_Indices_t');
        Drop_Type('Ko_Semester_Threads_t');
        Drop_Type('Ko_Semester_Instance_t', 'Ko_Semester_Instances_t');
        Drop_Type('Ko_Student_t');
        Drop_Type('Ko_Sh_Hdr_Preamb_H_t', 'Ko_Sh_Hdr_Preambs_H_t');
        Drop_Type('Ko_Tr_Hdr_Preamb_H_t', 'Ko_Tr_Hdr_Preambs_H_t');
        Drop_Type('Ko_X_Sheet_H_t', 'Ko_X_Sheets_H_t');
        Drop_TYpe('Ko_X_Sheet_Pages_t');
        Drop_TYpe('Ko_X_Sheet_Footers_t');
        Drop_Type('Ko_X_Tr_H_t', 'Ko_X_Trs_H_t');

        Drop_Type('Subj_Grades_t');
        Drop_Type('Subj_Codes_t');
        Drop_Type('Ids_t');
        Drop_Type('Integers_t');
        Drop_Type('Subj_20Grades_t');
        Drop_Type('Subj_20Codes_t');
        Drop_Type('5Ids_t');
    END;


END V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
