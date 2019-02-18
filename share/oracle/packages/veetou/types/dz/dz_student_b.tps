CREATE OR REPLACE TYPE V2u_Dz_Student_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , indeks VARCHAR2(30 CHAR)
    , jed_org_kod VARCHAR2(20 CHAR)
    , typ_ind_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , os_id NUMBER(10)
    , indeks_glowny VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Student_B_t(
          SELF IN OUT NOCOPY V2u_Dz_Student_B_t
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
        ) RETURN SELF AS RESULT


    , MEMBER PROCEDURE init(
          SELF IN OUT NOCOPY V2u_Dz_Student_B_t
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
        )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
