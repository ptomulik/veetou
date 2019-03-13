CREATE OR REPLACE TYPE V2u_Dz_Protokol_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( zaj_cyk_id NUMBER(10)
    , opis VARCHAR2(100 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tpro_kod VARCHAR2(20 CHAR)
    , id NUMBER(10)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_do_sredniej VARCHAR2(1 CHAR)
    , edycja VARCHAR2(1 CHAR)
    , opis_ang VARCHAR2(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Protokol_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Protokol_B_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Protokol_B_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
