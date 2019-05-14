CREATE OR REPLACE TYPE BODY V2u_Uu_Etap_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
            , id IN NUMBER
            , data_zakon IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status_zaliczenia IN VARCHAR2
            , etp_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , status_zal_komentarz IN VARCHAR2
            , liczba_war IN NUMBER
            , wym_cdyd_kod IN VARCHAR2
            , czy_platny_na_2_kier IN VARCHAR2
            , ects_uzyskane IN NUMBER
            , czy_przedluzenie IN VARCHAR2
            , urlop_kod IN VARCHAR2
            , ects_efekty_uczenia IN NUMBER
            , ects_przepisane IN NUMBER
            , kolejnosc IN NUMBER
            , czy_erasmus IN VARCHAR2
            , jedn_dyplomujaca IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            , pk_etap_osoby IN VARCHAR2
            -- DBG
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_eo_prgos_ids IN NUMBER
            , dbg_po_prgos_ids IN NUMBER
            , dbg_eo_etp_kody IN NUMBER
            , dbg_ek_etp_kody IN NUMBER
            , dbg_eo_prg_kody IN NUMBER
            , dbg_po_prg_kody IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ects_attained IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , data_zakon => data_zakon
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , status_zaliczenia => status_zaliczenia
            , etp_kod => etp_kod
            , prg_kod => prg_kod
            , prgos_id => prgos_id
            , cdyd_kod => cdyd_kod
            , status_zal_komentarz => status_zal_komentarz
            , liczba_war => liczba_war
            , wym_cdyd_kod => wym_cdyd_kod
            , czy_platny_na_2_kier => czy_platny_na_2_kier
            , ects_uzyskane => ects_uzyskane
            , czy_przedluzenie => czy_przedluzenie
            , urlop_kod => urlop_kod
            , ects_efekty_uczenia => ects_efekty_uczenia
            , ects_przepisane => ects_przepisane
            , kolejnosc => kolejnosc
            , czy_erasmus => czy_erasmus
            , jedn_dyplomujaca => jedn_dyplomujaca
            -- KEY
            , job_uuid => job_uuid
            , pk_student => pk_student
            , pk_etap_osoby => pk_etap_osoby
            -- DBG
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            , dbg_map_program_codes => dbg_map_program_codes
            , dbg_ids => dbg_ids
            , dbg_eo_prgos_ids => dbg_eo_prgos_ids
            , dbg_po_prgos_ids => dbg_po_prgos_ids
            , dbg_eo_etp_kody => dbg_eo_etp_kody
            , dbg_ek_etp_kody => dbg_ek_etp_kody
            , dbg_eo_prg_kody => dbg_eo_prg_kody
            , dbg_po_prg_kody => dbg_po_prg_kody
            , dbg_semester_codes => dbg_semester_codes
            , dbg_ects_attained => dbg_ects_attained
            , dbg_skipped_prg_kody => dbg_skipped_prg_kody
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_mapped => dbg_mapped
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
            RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
            , id IN NUMBER
            , data_zakon IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status_zaliczenia IN VARCHAR2
            , etp_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , status_zal_komentarz IN VARCHAR2
            , liczba_war IN NUMBER
            , wym_cdyd_kod IN VARCHAR2
            , czy_platny_na_2_kier IN VARCHAR2
            , ects_uzyskane IN NUMBER
            , czy_przedluzenie IN VARCHAR2
            , urlop_kod IN VARCHAR2
            , ects_efekty_uczenia IN NUMBER
            , ects_przepisane IN NUMBER
            , kolejnosc IN NUMBER
            , czy_erasmus IN VARCHAR2
            , jedn_dyplomujaca IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            , pk_etap_osoby IN VARCHAR2
            -- DBG
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_eo_prgos_ids IN NUMBER
            , dbg_po_prgos_ids IN NUMBER
            , dbg_eo_etp_kody IN NUMBER
            , dbg_ek_etp_kody IN NUMBER
            , dbg_eo_prg_kody IN NUMBER
            , dbg_po_prg_kody IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ects_attained IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              id => id
            , data_zakon => data_zakon
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , status_zaliczenia => status_zaliczenia
            , etp_kod => etp_kod
            , prg_kod => prg_kod
            , prgos_id => prgos_id
            , cdyd_kod => cdyd_kod
            , status_zal_komentarz => status_zal_komentarz
            , liczba_war => liczba_war
            , wym_cdyd_kod => wym_cdyd_kod
            , czy_platny_na_2_kier => czy_platny_na_2_kier
            , ects_uzyskane => ects_uzyskane
            , czy_przedluzenie => czy_przedluzenie
            , urlop_kod => urlop_kod
            , ects_efekty_uczenia => ects_efekty_uczenia
            , ects_przepisane => ects_przepisane
            , kolejnosc => kolejnosc
            , czy_erasmus => czy_erasmus
            , jedn_dyplomujaca => jedn_dyplomujaca
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_student := pk_student;
        SELF.pk_etap_osoby := pk_etap_osoby;
        -- DBG
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_map_program_codes := dbg_map_program_codes;
        SELF.dbg_ids := dbg_ids;
        SELF.dbg_eo_prgos_ids := dbg_eo_prgos_ids;
        SELF.dbg_po_prgos_ids := dbg_po_prgos_ids;
        SELF.dbg_eo_etp_kody := dbg_eo_etp_kody;
        SELF.dbg_ek_etp_kody := dbg_ek_etp_kody;
        SELF.dbg_eo_prg_kody := dbg_eo_prg_kody;
        SELF.dbg_po_prg_kody := dbg_po_prg_kody;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_ects_attained := dbg_ects_attained;
        SELF.dbg_skipped_prg_kody := dbg_skipped_prg_kody;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_mapped := dbg_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
