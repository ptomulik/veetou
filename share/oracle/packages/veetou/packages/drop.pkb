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


    PROCEDURE Drop_Seqnc(sequence_name IN VARCHAR2)
    IS
    BEGIN
        Drop_If_Exists('SEQUENCE', 'v2u_' || sequence_name);
    END;


    PROCEDURE Drop_Trigg(sequence_name IN VARCHAR2)
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
        Drop_Trigg('dz_prowadzacy_grup_tr0');
        Drop_Table('dz_prowadzacy_grup');
        --
        Drop_Trigg('dz_osoby_grup_tr0');
        Drop_Table('dz_osoby_grup');
        --
        Drop_Trigg('dz_grupy_tr0');
        Drop_Table('dz_grupy');
        --
        Drop_Trigg('dz_zal_przedm_prgos_tr0');
        Drop_Table('dz_zal_przedm_prgos');
        --
        Drop_Trigg('dz_zaliczenia_przedm_tr0');
        Drop_Table('dz_zaliczenia_przedmiotow');
        --
        Drop_Trigg('dz_etapy_tr0');
        Drop_Table('dz_etapy');
        --
        Drop_Trigg('dz_decyzje_tr0');
        Drop_Table('dz_decyzje');
        --
        Drop_Trigg('dz_etapy_programow_tr0');
        Drop_Index('dz_etapy_programow_idx1');
        Drop_Index('dz_etapy_programow_idx2');
        Drop_Index('dz_etapy_programow_idx3');
        Drop_Table('dz_etapy_programow');
        --
        Drop_Trigg('dz_etapy_kierunkow_tr0');
        Drop_Index('dz_etapy_kierunkow_idx1');
        Drop_Index('dz_etapy_kierunkow_idx2');
        Drop_Table('dz_etapy_kierunkow');
        --
        Drop_Trigg('dz_etapy_osob_tr0');
        Drop_Index('dz_etapy_osob_idx1');
        Drop_Index('dz_etapy_osob_idx2');
        Drop_Table('dz_etapy_osob');
        --
        Drop_Trigg('dz_programy_osob_tr0');
        Drop_Index('dz_programy_osob_idx1');
        Drop_Index('dz_programy_osob_idx2');
        Drop_Index('dz_programy_osob_idx3');
        Drop_Index('dz_programy_osob_idx4');
        Drop_Table('dz_programy_osob');
        --
        Drop_Trigg('dz_programy_tr0');
        Drop_Index('dz_programy_idx1');
        Drop_Index('dz_programy_idx2');
        Drop_Index('dz_programy_idx3');
        Drop_Table('dz_programy');
        --
        Drop_Trigg('dz_osoby_tr1');
        Drop_Seqnc('dz_osoby_sq1');
        Drop_Trigg('dz_osoby_tr0');
        Drop_Index('dz_osoby_idx1');
        Drop_Index('dz_osoby_idx2');
        Drop_Table('dz_osoby');
        --
        Drop_Trigg('dz_studenci_tr0');
        Drop_Index('dz_studenci_idx1');
        Drop_Table('dz_studenci');
        --
        Drop_Trigg('dz_pracownicy_tr1');
        Drop_Seqnc('dz_pracownicy_sq1');
        Drop_Trigg('dz_pracownicy_tr0');
        Drop_Index('dz_pracownicy_idx1');
        Drop_Index('dz_pracownicy_idx2');
        Drop_Table('dz_pracownicy');
        --
        Drop_Trigg('dz_zajecia_cykli_tr0');
        Drop_Trigg('dz_zajecia_cykli_tr1');
        Drop_Seqnc('dz_zajecia_cykli_sq1');
        Drop_Index('dz_zajecia_cykli_idx1');
        Drop_Table('dz_zajecia_cykli');
        --
        Drop_Trigg('dz_zajecia_prz_obcych_tr0');
        Drop_Index('dz_zajecia_prz_obcych_idx1');
        Drop_Table('dz_zajecia_prz_obcych');
        --
        Drop_Trigg('dz_prow_prz_cykli_tr1');
        Drop_Seqnc('dz_prow_prz_cykli_sq1');
        Drop_Trigg('dz_prow_prz_cykli_tr0');
        Drop_Index('dz_prow_prz_cykli_idx1');
        Drop_Index('dz_prow_prz_cykli_idx2');
        Drop_Index('dz_prow_prz_cykli_idx3');
        Drop_Index('dz_prow_prz_cykli_idx4');
        Drop_Table('dz_prow_prz_cykli');
        --
        Drop_Trigg('dz_przedmioty_cykli_tr0');
        Drop_Index('dz_przedmioty_cykli_idx1');
        Drop_Index('dz_przedmioty_cykli_idx2');
        Drop_Table('dz_przedmioty_cykli');
        --
        Drop_Trigg('dz_punkty_przedmiotow_tr0');
        Drop_Trigg('dz_punkty_przedmiotow_tr1');
        Drop_Seqnc('dz_punkty_przedmiotow_sq1');
        Drop_Index('dz_punkty_przedmiotow_idx1');
        Drop_Index('dz_punkty_przedmiotow_idx2');
        Drop_Index('dz_punkty_przedmiotow_idx3');
        Drop_Index('dz_punkty_przedmiotow_idx4');
        Drop_Index('dz_punkty_przedmiotow_idx5');
        Drop_Index('dz_punkty_przedmiotow_idx6');
        Drop_Table('dz_punkty_przedmiotow');
        --
        Drop_Trigg('dz_atrybuty_przedm_tr0');
        Drop_Trigg('dz_atrybuty_przedm_tr1');
        Drop_Seqnc('dz_atrybuty_przedm_sq1');
        Drop_Index('dz_atrybuty_przedm_idx1');
        Drop_Index('dz_atrybuty_przedm_idx2');
        Drop_Table('dz_atrybuty_przedmiotow');
        --
        Drop_Trigg('dz_przedmioty_tr0');
        Drop_Table('dz_przedmioty');
        --
        Drop_Trigg('dz_przedmioty_obce_tr0');
        Drop_Table('dz_przedmioty_obce');
        --
        Drop_Trigg('dz_oceny_tr0');
        Drop_Table('dz_oceny');
        --
        Drop_Trigg('dz_wartosci_ocen_tr0');
        Drop_Table('dz_wartosci_ocen');
        --
        Drop_Index('dz_terminy_protokolow_idx1');
        Drop_Trigg('dz_terminy_protokolow_tr0');
        Drop_Table('dz_terminy_protokolow');
        --
        Drop_Trigg('dz_protokoly_tr0');
        Drop_Index('dz_protokoly_idx1');
        Drop_Index('dz_protokoly_idx2');
        Drop_Index('dz_protokoly_idx3');
        Drop_Index('dz_protokoly_idx4');
        Drop_Trigg('dz_protokoly_tr1');
        Drop_Seqnc('dz_protokoly_sq1');
        Drop_Table('dz_protokoly');
        --

        Drop_Type('Dz_Prowadzacy_Grupe_t', 'Dz_Prowadzacy_Grup_t');
        Drop_Type('Dz_Osoba_Grupy_t', 'Dz_Osoby_Grup_t');
        Drop_Type('Dz_Grupa_t', 'Dz_Grupy_t');
        Drop_Type('Dz_Protokol_t', 'Dz_Protokoly_t');
        Drop_Type('Dz_Termin_Protokolu_t', 'Dz_Terminy_Protokolow_t');
        Drop_Type('Dz_Ocena_t', 'Dz_Oceny_t');
        Drop_Type('Dz_Wartosc_Oceny_t', 'Dz_Wartosci_Ocen_t');
        Drop_Type('Dz_Zalicz_Przedmiotu_t', 'Dz_Zalicz_Przedmiotow_t');
        Drop_Type('Dz_Zal_Przedm_Prgos_t', 'Dz_Zal_Przedm_Prgoses_t');
        Drop_Type('Dz_Program_Osoby_t', 'Dz_Programy_Osob_t');
        Drop_Type('Dz_Decyzja_t', 'Dz_Decyzje_t');
        Drop_Type('Dz_Etap_t', 'Dz_Etapy_t');
        Drop_Type('Dz_Etap_Programu_t', 'Dz_Etapy_Programow_t');
        Drop_Type('Dz_Etap_Kierunku_t', 'Dz_Etapy_Kierunkow_t');
        Drop_Type('Dz_Etap_Osoby_t', 'Dz_Etapy_Osob_t');
        Drop_Type('Dz_Pracownik_t', 'Dz_Pracownicy_t');
        Drop_Type('Dz_Student_t', 'Dz_Studenci_t');
        Drop_Type('Dz_Osoba_t', 'Dz_Osoby_t');
        Drop_Type('Dz_Program_t', 'Dz_Programy_t');
        Drop_Type('Dz_Atrybut_Przedmiotu_t', 'Dz_Atrybuty_Przedmiotow_t');
        Drop_Type('Dz_Przedmiot_t', 'Dz_Przedmioty_t');
        Drop_Type('Dz_Przedmiot_Obcy_t', 'Dz_Przedmioty_Obce_t');
        Drop_Type('Dz_Punkty_Przedmiotu_t', 'Dz_Punkty_Przedmiotow_t');
        Drop_Type('Dz_Przedmiot_Cyklu_t', 'Dz_Przedmioty_Cykli_t');
        Drop_Type('Dz_Prow_Prz_Cyklu_t', 'Dz_Prow_Prz_Cykli_t');
        Drop_Type('Dz_Zajecia_Cyklu_t', 'Dz_Zajecia_Cykli_t');
        Drop_Type('Dz_Zajecia_Prz_Obcego_t', 'Dz_Zajecia_Prz_Obcych_t');

        Drop_Type('Dz_Program_Osoby_B_t');
        Drop_Type('Dz_Program_B_t');
        Drop_Type('Dz_Decyzja_B_t');
        Drop_Type('Dz_Etap_B_t');
        Drop_Type('Dz_Etap_Programu_B_t');
        Drop_Type('Dz_Etap_Kierunku_B_t');
        Drop_Type('Dz_Etap_Osoby_B_t');
        Drop_Type('Dz_Pracownik_B_t');
        Drop_Type('Dz_Student_B_t');
        Drop_Type('Dz_Osoba_B_t');
        Drop_Type('Dz_Atrybut_Przedmiotu_B_t');
        Drop_Type('Dz_Zal_Przedm_Prgos_B_t');
        Drop_Type('Dz_Zalicz_Przedmiotu_B_t');
        Drop_Type('Dz_Przedmiot_B_t');
        Drop_Type('Dz_Przedmiot_Obcy_B_t');
        Drop_Type('Dz_Prow_Prz_Cyklu_B_t');
        Drop_Type('Dz_Przedmiot_Cyklu_B_t');
        Drop_Type('Dz_Przedmiot_Cyklu_B_t');
        Drop_Type('Dz_Punkty_Przedmiotu_B_t');
        Drop_Type('Dz_Zajecia_Cyklu_B_t');
        Drop_Type('Dz_Zajecia_Prz_Obcego_B_t');
        Drop_Type('Dz_Ocena_B_t');
        Drop_Type('Dz_Wartosc_Oceny_B_t');
        Drop_Type('Dz_Termin_Protokolu_B_t');
        Drop_Type('Dz_Protokol_B_t');
        Drop_Type('Dz_Grupa_B_t');
        Drop_Type('Dz_Osoba_Grupy_B_t');
        Drop_Type('Dz_Prowadzacy_Grupe_B_t');
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
        Drop_Index('protocol_map_idx1');
        Drop_Trigg('protocol_map_tr1');
        Drop_Seqnc('protocol_map_sq1');
        Drop_Table('protocol_map');

        Drop_Index('specialty_map_idx1');
        Drop_Index('specialty_map_idx2');
        Drop_Index('specialty_map_idx3');
        Drop_Trigg('specialty_map_tr1');
        Drop_Seqnc('specialty_map_sq1');
        Drop_Table('specialty_map');

        Drop_Index('subject_map_idx1');
        Drop_Index('subject_map_idx2');
        Drop_Index('subject_map_idx3');
        Drop_Trigg('subject_map_tr1');
        Drop_Seqnc('subject_map_sq1');
        Drop_Table('subject_map');

        Drop_Index('classes_map_idx1');
        Drop_Index('classes_map_idx2');
        Drop_Trigg('classes_map_tr1');
        Drop_Seqnc('classes_map_sq1');
        Drop_Table('classes_map');

        Drop_Trigg('semesters_tr1');
        Drop_Table('semesters');

        Drop_Seqnc('faculties_sq1');
        Drop_Trigg('faculties_tr1');
        Drop_Table('faculties');

        Drop_Seqnc('universities_sq1');
        Drop_Trigg('universities_tr1');
        Drop_Table('universities');

        Drop_Package('Match');
        Drop_Package('Cmp');

        Drop_Type('Protocol_Map_Pattern_t');
        Drop_Type('Classes_Map_Pattern_t');
        Drop_Type('Subject_Map_Pattern_t');
        Drop_Type('Specialty_Map_Pattern_t');
        Drop_Type('Semester_Map_Pattern_t');

        Drop_Type('Grade_Pattern_t');
        Drop_Type('Student_Pattern_t');
        Drop_Type('Classes_Pattern_t');
        Drop_Type('Subject_Pattern_t');
        Drop_Type('Specialty_Pattern_t');
        Drop_Type('Semester_Pattern_t');

        Drop_Type('Protocol_Map_t', 'Protocol_Maps_t');
        Drop_Type('Classes_Map_t', 'Classes_Maps_t');
        Drop_Type('Subject_Map_t', 'Subject_Maps_t');
        Drop_Type('Specialty_Map_t', 'Specialty_Maps_t');
        Drop_Type('Protocol_Map_B_t');
        Drop_Type('Classes_Map_B_t');
        Drop_Type('Subject_Map_B_t');
        Drop_Type('Specialty_Map_B_t');

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
        --
        Drop_Index('ko_skipped_programs_j_idx1');
        Drop_Table('ko_skipped_programs_j');
        --
        Drop_Table('ko_missing_zpprgos_j');
        --
        Drop_Table('ko_missing_zalprz_j');
        --
        Drop_Index('ko_missing_oceny_j_idx1');
        Drop_Index('ko_missing_oceny_j_idx2');
        Drop_Index('ko_missing_oceny_j_idx3');
        Drop_Table('ko_missing_oceny_j');
        --
        Drop_Table('ko_missing_prgos_j');
        --
        Drop_Table('ko_missing_etpos_j');
        --
        Drop_Table('ko_missing_przedm_j');
        --
        Drop_Table('ko_missing_przcykl_j');
        --
        Drop_Table('ko_missing_zajcykl_j');
        --
        Drop_Table('ko_missing_pktprz_j');
        --
        Drop_Index('ko_missing_trmpro_j_idx1');
        Drop_Index('ko_missing_trmpro_j_idx2');
        Drop_Index('ko_missing_trmpro_j_idx3');
        Drop_Index('ko_missing_trmpro_j_idx4');
        Drop_Table('ko_missing_trmpro_j');
        --
        Drop_Table('ko_missing_protos_j');
        --
        Drop_Index('ko_matched_etpos_j_idx1');
        Drop_Table('ko_matched_etpos_j');
        --
        Drop_Index('ko_matched_prgos_j_idx1');
        Drop_Table('ko_matched_prgos_j');
        --
        Drop_Table('ko_matched_przedm_j');
        --
        Drop_Table('ko_matched_przcykl_j');
        --
        Drop_Index('ko_matched_zajcykl_j_idx1');
        Drop_Table('ko_matched_zajcykl_j');
        --
        Drop_Table('ko_matched_pktprz_j');
        --
        Drop_Index('ko_matched_trmpro_j_idx1');
        Drop_Index('ko_matched_trmpro_j_idx2');
        Drop_Index('ko_matched_trmpro_j_idx3');
        Drop_Index('ko_matched_trmpro_j_idx4');
        Drop_Table('ko_matched_trmpro_j');
        --
        Drop_Index('ko_matched_protos_j_idx1');
        Drop_Index('ko_matched_protos_j_idx2');
        Drop_Table('ko_matched_protos_j');
        --
        Drop_Index('ko_matched_oceny_j_idx1');
        Drop_Index('ko_matched_oceny_j_idx2');
        Drop_Index('ko_matched_oceny_j_idx3');
        Drop_Table('ko_matched_oceny_j');
        --
        Drop_Index('ko_matched_zpprgos_j_idx1');
        Drop_Index('ko_matched_zpprgos_j_idx2');
        Drop_Index('ko_matched_zpprgos_j_idx3');
        Drop_Table('ko_matched_zpprgos_j');
        --
        Drop_Index('ko_matched_zalprz_j_idx1');
        Drop_Index('ko_matched_zalprz_j_idx2');
        Drop_Table('ko_matched_zalprz_j');
        --
        Drop_Index('ko_grades_j_idx1');
        Drop_Index('ko_grades_j_idx2');
        Drop_Index('ko_grades_j_idx3');
        Drop_Table('ko_grades_j');
        --
        Drop_Table('ko_student_sheets_j');
        Drop_Table('ko_student_specialties_j');
        Drop_Table('ko_student_semesters_j');
        --
        Drop_Trigg('ko_students_tr1');
        Drop_Seqnc('ko_students_sq1');
        Drop_Index('ko_students_idx1');
        Drop_Table('ko_students');
        --
        Drop_Table('ko_protocol_map_j');
        --
        Drop_Index('ko_classes_map_j_idx1');
        Drop_Index('ko_classes_map_j_idx2');
        Drop_Index('ko_classes_map_j_idx3');
        Drop_Index('ko_classes_map_j_idx4');
        Drop_Index('ko_classes_map_j_idx5');
        Drop_Index('ko_classes_map_j_idx6');
        Drop_Index('ko_classes_map_j_idx7');
        Drop_Table('ko_classes_map_j');
        --
        Drop_Table('ko_classes_semesters_j');
        --
        Drop_Index('ko_subject_map_j_idx1');
        Drop_Index('ko_subject_map_j_idx2');
        Drop_Index('ko_subject_map_j_idx3');
        Drop_Index('ko_subject_map_j_idx4');
        Drop_Index('ko_subject_map_j_idx5');
        Drop_Table('ko_subject_map_j');
        --
        Drop_Table('ko_subject_semesters_j');
        --
        Drop_Table('ko_subject_trs_j');
        --
        Drop_Trigg('ko_subjects_tr1');
        Drop_Seqnc('ko_subjects_sq1');
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
        Drop_Trigg('ko_semesters_tr1');
        Drop_Seqnc('ko_semesters_sq1');
        Drop_Index('ko_semesters_idx1');
        Drop_Table('ko_semesters');
        --
        Drop_Trigg('ko_specialties_tr1');
        Drop_Seqnc('ko_specialties_sq1');
        Drop_Table('ko_specialties');

        --
        Drop_Index('uu_classes_grades_idx1');
        Drop_Index('uu_classes_grades_idx2');
        Drop_Index('uu_classes_grades_idx3');
        Drop_Index('uu_classes_grades_idx4');
        Drop_Index('uu_classes_grades_idx5');
        Drop_Index('uu_classes_grades_idx6');
        Drop_Index('uu_classes_grades_idx7');
        Drop_Index('uu_classes_grades_idx8');
        Drop_Index('uu_classes_grades_idx9');
        Drop_Table('uu_classes_grades');
        --
        Drop_Index('uu_zal_przedm_prgos_idx1');
        Drop_Index('uu_zal_przedm_prgos_idx2');
        Drop_Index('uu_zal_przedm_prgos_idx3');
        Drop_Table('uu_zal_przedm_prgos');
        --
        Drop_Index('uu_zalicz_przedmiotow_idx1');
        Drop_Table('uu_zaliczenia_przedmiotow');
        --
        Drop_Index('uu_etapy_osob_idx1');
        Drop_Index('uu_etapy_osob_idx2');
        Drop_Index('uu_etapy_osob_idx3');
        Drop_Table('uu_etapy_osob');
        --
        Drop_Index('uu_programy_osob_idx1');
        Drop_Index('uu_programy_osob_idx2');
        Drop_Index('uu_programy_osob_idx3');
        Drop_Index('uu_programy_osob_idx4');
        Drop_Table('uu_programy_osob');
        --
        Drop_Index('uu_studenci_idx1');
        Drop_Index('uu_studenci_idx2');
        Drop_Table('uu_studenci');
        --
        Drop_Index('uu_zajecia_cykli_idx1');
        Drop_Seqnc('uu_zajecia_cykli_sq1');
        Drop_Table('uu_zajecia_cykli');
        --
        Drop_Index('uu_punkty_przedmiotow_idx1');
        Drop_Index('uu_punkty_przedmiotow_idx2');
        Drop_Index('uu_punkty_przedmiotow_idx3');
        Drop_View('uu_punkty_przedmiotow1_v');
        Drop_View('uu_punkty_przedmiotow2_v');
        Drop_Table('uu_punkty_przedmiotow');
        --
        Drop_Index('uu_przedmioty_cykli_idx1');
        Drop_Index('uu_przedmioty_cykli_idx2');
        Drop_Table('uu_przedmioty_cykli');
        --
        Drop_Index('uu_atrybuty_przedm_idx1');
        Drop_Index('uu_atrybuty_przedm_idx2');
        Drop_Table('uu_atrybuty_przedmiotow');
        --
        Drop_Index('uu_przedmioty_idx1');
        Drop_Table('uu_przedmioty');
        --
        Drop_Index('uu_protokoly_idx1');
        Drop_Table('uu_protokoly');
        --
        Drop_Index('uu_terminy_protokolow_idx1');
        Drop_Table('uu_terminy_protokolow');
        --
        Drop_Index('uu_oceny_idx1');
        Drop_Table('uu_oceny');

        --
        Drop_Package('Fit');
        Drop_Package('Get');
        Drop_Package('To');
        Drop_Package('Util');

        Drop_Collect_Types();

        Drop_Type('Ko_Skipped_Program_J_t', 'Ko_Skipped_Programs_J_t');
        Drop_Type('Ko_Missing_Zpprgos_J_t', 'Ko_Missing_Zpprgoses_J_t');
        Drop_Type('Ko_Missing_Zalprz_J_t', 'Ko_Missing_Zalprzes_J_t');
        Drop_Type('Ko_Missing_Ocena_J_t', 'Ko_Missing_Oceny_J_t');
        Drop_Type('Ko_Missing_Prgos_J_t', 'Ko_Missing_Prgoses_J_t');
        Drop_Type('Ko_Missing_Etpos_J_t', 'Ko_Missing_Etposes_J_t');
        Drop_Type('Ko_Missing_Pktprz_J_t', 'Ko_Missing_Pktprzes_J_t');
        Drop_Type('Ko_Missing_Proto_J_t', 'Ko_Missing_Protos_J_t');
        Drop_Type('Ko_Missing_Zajcykl_J_t', 'Ko_Missing_Zajcykles_J_t');
        Drop_Type('Ko_Missing_Trmpro_J_t', 'Ko_Missing_Trmpros_J_t');
        Drop_Type('Ko_Missing_Proto_J_t', 'Ko_Missing_Protos_J_t');
        Drop_Type('Ko_Missing_Przcykl_J_t', 'Ko_Missing_Przcykles_J_t');
        Drop_Type('Ko_Missing_Przedm_J_t', 'Ko_Missing_Przedms_J_t');
        Drop_Type('Ko_Matched_Zpprgos_J_t', 'Ko_Matched_Zpprgoses_J_t');
        Drop_Type('Ko_Matched_Zalprz_J_t', 'Ko_Matched_Zalprzes_J_t');
        Drop_Type('Ko_Matched_Ocena_J_t', 'Ko_Matched_Oceny_J_t');
        Drop_Type('Ko_Matched_Prgos_J_t', 'Ko_Matched_Prgoses_J_t');
        Drop_Type('Ko_Matched_Etpos_J_t', 'Ko_Matched_Etposes_J_t');
        Drop_Type('Ko_Matched_Pktprz_J_t', 'Ko_Matched_Pktprzes_J_t');
        Drop_Type('Ko_Matched_Zajcykl_J_t', 'Ko_Matched_Zajcykles_J_t');
        Drop_Type('Ko_Matched_Trmpro_J_t', 'Ko_Matched_Trmpros_J_t');
        Drop_Type('Ko_Matched_Proto_J_t', 'Ko_Matched_Protos_J_t');
        Drop_Type('Ko_Matched_Przcykl_J_t', 'Ko_Matched_Przcykles_J_t');
        Drop_Type('Ko_Matched_Przedm_J_t', 'Ko_Matched_Przedms_J_t');

        Drop_Type('Ko_Protocol_Map_J_t', 'Ko_Protocol_Maps_J_t');
        Drop_Type('Ko_Classes_Map_J_t', 'Ko_Classes_Maps_J_t');
        Drop_Type('Ko_Subject_Map_J_t', 'Ko_Subject_Maps_J_t');
        Drop_Type('Ko_Specialty_Map_J_t', 'Ko_Specialty_Maps_J_t');
        Drop_Type('Ko_Grade_J_t', 'Ko_Grades_J_t');
        Drop_Type('Ko_Student_Semester_J_t', 'Ko_Student_Semesters_J_t');
        Drop_Type('Ko_Classes_Semester_J_t', 'Ko_Classes_Semesters_J_t');
        Drop_Type('Ko_Subject_Semester_J_t', 'Ko_Subject_Semesters_J_t');
        Drop_Type('Ko_Specialty_Semester_J_t', 'Ko_Specialty_Semesters_J_t');
        Drop_Type('Ko_Semester_J_t', 'Ko_Semesters_J_t');

        Drop_Type('Ko_Matched_Pktprz_I_t');
        Drop_Type('Ko_Matched_Przcykl_I_t');
        Drop_Type('Ko_Matched_Przedm_I_t');
        Drop_Type('Ko_Missing_Przedm_I_t');
        Drop_Type('Ko_Grade_I_t');
        Drop_Type('Ko_Credit_I_t');
        Drop_Type('Ko_Classes_Semester_I_t');
        Drop_Type('Ko_Student_Semester_I_t');
        Drop_Type('Ko_Subject_Semester_I_t');
        Drop_Type('Ko_Specialty_Semester_I_t');
        Drop_Type('Ko_Semester_I_t');

        Drop_Type('Ko_Specialty_t');
        Drop_Type('Ko_Subject_t');
        Drop_Type('Ko_Semester_t', 'Ko_Semesters_t', 'Ko_Semester_Tables_t');
        Drop_Type('Ko_Student_t');
        Drop_Type('Ko_Distinct_t');

        Drop_Type('Uu_Classes_Grade_t', 'Uu_Classes_Grades_t');
        Drop_Type('Uu_Etap_Osoby_t', 'Uu_Etapy_Osob_t');
        Drop_Type('Uu_Program_Osoby_t', 'Uu_Programy_Osob_t');
        Drop_Type('Uu_Student_t', 'Uu_Studenci_t');
        Drop_Type('Uu_Atrybut_Przedmiotu_t', 'Uu_Atrybuty_Przedmiotow_t');
        Drop_Type('Uu_Zalicz_Przedmiotu_t', 'Uu_Zalicz_Przedmiotow_t');
        Drop_Type('Uu_Zal_Przedm_Prgos_t', 'Uu_Zal_Przedm_Prgoses_t');
        Drop_Type('Uu_Przedmiot_t', 'Uu_Przedmioty_t');
        Drop_Type('Uu_Przedmiot_Cyklu_t', 'Uu_Przedmioty_Cykli_t');
        Drop_Type('Uu_Punkty_Przedmiotu_t', 'Uu_Punkty_Przedmiotow_t');
        Drop_Type('Uu_Zajecia_Cyklu_t', 'Uu_Zajecia_Cykli_t');
        Drop_Type('Uu_Protokol_t', 'Uu_Protokoly_t');
        Drop_Type('Uu_Termin_Protokolu_t', 'Uu_Terminy_Protokolow_t');
        Drop_Type('Uu_Ocena_t', 'Uu_Oceny_t');

        Drop_Type('Dates_t');
        Drop_Type('5Dates_t');
        Drop_Type('20Dates_t');
        Drop_Type('Semester_Codes_t');
        Drop_Type('Semester_5Codes_t');
        Drop_Type('Semester_20Codes_t');
        Drop_Type('Prot_Codes_t');
        Drop_Type('Prot_5Codes_t');
        Drop_Type('Prot_20Codes_t');
        Drop_Type('Program_Codes_t');
        Drop_Type('Program_5Codes_t');
        Drop_Type('Program_20Codes_t');
        Drop_Type('Subj_Grades_t');
        Drop_Type('Subj_5Grades_t');
        Drop_Type('Subj_20Grades_t');
        Drop_Type('Subj_Codes_t');
        Drop_Type('Subj_5Codes_t');
        Drop_Type('Subj_20Codes_t');
        Drop_Type('Ids_t');
        Drop_Type('5Ids_t');
        Drop_Type('20Ids_t');
        Drop_Type('Dz_Ids_t');
        Drop_Type('Dz_5Ids_t');
        Drop_Type('Dz_20Ids_t');
        Drop_Type('Ints8_t');
        Drop_Type('5Ints_t');
        Drop_Type('20Ints_t');
        Drop_Type('Integers_t');
        Drop_Type('Chars1_t');
        Drop_Type('5Chars1_t');
        Drop_Type('Chars3_t');
        Drop_Type('5Chars3_t');
        Drop_Type('Vchars1K_t');
        Drop_Type('Vchars2K_t');
        Drop_Type('5Vchars1K_t');
        Drop_Type('Ints2_t');
        Drop_Type('Ints4_t');
        Drop_Type('Ints10_t');
    END;

    PROCEDURE Tier3
    IS
    BEGIN
        Drop_View('ud_studenci_v');
        Drop_View('ud_programy_osob_v');
        Drop_View('ud_etapy_osob_v');
        Drop_View('ud_atrybuty_przedmiotow_v');
        Drop_View('ud_przedmioty_v');
        Drop_View('ud_przedmioty_cykli_v');
        Drop_View('ud_zajecia_cykli_v');
        Drop_View('ud_protokoly_v');
        Drop_View('ud_punkty_przedmiotow_v');
        Drop_View('ud_terminy_protokolow_v');
        Drop_View('ud_oceny_v');
        Drop_View('ud_zalicz_przedmiotow_v');
        Drop_View('ud_zal_przedm_prgos_v');

        Drop_View('uu_subject_grades_v');

        Drop_View('ko_skipped_programs_v');
        Drop_View('ko_missing_oceny_v');
        Drop_View('ko_missing_trmpro_v');
        Drop_View('ko_missing_protos_v');
        Drop_View('ko_missing_pktprz_v');
        Drop_View('ko_missing_zajcykl_v');
        Drop_View('ko_missing_przcykl_v');
        Drop_View('ko_missing_przedm_v');
        Drop_View('ko_missing_etpos_v');
        Drop_View('ko_missing_prgos_v');
        Drop_View('ko_matched_oceny_v');
        Drop_View('ko_matched_prgos_v');
        Drop_View('ko_matched_etpos_v');
        Drop_View('ko_matched_trmpro_v');
        Drop_View('ko_matched_protos_v');
        Drop_View('ko_matched_pktprz_v');
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
        Drop_View('ko_specialty_semesters_v');
        Drop_View('ko_classes_semesters_v');
        Drop_View('ko_subject_semesters_v');
        Drop_View('ko_student_semesters_v');
        Drop_View('ko_grades_v');

--        Drop_Collect_Types();
--

        Drop_Type('Uu_Subject_Grade_V_t');
        Drop_Type('Ko_Skipped_Program_V_t', 'Ko_Skipped_Programs_V_t');
        Drop_Type('Ko_Matched_Etpos_V_t', 'Ko_Matched_Etposes_V_t');
        Drop_Type('Ko_Matched_Prgos_V_t', 'Ko_Matched_Prgoses_V_t');
        Drop_Type('Ko_Matched_Przedm_V_t', 'Ko_Matched_Przedms_V_t');
        Drop_Type('Ko_Matched_Przcykl_V_t', 'Ko_Matched_Przcykles_V_t');
        Drop_Type('Ko_Matched_Zajcykl_V_t', 'Ko_Matched_Zajcykles_V_t');
        Drop_Type('Ko_Matched_Trmpro_V_t', 'Ko_Matched_Trmpros_V_t');
        Drop_Type('Ko_Matched_Proto_V_t', 'Ko_Matched_Protos_V_t');
        Drop_Type('Ko_Matched_Pktprz_V_t', 'Ko_Matched_Pktprzes_V_t');
        Drop_Type('Ko_Matched_Ocena_V_t', 'Ko_Matched_Oceny_V_t');
        Drop_Type('Ko_Missing_Pktprz_V_t', 'Ko_Missing_Pktprzes_V_t');
        Drop_Type('Ko_Missing_Zajcykl_V_t', 'Ko_Missing_Zajcykles_V_t');
        Drop_Type('Ko_Missing_Trmpro_V_t', 'Ko_Missing_Trmpros_V_t');
        Drop_Type('Ko_Missing_Proto_V_t', 'Ko_Missing_Protos_V_t');
        Drop_Type('Ko_Missing_Przcykl_V_t', 'Ko_Missing_Przcykles_V_t');
        Drop_Type('Ko_Missing_Przedm_V_t', 'Ko_Missing_Przedms_V_t');
        Drop_Type('Ko_Missing_Etpos_V_t', 'Ko_Missing_Etposes_V_t');
        Drop_Type('Ko_Missing_Prgos_V_t', 'Ko_Missing_Prgoses_V_t');
        Drop_Type('Ko_Missing_Ocena_V_t', 'Ko_Missing_Oceny_V_t');
        Drop_Type('Ko_Missing_Subject_Map_V_t');
        Drop_Type('Ko_Missing_Speclty_Map_V_t');
--        Drop_Type('Ko_Missing_Subj_Map_V_t', 'Ko_Missing_Subj_Maps_V_t');
        Drop_Type('Ko_Ambig_Speclty_Map_V_t', 'Ko_Ambig_Speclty_Maps_V_t');
        Drop_Type('Ko_Ambig_Subject_Map_V_t', 'Ko_Ambig_Subject_Maps_V_t');
        Drop_Type('Ko_Specialty_Map_V_t', 'Ko_Specialty_Maps_V_t');
        Drop_Type('Ko_Classes_Map_V_t', 'Ko_Classes_Maps_V_t');
        Drop_Type('Ko_Subject_Map_V_t', 'Ko_Subject_Maps_V_t');
        Drop_Type('Ko_Specialty_Semester_V_t', 'Ko_Specialty_Semesters_V_t');
        Drop_Type('Ko_Classes_Semester_V_t', 'Ko_Classes_Semesters_V_t');
        Drop_Type('Ko_Subject_Semester_V_t', 'Ko_Subject_Semesters_V_t');
        Drop_Type('Ko_Student_Semester_V_t', 'Ko_Student_Semesters_V_t');
        Drop_Type('Ko_Grade_V_t', 'Ko_Grades_V_t');

        Drop_Type('Ko_Grade_U_t');
        Drop_Type('Ko_Credit_U_t');
        Drop_Type('Ko_Subject_Semester_U_t');
    END;

END V2U_Drop;
/
-- vim: set ft=sql ts=4 sw=4 et:
