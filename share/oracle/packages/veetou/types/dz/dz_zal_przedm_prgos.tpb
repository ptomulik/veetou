CREATE OR REPLACE TYPE BODY V2u_Dz_Zal_Przedm_Prgos_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zal_Przedm_Prgos_t(
              SELF IN OUT NOCOPY V2u_Dz_Zal_Przedm_Prgos_t
            , os_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , etpos_id IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , do_sredniej IN VARCHAR2
            , do_sredniej_zmiana_os_id IN NUMBER
            , do_sredniej_zmiana_data IN DATE
            , podp_data IN DATE
            , podp_os_id IN NUMBER
            , czy_platny_ects_ustawa IN VARCHAR2
            , kto_placi IN VARCHAR2
            , podp_etpos_data IN DATE
            , podp_etpos_os_id IN NUMBER
            , katprz_id IN NUMBER
            , pw_ponadprogramowy IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , prgos_id => prgos_id
            , stan => stan
            , utw_id => utw_id
            , utw_data => utw_data
            , etpos_id => etpos_id
            , mod_id => mod_id
            , mod_data => mod_data
            , do_sredniej => do_sredniej
            , do_sredniej_zmiana_os_id => do_sredniej_zmiana_os_id
            , do_sredniej_zmiana_data => do_sredniej_zmiana_data
            , podp_data => podp_data
            , podp_os_id => podp_os_id
            , czy_platny_ects_ustawa => czy_platny_ects_ustawa
            , kto_placi => kto_placi
            , podp_etpos_data => podp_etpos_data
            , podp_etpos_os_id => podp_etpos_os_id
            , katprz_id => katprz_id
            , pw_ponadprogramowy => pw_ponadprogramowy
            );
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
