CREATE OR REPLACE TYPE V2u_Dz_Protokol_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Protokol_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Protokol_t(
              SELF IN OUT NOCOPY V2u_Dz_Protokol_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Protokoly_t
    AS TABLE OF V2u_Dz_Protokol_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
