CREATE OR REPLACE TYPE BODY V2u_Uu_Przedmiot_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Przedmiot_t(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_t
            , kod IN VARCHAR2
            , nazwa IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , czy_wielokrotne IN NUMBER
            , name IN VARCHAR2
            , skrocony_opis IN VARCHAR2
            , short_description IN VARCHAR2
            , jed_org_kod_biorca IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , kod_sok IN VARCHAR2
            , opis IN CLOB
            , description IN CLOB
            , literatura IN CLOB
            , bibliography IN CLOB
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , praktyki_zawodowe IN VARCHAR2
            , praktyki_zawodowe_ang IN VARCHAR2
            , url IN VARCHAR2
            , kod_isced IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , guid IN VARCHAR2
            , pw_nazwa_supl IN VARCHAR2
            , pw_nazwa_supl_ang IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_subj_names IN NUMBER
            , dbg_languages IN NUMBER
            , dbg_org_units IN NUMBER
            , dbg_org_unit_recipients IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_map_grade_types IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_subj_names IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              kod => kod
            , nazwa => nazwa
            , jed_org_kod => jed_org_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , czy_wielokrotne => czy_wielokrotne
            , name => name
            , skrocony_opis => skrocony_opis
            , short_description => short_description
            , jed_org_kod_biorca => jed_org_kod_biorca
            , jzk_kod => jzk_kod
            , kod_sok => kod_sok
            , opis => opis
            , description => description
            , literatura => literatura
            , bibliography => bibliography
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , praktyki_zawodowe => praktyki_zawodowe
            , praktyki_zawodowe_ang => praktyki_zawodowe_ang
            , url => url
            , kod_isced => kod_isced
            , nazwa_pol => nazwa_pol
            , guid => guid
            , pw_nazwa_supl => pw_nazwa_supl
            , pw_nazwa_supl_ang => pw_nazwa_supl_ang
            -- KEY
            , job_uuid => job_uuid
            , pk_subject => pk_subject
            -- DBG
            , dbg_subj_codes => dbg_subj_codes
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_map_subj_names => dbg_map_subj_names
            , dbg_languages => dbg_languages
            , dbg_org_units => dbg_org_units
            , dbg_org_unit_recipients => dbg_org_unit_recipients
            , dbg_map_proto_types => dbg_map_proto_types
            , dbg_map_grade_types => dbg_map_grade_types
            , dbg_faculty_codes => dbg_faculty_codes
            , dbg_subj_names => dbg_subj_names
            , dbg_subj_credit_kinds => dbg_subj_credit_kinds
            , dbg_prz_kody => dbg_prz_kody
            , dbg_values_ok => dbg_values_ok
            , dbg_unique_match => dbg_unique_match
            , dbg_missing => dbg_missing
            , dbg_matched => dbg_matched
            , dbg_mapped => dbg_mapped
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_t
            , kod IN VARCHAR2
            , nazwa IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , czy_wielokrotne IN NUMBER
            , name IN VARCHAR2
            , skrocony_opis IN VARCHAR2
            , short_description IN VARCHAR2
            , jed_org_kod_biorca IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , kod_sok IN VARCHAR2
            , opis IN CLOB
            , description IN CLOB
            , literatura IN CLOB
            , bibliography IN CLOB
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , praktyki_zawodowe IN VARCHAR2
            , praktyki_zawodowe_ang IN VARCHAR2
            , url IN VARCHAR2
            , kod_isced IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , guid IN VARCHAR2
            , pw_nazwa_supl IN VARCHAR2
            , pw_nazwa_supl_ang IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_subj_names IN NUMBER
            , dbg_languages IN NUMBER
            , dbg_org_units IN NUMBER
            , dbg_org_unit_recipients IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_map_grade_types IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_subj_names IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              kod => kod
            , nazwa => nazwa
            , jed_org_kod => jed_org_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , czy_wielokrotne => czy_wielokrotne
            , name => name
            , skrocony_opis => skrocony_opis
            , short_description => short_description
            , jed_org_kod_biorca => jed_org_kod_biorca
            , jzk_kod => jzk_kod
            , kod_sok => kod_sok
            , opis => opis
            , description => description
            , literatura => literatura
            , bibliography => bibliography
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , praktyki_zawodowe => praktyki_zawodowe
            , praktyki_zawodowe_ang => praktyki_zawodowe_ang
            , url => url
            , kod_isced => kod_isced
            , nazwa_pol => nazwa_pol
            , guid => guid
            , pw_nazwa_supl => pw_nazwa_supl
            , pw_nazwa_supl_ang => pw_nazwa_supl_ang
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_subject := pk_subject;
        -- DBG
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_map_subj_names := dbg_map_subj_names;
        SELF.dbg_languages := dbg_languages;
        SELF.dbg_org_units := dbg_org_units;
        SELF.dbg_org_unit_recipients := dbg_org_unit_recipients;
        SELF.dbg_map_proto_types := dbg_map_proto_types;
        SELF.dbg_map_grade_types := dbg_map_grade_types;
        SELF.dbg_faculty_codes := dbg_faculty_codes;
        SELF.dbg_subj_names := dbg_subj_names;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_prz_kody := dbg_prz_kody;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_mapped := dbg_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
