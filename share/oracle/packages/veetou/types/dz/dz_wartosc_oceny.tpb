CREATE OR REPLACE TYPE BODY V2u_Dz_Wartosc_Oceny_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Wartosc_Oceny_t(
              SELF IN OUT NOCOPY V2u_Dz_Wartosc_Oceny_t
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
    IS
    BEGIN
        SELF.init(
              kolejnosc => kolejnosc
            , toc_kod => toc_kod
            , opis => opis
            , czy_zal => czy_zal
            , wartosc => wartosc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , description => description
            , opis_oceny => opis_oceny
            , czy_dwoja_reg => czy_dwoja_reg
            );
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
