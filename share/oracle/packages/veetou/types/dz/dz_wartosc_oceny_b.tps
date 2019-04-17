CREATE OR REPLACE TYPE V2u_Dz_Wartosc_Oceny_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( kolejnosc NUMBER(10)
    , toc_kod VARCHAR2(20 CHAR)
    , opis VARCHAR2(100 CHAR)
    , czy_zal VARCHAR2(1 CHAR)
    , wartosc NUMBER(4,2)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , description VARCHAR2(100 CHAR)
    , opis_oceny VARCHAR2(100 CHAR)
    , czy_dwoja_reg VARCHAR2(1 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Wartosc_Oceny_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Wartosc_Oceny_B_t
            , kolejnosc IN NUMBER
            , toc_kod IN VARCHAR2
            , opis IN VARCHAR2
            , czy_zal IN VARCHAR2
            , wartosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            , opis_oceny IN VARCHAR2
            , czy_dwoja_reg IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Wartosc_Oceny_B_t
            , kolejnosc IN NUMBER
            , toc_kod IN VARCHAR2
            , opis IN VARCHAR2
            , czy_zal IN VARCHAR2
            , wartosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            , opis_oceny IN VARCHAR2
            , czy_dwoja_reg IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
