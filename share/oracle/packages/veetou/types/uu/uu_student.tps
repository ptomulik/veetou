CREATE OR REPLACE TYPE V2u_Uu_Student_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Student_B_t
    ( job_uuid RAW(16)
    , is_missing INTEGER
    , safe_to_add NUMBER(1)

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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
