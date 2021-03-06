CREATE OR REPLACE TYPE BODY V2u_Uu_Zajecia_Cyklu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Zajecia_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Uu_Zajecia_Cyklu_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_zajecia_cyklu IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_tzaj_kody IN NUMBER
            , dbg_classes_hours IN NUMBER
            , dbg_map_classes_hours IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tzaj_kod => tzaj_kod
            , liczba_godz => liczba_godz
            , limit_miejsc => limit_miejsc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , waga_pensum => waga_pensum
            , tpro_kod => tpro_kod
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , url => url
            , zakres_tematow => zakres_tematow
            , zakres_tematow_ang => zakres_tematow_ang
            , metody_dyd => metody_dyd
            , metody_dyd_ang => metody_dyd_ang
            , literatura => literatura
            , literatura_ang => literatura_ang
            , czy_pokazywac_termin => czy_pokazywac_termin
            -- KEY
            , job_uuid => job_uuid
            , pk_zajecia_cyklu => pk_zajecia_cyklu
            -- DBG
            , dbg_subj_codes => dbg_subj_codes
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_map_classes_types => dbg_map_classes_types
            , dbg_map_proto_types => dbg_map_proto_types
            , dbg_subj_credit_kinds => dbg_subj_credit_kinds
            , dbg_semester_codes => dbg_semester_codes
            , dbg_prz_kody => dbg_prz_kody
            , dbg_cdyd_kody => dbg_cdyd_kody
            , dbg_tzaj_kody => dbg_tzaj_kody
            , dbg_classes_hours => dbg_classes_hours
            , dbg_map_classes_hours => dbg_map_classes_hours
            , dbg_ids => dbg_ids
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_subject_mapped => dbg_subject_mapped
            , dbg_classes_mapped => dbg_classes_mapped
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Zajecia_Cyklu_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_zajecia_cyklu IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_tzaj_kody IN NUMBER
            , dbg_classes_hours IN NUMBER
            , dbg_map_classes_hours IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tzaj_kod => tzaj_kod
            , liczba_godz => liczba_godz
            , limit_miejsc => limit_miejsc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , waga_pensum => waga_pensum
            , tpro_kod => tpro_kod
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , url => url
            , zakres_tematow => zakres_tematow
            , zakres_tematow_ang => zakres_tematow_ang
            , metody_dyd => metody_dyd
            , metody_dyd_ang => metody_dyd_ang
            , literatura => literatura
            , literatura_ang => literatura_ang
            , czy_pokazywac_termin => czy_pokazywac_termin
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_zajecia_cyklu := pk_zajecia_cyklu;
        -- DBG
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_map_classes_types := dbg_map_classes_types;
        SELF.dbg_map_proto_types := dbg_map_proto_types;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_prz_kody := dbg_prz_kody;
        SELF.dbg_cdyd_kody := dbg_cdyd_kody;
        SELF.dbg_tzaj_kody := dbg_tzaj_kody;
        SELF.dbg_classes_hours := dbg_classes_hours;
        SELF.dbg_map_classes_hours := dbg_map_classes_hours;
        SELF.dbg_ids := dbg_ids;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_subject_mapped := dbg_subject_mapped;
        SELF.dbg_classes_mapped := dbg_classes_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
