CREATE OR REPLACE TYPE BODY V2u_Dz_Grupa_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Grupa_t(
              SELF IN OUT NOCOPY V2u_Dz_Grupa_t
            , nr IN NUMBER
            , zaj_cyk_id IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , gr_nr IN NUMBER
            , gr_zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , waga_pensum IN NUMBER
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , url IN VARCHAR2
            , opis_ang IN VARCHAR2
            , dolny_limit_miejsc IN NUMBER
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              nr => nr
            , zaj_cyk_id => zaj_cyk_id
            , limit_miejsc => limit_miejsc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_data => mod_data
            , mod_id => mod_id
            , gr_nr => gr_nr
            , gr_zaj_cyk_id => gr_zaj_cyk_id
            , opis => opis
            , waga_pensum => waga_pensum
            , zakres_tematow => zakres_tematow
            , zakres_tematow_ang => zakres_tematow_ang
            , metody_dyd => metody_dyd
            , metody_dyd_ang => metody_dyd_ang
            , literatura => literatura
            , literatura_ang => literatura_ang
            , url => url
            , opis_ang => opis_ang
            , dolny_limit_miejsc => dolny_limit_miejsc
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            );
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
