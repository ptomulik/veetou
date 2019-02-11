CREATE OR REPLACE TYPE V2u_Dz_Zalicz_Przedmiotu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( status_rej  VARCHAR2(1 CHAR)
    , opis_statusu_rej VARCHAR2(200 CHAR)
    , status_zal VARCHAR2(1 CHAR)
    , opis_statusu_zal VARCHAR2(200 CHAR)
    , suma_ocen NUMBER(12,2)
    , liczba_ocen NUMBER(10)
    , os_id NUMBER(10)
    , cdyd_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)
    , utw_data DATE
    , utw_id VARCHAR2(30 CHAR)
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , nr_wyb NUMBER(3)


    , CONSTRUCTOR FUNCTION V2u_Dz_Zalicz_Przedmiotu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Zalicz_Przedmiotu_B_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Zalicz_Przedmiotu_B_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
