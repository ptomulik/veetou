CREATE OR REPLACE TYPE BODY V2u_Uu_Termin_Protokolu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Termin_Protokolu_t(
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
    IS
    BEGIN
        SELF.init(
              prot_id => prot_id
            , nr => nr
            , status => status
            , utw_id => utw_id
            , utw_data => utw_data
            , opis => opis
            , data_zwrotu => data_zwrotu
            , mod_id => mod_id
            , mod_data => mod_data
            , egzamin_komisyjny => egzamin_komisyjny
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_termin_protokolu := pk_termin_protokolu;
        -- DBG
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
