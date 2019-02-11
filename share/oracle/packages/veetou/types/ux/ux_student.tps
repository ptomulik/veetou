CREATE OR REPLACE TYPE V2u_Ux_Student_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Student_B_t
    ( job_uuid RAW(16)
    , is_missing INTEGER
    , safe_to_add INTEGER

    , CONSTRUCTOR FUNCTION V2u_Ux_Student_t(
              SELF IN OUT NOCOPY V2u_Ux_Student_t
            , id NUMBER
            , indeks VARCHAR2
            , jed_org_kod VARCHAR2
            , typ_ind_kod VARCHAR2
            , utw_id VARCHAR2
            , utw_data DATE
            , mod_id VARCHAR2
            , mod_data DATE
            , os_id NUMBER
            , indeks_glowny VARCHAR2
            , job_uuid IN RAW
            , is_missing INTEGER
            , safe_to_add INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Student_t
            , id NUMBER
            , indeks VARCHAR2
            , jed_org_kod VARCHAR2
            , typ_ind_kod VARCHAR2
            , utw_id VARCHAR2
            , utw_data DATE
            , mod_id VARCHAR2
            , mod_data DATE
            , os_id NUMBER
            , indeks_glowny VARCHAR2
            , job_uuid IN RAW
            , is_missing INTEGER
            , safe_to_add INTEGER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
