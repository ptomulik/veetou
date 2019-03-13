CREATE OR REPLACE TYPE BODY V2u_Dz_Termin_Protokolu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Termin_Protokolu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Termin_Protokolu_B_t
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
            RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Termin_Protokolu_B_t
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
        )
    IS
    BEGIN
        SELF.prot_id := prot_id;
        SELF.nr := nr;
        SELF.status := status;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.opis := opis;
        SELF.data_zwrotu := data_zwrotu;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.egzamin_komisyjny := egzamin_komisyjny;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
