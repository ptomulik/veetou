CREATE OR REPLACE TYPE BODY V2u_Dz_Etap_Kierunku_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Etap_Kierunku_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Kierunku_B_t
            , krstd_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              krstd_kod => krstd_kod
            , etp_kod => etp_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            );
            RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Kierunku_B_t
            , krstd_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
        )
    IS
    BEGIN
        SELF.krstd_kod := krstd_kod;
        SELF.etp_kod := etp_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
