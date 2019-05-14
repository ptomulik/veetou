CREATE OR REPLACE TYPE V2u_Dz_Termin_Protokolu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( prot_id NUMBER(10)
    , nr NUMBER(10)
    , status VARCHAR2(2 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , opis VARCHAR2(100 CHAR)
    , data_zwrotu DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , egzamin_komisyjny VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Termin_Protokolu_B_t(
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

    , MEMBER PROCEDURE init(
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
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
