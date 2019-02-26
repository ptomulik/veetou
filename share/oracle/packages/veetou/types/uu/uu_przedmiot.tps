CREATE OR REPLACE TYPE V2u_Uu_Przedmiot_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    -- DBG
    , dbg_subj_codes NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_languages NUMBER(5)
    , dbg_org_units NUMBER(5)
    , dbg_org_unit_recipients NUMBER(5)
    , dbg_faculty_codes NUMBER(5)
    , dbg_subj_names NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_values_ok NUMBER(1)
    , dbg_unique_match NUMBER(1)
    , dbg_missing NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_mapped NUMBER(5)
    -- INF
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Przedmiot_t(
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
            , dbg_languages IN NUMBER
            , dbg_org_units IN NUMBER
            , dbg_org_unit_recipients IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_subj_names IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_mapped IN NUMBER
            -- INF
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
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
            , dbg_languages IN NUMBER
            , dbg_org_units IN NUMBER
            , dbg_org_unit_recipients IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_subj_names IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_mapped IN NUMBER
            -- INF
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
