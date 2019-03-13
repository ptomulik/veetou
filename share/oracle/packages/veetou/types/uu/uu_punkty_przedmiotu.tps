CREATE OR REPLACE TYPE V2u_Uu_Punkty_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Punkty_Przedmiotu_B_t
    ( job_uuid RAW(16)
    , pk_punkty_przedmiotu VARCHAR2(128 CHAR)
    -- DBG
    -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Punkty_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
