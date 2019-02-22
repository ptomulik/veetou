CREATE OR REPLACE TYPE V2u_Dz_Punkty_Przedmiotu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( prz_kod VARCHAR2(20 CHAR)
    , prg_kod VARCHAR2(20 CHAR)
    , tpkt_kod VARCHAR2(20 CHAR)
    , ilosc NUMBER(13,2)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , id NUMBER(10)
    , cdyd_pocz VARCHAR2(20 CHAR)
    , cdyd_kon VARCHAR2(20 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Punkty_Przedmiotu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Punkty_Przedmiotu_B_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Punkty_Przedmiotu_B_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
