CREATE OR REPLACE TYPE V2u_Dz_Zal_Przedm_Prgos_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( os_id NUMBER(10)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , prgos_id NUMBER(10)
    , stan VARCHAR2(1 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , etpos_id NUMBER(10)
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , do_sredniej VARCHAR2(1 CHAR)
    , do_sredniej_zmiana_os_id NUMBER(10)
    , do_sredniej_zmiana_data DATE
    , podp_data DATE
    , podp_os_id NUMBER(10)
    , czy_platny_ects_ustawa VARCHAR2(1 CHAR)
    , kto_placi VARCHAR2(1 CHAR)
    , podp_etpos_data DATE
    , podp_etpos_os_id NUMBER(10)
    , katprz_id NUMBER(10)
    , pw_ponadprogramowy VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Zal_Przedm_Prgos_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Zal_Przedm_Prgos_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Zal_Przedm_Prgos_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
