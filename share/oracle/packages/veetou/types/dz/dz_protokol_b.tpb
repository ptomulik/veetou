CREATE OR REPLACE TYPE BODY V2u_Dz_Protokol_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Protokol_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Protokol_B_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              zaj_cyk_id => zaj_cyk_id
            , opis => opis
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , czy_do_sredniej => czy_do_sredniej
            , edycja => edycja
            , opis_ang => opis_ang
            );
            RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Protokol_B_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
        )
    IS
    BEGIN
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.opis := opis;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.tpro_kod := tpro_kod;
        SELF.id := id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.czy_do_sredniej := czy_do_sredniej;
        SELF.edycja := edycja;
        SELF.opis_ang := opis_ang;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
