CREATE OR REPLACE TYPE V2u_Dz_Grupa_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( nr NUMBER(10)
    , zaj_cyk_id NUMBER(10)
    , limit_miejsc NUMBER(10)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , gr_nr NUMBER(10)
    , gr_zaj_cyk_id NUMBER(10)
    , opis VARCHAR2(1000 CHAR)
    , waga_pensum NUMBER(3,2)
    , zakres_tematow CLOB
    , zakres_tematow_ang CLOB
    , metody_dyd CLOB
    , metody_dyd_ang CLOB
    , literatura CLOB
    , literatura_ang CLOB
    , url VARCHAR2(500 CHAR)
    , opis_ang VARCHAR2(1000 CHAR)
    , dolny_limit_miejsc NUMBER(10)
    , kryteria_oceniania CLOB
    , kryteria_oceniania_ang CLOB

    , CONSTRUCTOR FUNCTION V2u_Dz_Grupa_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Grupa_B_t
            , nr IN NUMBER
            , zaj_cyk_id IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , gr_nr IN NUMBER
            , gr_zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , waga_pensum IN NUMBER
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , url IN VARCHAR2
            , opis_ang IN VARCHAR2
            , dolny_limit_miejsc IN NUMBER
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Grupa_B_t
            , nr IN NUMBER
            , zaj_cyk_id IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , gr_nr IN NUMBER
            , gr_zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , waga_pensum IN NUMBER
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , url IN VARCHAR2
            , opis_ang IN VARCHAR2
            , dolny_limit_miejsc IN NUMBER
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
