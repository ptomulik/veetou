CREATE OR REPLACE TYPE V2u_Dz_Decyzja_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , prgos_id NUMBER(10)
    , etp_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , data_decyzji DATE
    , stan VARCHAR2(1 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , termin_do_modyfikacji DATE
    , komentarz VARCHAR2(1000 CHAR)
    , nast_etp_kod VARCHAR2(20 CHAR)
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , rodzaj VARCHAR2(1 CHAR)
    , wyj_id NUMBER(10)
    , pod_stan NUMBER(1)
    , utw_la_data DATE
    , elmo_id_blobbox VARCHAR2(20 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Decyzja_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Decyzja_B_t
            , id IN NUMBER
            , prgos_id IN NUMBER
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , data_decyzji IN DATE
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , termin_do_modyfikacji IN DATE
            , komentarz IN VARCHAR2
            , nast_etp_kod IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , rodzaj IN VARCHAR2
            , wyj_id IN NUMBER
            , pod_stan IN NUMBER
            , utw_la_data IN DATE
            , elmo_id_blobbox IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Decyzja_B_t
            , id IN NUMBER
            , prgos_id IN NUMBER
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , data_decyzji IN DATE
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , termin_do_modyfikacji IN DATE
            , komentarz IN VARCHAR2
            , nast_etp_kod IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , rodzaj IN VARCHAR2
            , wyj_id IN NUMBER
            , pod_stan IN NUMBER
            , utw_la_data IN DATE
            , elmo_id_blobbox IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
