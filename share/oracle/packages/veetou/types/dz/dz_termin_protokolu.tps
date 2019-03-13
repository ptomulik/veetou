CREATE OR REPLACE TYPE V2u_Dz_Termin_Protokolu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Termin_Protokolu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Termin_Protokolu_t(
              SELF IN OUT NOCOPY V2u_Dz_Termin_Protokolu_t
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Terminy_Protokolow_t
    AS TABLE OF V2u_Dz_Termin_Protokolu_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
