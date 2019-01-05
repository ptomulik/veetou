CREATE OR REPLACE TYPE BODY V2u_Dz_Osoba_Grupy_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Osoba_Grupy_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_Grupy_B_t
            , gr_nr IN NUMBER
            , os_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , rej_data IN DATE
            , rej_os_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              gr_nr => gr_nr
            , os_id => os_id
            , zaj_cyk_id => zaj_cyk_id
            , utw_data => utw_data
            , utw_id => utw_id
            , mod_data => mod_data
            , mod_id => mod_id
            , rej_data => rej_data
            , rej_os_id => rej_os_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_Grupy_B_t
            , gr_nr IN NUMBER
            , os_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , rej_data IN DATE
            , rej_os_id IN NUMBER
        )
    IS
    BEGIN
        SELF.gr_nr := gr_nr;
        SELF.os_id := os_id;
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.utw_data := utw_data;
        SELF.utw_id := utw_id;
        SELF.mod_data := mod_data;
        SELF.mod_id := mod_id;
        SELF.rej_data := rej_data;
        SELF.rej_os_id := rej_os_id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
