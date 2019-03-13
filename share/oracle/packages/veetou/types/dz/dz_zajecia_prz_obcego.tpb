CREATE OR REPLACE TYPE BODY V2u_Dz_Zajecia_Prz_Obcego_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Prz_Obcego_t(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Prz_Obcego_t
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
    IS
    BEGIN
        SELF.init(
              przob_id => przob_id
            , dec_id => dec_id
            , tzaj_kod => tzaj_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , ocena => ocena
            , liczba_godzin => liczba_godzin
            , mod_id => mod_id
            , mod_data => mod_data
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
