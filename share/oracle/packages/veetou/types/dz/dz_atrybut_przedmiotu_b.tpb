CREATE OR REPLACE TYPE BODY V2u_Dz_Atrybut_Przedmiotu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Atrybut_Przedmiotu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Atrybut_Przedmiotu_B_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              tatr_kod => tatr_kod
            , prz_kod => prz_kod
            , wart_lst_id => wart_lst_id
            , prz_kod_rel => prz_kod_rel
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , wartosc => wartosc
            , wartosc_ang => wartosc_ang
            , id => id
        );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Atrybut_Przedmiotu_B_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            )
    IS
    BEGIN
        SELF.tatr_kod := tatr_kod;
        SELF.prz_kod := prz_kod;
        SELF.wart_lst_id := wart_lst_id;
        SELF.prz_kod_rel := prz_kod_rel;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.wartosc := wartosc;
        SELF.wartosc_ang := wartosc_ang;
        SELF.id := id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
