CREATE OR REPLACE TYPE V2u_Dz_Decyzja_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Decyzja_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Decyzja_t(
              SELF IN OUT NOCOPY V2u_Dz_Decyzja_t
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Decyzje_t
    AS TABLE OF V2u_Dz_Decyzja_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
