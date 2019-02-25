CREATE OR REPLACE TYPE V2u_Ux_Przedmiot_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    , dbg_subj_codes INTEGER
    , dbg_map_subj_codes INTEGER
    , dbg_languages INTEGER
    , dbg_org_units INTEGER
    , dbg_org_unit_recipients INTEGER
    , dbg_faculty_codes INTEGER
    , dbg_subj_names INTEGER
    , dbg_subj_credit_kinds INTEGER
    , dbg_prz_kody INTEGER
    , dbg_unique_match INTEGER
    , dbg_missing INTEGER
    , dbg_matched INTEGER
    , dbg_mapped INTEGER
    , safe_to_add INTEGER

    , CONSTRUCTOR FUNCTION V2u_Ux_Przedmiot_t(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_t
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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , dbg_subj_codes IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_languages IN INTEGER
            , dbg_org_units IN INTEGER
            , dbg_org_unit_recipients IN INTEGER
            , dbg_faculty_codes IN INTEGER
            , dbg_subj_names IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_prz_kody IN INTEGER
            , dbg_unique_match IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add IN INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_t
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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , dbg_subj_codes IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_languages IN INTEGER
            , dbg_org_units IN INTEGER
            , dbg_org_unit_recipients IN INTEGER
            , dbg_faculty_codes IN INTEGER
            , dbg_subj_names IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_prz_kody IN INTEGER
            , dbg_unique_match IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add IN INTEGER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
