CREATE OR REPLACE TYPE V2u_Uu_Protokol_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Protokol_B_t
    ( job_uuid RAW(16)
    , pk_protokol VARCHAR2(128 CHAR)
      -- DBG
      -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)
    , CONSTRUCTOR FUNCTION V2u_Uu_Protokol_t(
              SELF IN OUT NOCOPY V2u_Uu_Protokol_t
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
            -- KEY
            , job_uuid IN RAW
            , pk_protokol IN VARCHAR2
            -- DBG
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    );
/

-- vim: set ft=sql ts=4 sw=4 et:
