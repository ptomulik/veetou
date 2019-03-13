CREATE OR REPLACE TYPE V2u_Dz_Zal_Przedm_Prgos_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zal_Przedm_Prgos_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Zal_Przedm_Prgos_t(
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Zal_Przedm_Prgoses_t
    AS TABLE OF V2u_Dz_Zal_Przedm_Prgos_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
