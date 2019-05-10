CREATE OR REPLACE TYPE V2u_Dz_Osoba_Grupy_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( gr_nr NUMBER(10)
    , os_id NUMBER(10)
    , zaj_cyk_id NUMBER(10)
    , utw_data DATE
    , utw_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , rej_data DATE
    , rej_os_id NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Dz_Osoba_Grupy_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_Grupy_B_t
            , gr_nr IN NUMBER
            , os_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , rej_data IN DATE
            , rej_os_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_Grupy_B_t
            , gr_nr IN NUMBER
            , os_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , rej_data IN DATE
            , rej_os_id IN NUMBER
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
