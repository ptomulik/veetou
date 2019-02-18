CREATE OR REPLACE TYPE BODY V2u_Dz_Zalicz_Przedmiotu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zalicz_Przedmiotu_B_t(
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
    IS
    BEGIN
        SELF.init(
              status_rej => status_rej
            , opis_statusu_rej => opis_statusu_rej
            , status_zal => status_zal
            , opis_statusu_zal => opis_statusu_zal
            , suma_ocen => suma_ocen
            , liczba_ocen => liczba_ocen
            , os_id => os_id
            , cdyd_kod => cdyd_kod
            , prz_kod => prz_kod
            , utw_data => utw_data
            , utw_id => utw_id
            , mod_id => mod_id
            , mod_data => mod_data
            , nr_wyb => nr_wyb
            );
    END;


    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.status_rej := status_rej;
        SELF.opis_statusu_rej := opis_statusu_rej;
        SELF.status_zal := status_zal;
        SELF.opis_statusu_zal := opis_statusu_zal;
        SELF.suma_ocen := suma_ocen;
        SELF.liczba_ocen := liczba_ocen;
        SELF.os_id := os_id;
        SELF.cdyd_kod := cdyd_kod;
        SELF.prz_kod := prz_kod;
        SELF.utw_data := utw_data;
        SELF.utw_id := utw_id;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.nr_wyb := nr_wyb;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
