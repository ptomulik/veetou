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
                         view_name IN VARCHAR2 := NULL)
    IS
    BEGIN
        IF view_name IS NOT NULL THEN
            Drop_If_Exists('VIEW', 'v2u_' || view_name);
        END IF;
        Drop_If_Exists('MATERIALIZED VIEW LOG ON', 'v2u_' || table_name);
        Drop_If_Exists('TABLE', 'v2u_' || table_name, how => 'PURGE');
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

    PROCEDURE Tier1_Dz
    IS
    BEGIN
        Drop_Table('dz_zaliczenia_przedmiotow');

        Drop_Index('dz_etapy_osob_idx1');
        Drop_Index('dz_etapy_osob_idx2');
        Drop_Table('dz_etapy_osob');
        --
        Drop_Index('dz_programy_osob_idx1');
        Drop_Index('dz_programy_osob_idx2');
        Drop_Index('dz_programy_osob_idx3');
        Drop_Index('dz_programy_osob_idx4');
        Drop_Table('dz_programy_osob');
        --
        Drop_Index('dz_programy_idx1');
        Drop_Index('dz_programy_idx2');
        Drop_Index('dz_programy_idx3');
        Drop_Table('dz_programy');
        --
        Drop_Index('dz_studenci_idx1');
        Drop_Table('dz_studenci');
        --
        Drop_Index('dz_zajecia_cykli_idx1');
        Drop_Table('dz_zajecia_cykli');
        --
        Drop_Index('dz_przedmioty_cykli_idx1');
        Drop_Index('dz_przedmioty_cykli_idx2');
        Drop_Table('dz_przedmioty_cykli');
        --
        Drop_Index('dz_atrybuty_przedm_idx1');
        Drop_Index('dz_atrybuty_przedm_idx2');
        Drop_Table('dz_atrybuty_przedmiotow');
        --
        Drop_Table('dz_przedmioty');

        Drop_Type('Dz_Zalicz_Przedmiotu_t', 'Dz_Zalicz_Przedmiotow_t');
        Drop_Type('Dz_Program_Osoby_t', 'Dz_Programy_Osob_t');
        Drop_Type('Dz_Etap_Osoby_t', 'Dz_Etapy_Osob_t');
        Drop_Type('Dz_Student_t', 'Dz_Studenci_t');
        Drop_Type('Dz_Program_t', 'Dz_Programy_t');
        Drop_Type('Dz_Atrybut_Przedmiotu_t', 'Dz_Atrybuty_Przedmiotow_t');
        Drop_Type('Dz_Przedmiot_t', 'Dz_Przedmioty_t');
        Drop_Type('Dz_Przedmiot_Cyklu_t', 'Dz_Przedmioty_Cykli_t');
        Drop_Type('Dz_Zajecia_Cyklu_t', 'Dz_Zajecia_Cykli_t');

        Drop_Type('Dz_Program_Osoby_B_t');
        Drop_Type('Dz_Program_B_t');
        Drop_Type('Dz_Etap_Osoby_B_t');
        Drop_Type('Dz_Student_B_t');
        Drop_Type('Dz_Atrybut_Przedmiotu_B_t');
        Drop_Type('Dz_Zalicz_Przedmiotu_B_t');
        Drop_Type('Dz_Przedmiot_B_t');
        Drop_Type('Dz_Przedmiot_Cyklu_B_t');
        Drop_Type('Dz_Zajecia_Cyklu_B_t');
    END;

    PROCEDURE Tier1_Ko
    IS
    BEGIN
        Drop_Index('ko_headers_idx1');
        Drop_Index('ko_preambles_idx1');
        Drop_Index('ko_preambles_idx2');
        Drop_Index('ko_preambles_idx3');
        Drop_Index('ko_preambles_idx4');
        Drop_Index('ko_preambles_idx5');
        Drop_Index('ko_trs_idx1');
        Drop_Index('ko_trs_idx2');

        Drop_Table('ko_page_footer_j');
        Drop_Table('ko_page_header_j');
        Drop_Table('ko_page_preamble_j');
        Drop_Table('ko_page_tbody_j');
        Drop_Table('ko_report_sheets_j');
        Drop_Table('ko_sheet_pages_j');
        Drop_Table('ko_tbody_trs_j');
        Drop_Table('ko_footers');
        Drop_Table('ko_headers');
        Drop_Table('ko_pages');
        Drop_Table('ko_preambles');
        Drop_Table('ko_reports');
        Drop_Table('ko_sheets');
        Drop_Table('ko_tbodies');
        Drop_Table('ko_trs');
        Drop_Table('ko_jobs');

        Drop_Type('Ko_Footer_t', 'Ko_Footers_t');
        Drop_Type('Ko_Header_t', 'Ko_Headers_t');
        Drop_Type('Ko_Page_t', 'Ko_Pages_t');
        Drop_Type('Ko_Preamble_t', 'Ko_Preambles_t');
        Drop_Type('Ko_Report_t', 'Ko_Reports_t');
        Drop_Type('Ko_Sheet_t', 'Ko_Sheets_t');
        Drop_Type('Ko_Tbody_t', 'Ko_Tbodies_t');
        Drop_Type('Ko_Tr_t', 'Ko_Trs_t');
        Drop_Type('Ko_Job_t', 'Ko_Jobs_t');
    END;

    PROCEDURE Tier1_Basis
    IS
    BEGIN
        Drop_Index('specialty_map_idx1');
        Drop_Index('specialty_map_idx2');
        Drop_Index('specialty_map_idx3');
        Drop_Trigger('specialty_map_tr1');
        Drop_Sequence('specialty_map_sq1');
        Drop_Table('specialty_map');

        Drop_Index('subject_map_idx1');
        Drop_Index('subject_map_idx2');
        Drop_Trigger('subject_map_tr1');
        Drop_Sequence('subject_map_sq1');
        Drop_Table('subject_map');

        Drop_Index('classes_map_idx1');
        Drop_Index('classes_map_idx2');
        Drop_Trigger('classes_map_tr1');
        Drop_Sequence('classes_map_sq1');
        Drop_Table('classes_map');

        Drop_Trigger('semesters_tr1');
        Drop_Table('semesters');

        Drop_Sequence('faculties_sq1');
        Drop_Trigger('faculties_tr1');
        Drop_Table('faculties');

        Drop_Sequence('universities_sq1');
        Drop_Trigger('universities_tr1');
        Drop_Table('universities');

        Drop_Package('Match');
        Drop_Package('Cmp');

        Drop_Type('Classes_Map_Pattern_t');
        Drop_Type('Subject_Map_Pattern_t');
        Drop_Type('Specialty_Map_Pattern_t');
        Drop_Type('Semester_Map_Pattern_t');

        Drop_Type('Classes_Pattern_t');
        Drop_Type('Subject_Pattern_t');
        Drop_Type('Specialty_Pattern_t');
        Drop_Type('Semester_Pattern_t');

        Drop_Type('Classes_Map_t', 'Classes_Maps_t');
        Drop_Type('Subject_Map_t', 'Subject_Maps_t');
        Drop_Type('Specialty_Map_t', 'Specialty_Maps_t');
        Drop_Type('Classes_Map_B_t');
        Drop_Type('Subject_Map_B_t');
        Drop_Type('Specialty_Map_B_t');

        Drop_Type('Semester_Codes_t');
        Drop_Type('Semester_t', 'Semesters_t');
        Drop_Type('Faculty_t', 'Faculties_t', 'Faculty_Codes_t');
        Drop_Type('University_t', 'Universities_t', 'University_Codes_t');
        Drop_Type('Distinct_t');
    END;

    PROCEDURE Tier1
    IS
    BEGIN
        Tier1_Ko();
        Tier1_Dz();
        Tier1_Basis();
    END;

    PROCEDURE Tier2
    IS
    BEGIN
        Drop_Index('ko_skipped_programs_j_idx1');
        Drop_Table('ko_skipped_programs_j');
        --
        Drop_Table('ko_missing_prgos_j');
        --
        Drop_Table('ko_missing_etpos_j');
        --
        Drop_Trigger('ko_missing_przedm_j_tr1');
        Drop_Sequence('ko_missing_przedm_j_sq1');
        Drop_Table('ko_missing_przedm_j');
        --
        Drop_Trigger('ko_missing_przcykl_j_tr1');
        Drop_Sequence('ko_missing_przcykl_j_sq1');
        Drop_Table('ko_missing_przcykl_j');
        --
        Drop_Trigger('ko_missing_zajcykl_j_tr1');
        Drop_Sequence('ko_missing_zajcykl_j_sq1');
        Drop_Table('ko_missing_zajcykl_j');
        --
        Drop_Index('ko_matched_etpos_j_idx1');
        Drop_Table('ko_matched_etpos_j');
        --
        Drop_Index('ko_matched_prgos_j_idx1');
        Drop_Table('ko_matched_prgos_j');
        --
        Drop_Trigger('ko_matched_przedm_j_tr1');
        Drop_Sequence('ko_matched_przedm_j_sq1');
        Drop_Table('ko_matched_przedm_j');
        --
        Drop_Trigger('ko_matched_przcykl_j_tr1');
        Drop_Sequence('ko_matched_przcykl_j_sq1');
        Drop_Table('ko_matched_przcykl_j');
        --
        Drop_Index('ko_matched_zajcykl_j_idx1');
        Drop_Trigger('ko_matched_zajcykl_j_tr1');
        Drop_Sequence('ko_matched_zajcykl_j_sq1');
        Drop_Table('ko_matched_zajcykl_j');
        --
        Drop_Index('ko_grades_j_idx1');
        Drop_Table('ko_grades_j');
        --
        Drop_Table('ko_student_sheets_j');
        Drop_Table('ko_student_specialties_j');
        Drop_Table('ko_student_semesters_j');
        --
        Drop_Trigger('ko_students_tr1');
        Drop_Sequence('ko_students_sq1');
        Drop_Index('ko_students_idx1');
        Drop_Table('ko_students');
        --
        Drop_Index('ko_classes_map_j_idx1');
        Drop_Index('ko_classes_map_j_idx2');
        Drop_Index('ko_classes_map_j_idx3');
        Drop_Index('ko_classes_map_j_idx4');
        Drop_Index('ko_classes_map_j_idx5');
        Drop_Table('ko_classes_map_j');
        --
        Drop_Table('ko_classes_semesters_j');
        --
        Drop_Index('ko_subject_map_j_idx1');
        Drop_Index('ko_subject_map_j_idx2');
        Drop_Index('ko_subject_map_j_idx3');
        Drop_Index('ko_subject_map_j_idx4');
        Drop_Table('ko_subject_map_j');
        --
        Drop_Table('ko_subject_semesters_j');
        --
        Drop_Table('ko_subject_trs_j');
        --
        Drop_Trigger('ko_subjects_tr1');
        Drop_Sequence('ko_subjects_sq1');
        Drop_Index('ko_subjects_idx1');
        Drop_Table('ko_subjects');
        --
        Drop_Index('ko_specialty_map_j_idx1');
        Drop_Table('ko_specialty_map_j');
        --
        Drop_Table('ko_specialty_sheets_j');
        Drop_Table('ko_semester_sheets_j');
        Drop_Table('ko_specialty_semesters_j');
        --
        Drop_Trigger('ko_semesters_tr1');
        Drop_Sequence('ko_semesters_sq1');
        Drop_Index('ko_semesters_idx1');
        Drop_Table('ko_semesters');
        --
        Drop_Trigger('ko_specialties_tr1');
        Drop_Sequence('ko_specialties_sq1');
        Drop_Table('ko_specialties');

        --
        Drop_Index('ux_classes_grades_idx1');
        Drop_Index('ux_classes_grades_idx2');
        Drop_Index('ux_classes_grades_idx3');
        Drop_Index('ux_classes_grades_idx4');
        Drop_Index('ux_classes_grades_idx5');
        Drop_Index('ux_classes_grades_idx6');
        Drop_Index('ux_classes_grades_idx7');
        Drop_Index('ux_classes_grades_idx8');
        Drop_Index('ux_classes_grades_idx9');
        Drop_Table('ux_classes_grades');
        --
        Drop_Table('ux_zaliczenia_przedmiotow');
        --
        Drop_Index('ux_etapy_osob_idx1');
        Drop_Index('ux_etapy_osob_idx2');
        Drop_Table('ux_etapy_osob');
        --
        Drop_Index('ux_programy_osob_idx1');
        Drop_Index('ux_programy_osob_idx2');
        Drop_Index('ux_programy_osob_idx3');
        Drop_Index('ux_programy_osob_idx4');
        Drop_Table('ux_programy_osob');
        --
        Drop_Index('ux_studenci_idx1');
        Drop_Table('ux_studenci');
        --
        Drop_Index('ux_zajecia_cykli_idx1');
        Drop_Trigger('ux_zajecia_cykli_tr1');
        Drop_Sequence('ux_zajecia_cykli_sq1');
        Drop_Table('ux_zajecia_cykli');
        --
        Drop_Index('ux_przedmioty_cykli_idx1');
        Drop_Index('ux_przedmioty_cykli_idx2');
        Drop_Table('ux_przedmioty_cykli');
        --
        Drop_Index('ux_atrybuty_przedm_idx1');
        Drop_Index('ux_atrybuty_przedm_idx2');
        Drop_Table('ux_atrybuty_przedmiotow');
        --
        Drop_Index('ux_przedmioty_idx1');
        Drop_Table('ux_przedmioty');

        --
        Drop_Package('Fit');
        Drop_Package('Get');
        Drop_Package('To');
        Drop_Package('Util');

        Drop_Collect_Types();

        Drop_Type('Ko_Skipped_Program_J_t', 'Ko_Skipped_Programs_J_t');
        Drop_Type('Ko_Missing_Prgos_J_t', 'Ko_Missing_Prgoses_J_t');
        Drop_Type('Ko_Missing_Etpos_J_t', 'Ko_Missing_Etposes_J_t');
        Drop_Type('Ko_Matched_Prgos_J_t', 'Ko_Matched_Prgoses_J_t');
        Drop_Type('Ko_Matched_Etpos_J_t', 'Ko_Matched_Etposes_J_t');
        Drop_Type('Ko_Missing_Zajcykl_J_t', 'Ko_Missing_Zajcykles_J_t');
        Drop_Type('Ko_Classes_Map_J_t', 'Ko_Classes_Maps_J_t');
        Drop_Type('Ko_Subject_Map_J_t', 'Ko_Subject_Maps_J_t');
        Drop_Type('Ko_Specialty_Map_J_t', 'Ko_Specialty_Maps_J_t');
        Drop_Type('Ko_Student_Semester_J_t', 'Ko_Student_Semesters_J_t');
        Drop_Type('Ko_Classes_Semester_J_t', 'Ko_Classes_Semesters_J_t');
        Drop_Type('Ko_Subject_Semester_J_t', 'Ko_Subject_Semesters_J_t');
        Drop_Type('Ko_Speclty_Semester_J_t', 'Ko_Speclty_Semesters_J_t');
        Drop_Type('Ko_Semester_J_t', 'Ko_Semesters_J_t');

        Drop_Type('Ko_Specialty_t');
        Drop_Type('Ko_Subject_t');
        Drop_Type('Ko_Semester_t', 'Ko_Semesters_t', 'Ko_Semester_Tables_t');
        Drop_Type('Ko_Student_t');
        Drop_Type('Ko_Distinct_t');

        Drop_Type('Ux_Classes_Grade_t', 'Ux_Classes_Grades_t');
        Drop_Type('Ux_Etap_Osoby_t', 'Ux_Etapy_Osob_t');
        Drop_Type('Ux_Program_Osoby_t', 'Ux_Programy_Osob_t');
        Drop_Type('Ux_Student_t', 'Ux_Studenci_t');
        Drop_Type('Ux_Atrybut_Przedmiotu_t', 'Ux_Atrybuty_Przedmiotow_t');
        Drop_Type('Ux_Zalicz_Przedmiotu_t', 'Ux_Zalicz_Przedmiotow_t');
        Drop_Type('Ux_Przedmiot_t', 'Ux_Przedmioty_t');
        Drop_Type('Ux_Przedmiot_Cyklu_t', 'Ux_Przedmioty_Cykli_t');
        Drop_Type('Ux_Zajecia_Cyklu_t', 'Ux_Zajecia_Cykli_t');

        Drop_Type('Semester_Codes_t');
        Drop_Type('Program_Codes_t');
        Drop_Type('Subj_Grades_t');
        Drop_Type('Subj_Codes_t');
        Drop_Type('Subj_5Grades_t');
        Drop_Type('Subj_5Codes_t');
        Drop_Type('Ids_t');
        Drop_Type('Dz_Ids_t');
        Drop_Type('5Ids_t');
        Drop_Type('Dz_5Ids_t');
        Drop_Type('Integers_t');
        Drop_Type('Chars1_t');
        Drop_Type('5Chars1_t');
        Drop_Type('Chars3_t');
        Drop_Type('5Chars3_t');
        Drop_Type('Vchars1K_t');
        Drop_Type('5Vchars1K_t');
        Drop_Type('Ints2_t');
        Drop_Type('Ints4_t');
        Drop_Type('Subj_20Grades_t');
        Drop_Type('Subj_20Codes_t');
        Drop_Type('Program_5Codes_t');
    END;

    PROCEDURE Tier3
    IS
    BEGIN
        Drop_View('ux_subject_grades_v');

        Drop_View('ko_skipped_programs_v');
        Drop_View('ko_missing_zajcykl_v');
        Drop_View('ko_missing_przcykl_v');
        Drop_View('ko_missing_przedm_v');
        Drop_View('ko_missing_etpos_v');
        Drop_View('ko_missing_prgos_v');
        Drop_View('ko_matched_prgos_v');
        Drop_View('ko_matched_etpos_v');
        Drop_View('ko_matched_zajcykl_v');
        Drop_View('ko_matched_przcykl_v');
        Drop_View('ko_matched_przedm_v');
        Drop_View('ko_ambig_speclty_map_v');
        Drop_View('ko_ambig_subject_map_v');
        Drop_View('ko_missing_subject_map_v');
        Drop_View('ko_missing_speclty_map_v');
        Drop_View('ko_unmapped_specialties_v');
        Drop_View('ko_unmapped_subjects_v');
        Drop_View('ko_specialty_map_v');
        Drop_View('ko_classes_map_v');
        Drop_View('ko_subject_map_v');
        Drop_View('ko_speclty_semesters_v');
        Drop_View('ko_classes_semesters_v');
        Drop_View('ko_subject_semesters_v');
        Drop_View('ko_student_semesters_v');
        Drop_View('ko_grades_v');

--        Drop_Collect_Types();
--

        Drop_Type('Ux_Subject_Grade_V_t');
        Drop_Type('Ko_Skipped_Program_V_t', 'Ko_Skipped_Programs_V_t');
        Drop_Type('Ko_Matched_Etpos_V_t', 'Ko_Matched_Etposes_V_t');
        Drop_Type('Ko_Matched_Prgos_V_t', 'Ko_Matched_Prgoses_V_t');
        Drop_Type('Ko_Matched_Przedm_V_t', 'Ko_Matched_Przedms_V_t');
        Drop_Type('Ko_Matched_Przcykl_V_t', 'Ko_Matched_Przcykles_V_t');
        Drop_Type('Ko_Matched_Zajcykl_V_t', 'Ko_Matched_Zajcykles_V_t');
        Drop_Type('Ko_Missing_Zajcykl_V_t', 'Ko_Missing_Zajcykles_V_t');
        Drop_Type('Ko_Missing_Przcykl_V_t', 'Ko_Missing_Przcykles_V_t');
        Drop_Type('Ko_Missing_Przedm_V_t', 'Ko_Missing_Przedms_V_t');
        Drop_Type('Ko_Missing_Etpos_V_t', 'Ko_Missing_Etposes_V_t');
        Drop_Type('Ko_Missing_Prgos_V_t', 'Ko_Missing_Prgoses_V_t');
        Drop_Type('Ko_Missing_Subject_Map_V_t');
        Drop_Type('Ko_Missing_Speclty_Map_V_t');
--        Drop_Type('Ko_Missing_Subj_Map_V_t', 'Ko_Missing_Subj_Maps_V_t');
        Drop_Type('Ko_Ambig_Speclty_Map_V_t', 'Ko_Ambig_Speclty_Maps_V_t');
        Drop_Type('Ko_Ambig_Subject_Map_V_t', 'Ko_Ambig_Subject_Maps_V_t');
        Drop_Type('Ko_Specialty_Map_V_t', 'Ko_Specialty_Maps_V_t');
        Drop_Type('Ko_Classes_Map_V_t', 'Ko_Classes_Maps_V_t');
        Drop_Type('Ko_Subject_Map_V_t', 'Ko_Subject_Maps_V_t');
        Drop_Type('Ko_Speclty_Semester_V_t', 'Ko_Speclty_Semesters_V_t');
        Drop_Type('Ko_Classes_Semester_V_t', 'Ko_Classes_Semesters_V_t');
        Drop_Type('Ko_Subject_Semester_V_t', 'Ko_Subject_Semesters_V_t');
        Drop_Type('Ko_Student_Semester_V_t', 'Ko_Student_Semesters_V_t');
        Drop_Type('Ko_Grade_V_t', 'Ko_Grades_V_t');
    END;

END V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
