CREATE OR REPLACE TYPE BODY V2u_Dz_Zajecia_Prz_Obcego_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Prz_Obcego_B_t(
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


    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.przob_id := przob_id;
        SELF.dec_id := dec_id;
        SELF.tzaj_kod := tzaj_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.ocena := ocena;
        SELF.liczba_godzin := liczba_godzin;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
