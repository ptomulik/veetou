CREATE OR REPLACE TYPE BODY V2u_Dz_Etap_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Etap_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_t
            , kod IN VARCHAR2
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              kod => kod
            , opis => opis
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , description => description
            );
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
