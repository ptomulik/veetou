CREATE OR REPLACE TYPE V2u_Uu_Termin_Protokolu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Termin_Protokolu_B_t
    ( job_uuid RAW(16)
    , pk_termin_protokolu VARCHAR2(128 CHAR)
      -- DBG
      -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)
    , CONSTRUCTOR FUNCTION V2u_Uu_Termin_Protokolu_t(
              SELF IN OUT NOCOPY V2u_Uu_Termin_Protokolu_t
            , prot_id IN NUMBER
            , nr IN NUMBER
            , status IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , opis IN VARCHAR2
            , data_zwrotu IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , egzamin_komisyjny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_termin_protokolu IN VARCHAR2
            -- DBG
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    );
/

-- vim: set ft=sql ts=4 sw=4 et:
