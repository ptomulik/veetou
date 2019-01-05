CREATE OR REPLACE TYPE V2u_Dz_Osoba_Grupy_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Osoba_Grupy_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Osoba_Grupy_t(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_Grupy_t
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Osoby_Grup_t
    AS TABLE OF V2u_Dz_Osoba_Grupy_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
