CREATE OR REPLACE TYPE V2u_Dz_Atrybut_Przedmiotu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( tatr_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)
    , wart_lst_id NUMBER(10)
    , prz_kod_rel VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , wartosc CLOB
    , wartosc_ang CLOB
    , id VARCHAR2(32 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Atrybut_Przedmiotu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Atrybut_Przedmiotu_B_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Atrybut_Przedmiotu_B_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
