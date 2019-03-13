CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Prz_Obcego_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( przob_id NUMBER(10)
    , dec_id NUMBER(10)
    , tzaj_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , ocena VARCHAR2(10 CHAR)
    , liczba_godzin NUMBER(12,2)
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE

    , CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Prz_Obcego_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Prz_Obcego_B_t
            , przob_id IN NUMBER
            , dec_id IN NUMBER
            , tzaj_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , ocena IN VARCHAR2
            , liczba_godzin IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Prz_Obcego_B_t
            , przob_id IN NUMBER
            , dec_id IN NUMBER
            , tzaj_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , ocena IN VARCHAR2
            , liczba_godzin IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
