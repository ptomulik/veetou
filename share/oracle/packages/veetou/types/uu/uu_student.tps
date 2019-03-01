CREATE OR REPLACE TYPE V2u_Uu_Student_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Student_B_t
    ( job_uuid RAW(16)
    , pk_student VARCHAR2(32 CHAR)
    -- DBG
    , dbg_first_name VARCHAR2(48 CHAR)
    , dbg_last_name VARCHAR2(48 CHAR)
    , dbg_first_names NUMBER(5)
    , dbg_last_names NUMBER(5)
    , dbg_ids NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    -- CTL
    , change_type VARCHAR2(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Student_t(
              SELF IN OUT NOCOPY V2u_Uu_Student_t
            , id IN NUMBER
            , indeks IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , typ_ind_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , os_id IN NUMBER
            , indeks_glowny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            -- DBG
            , dbg_first_name IN VARCHAR2
            , dbg_last_name IN VARCHAR2
            , dbg_first_names IN NUMBER
            , dbg_last_names IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Student_t
            , id IN NUMBER
            , indeks IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , typ_ind_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , os_id IN NUMBER
            , indeks_glowny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            -- DBG
            , dbg_first_name IN VARCHAR2
            , dbg_last_name IN VARCHAR2
            , dbg_first_names IN NUMBER
            , dbg_last_names IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
