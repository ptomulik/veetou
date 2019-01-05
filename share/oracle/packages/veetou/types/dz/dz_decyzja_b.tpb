CREATE OR REPLACE TYPE BODY V2u_Dz_Decyzja_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Decyzja_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Decyzja_B_t
            , id IN NUMBER
            , prgos_id IN NUMBER
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , data_decyzji IN DATE
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , termin_do_modyfikacji IN DATE
            , komentarz IN VARCHAR2
            , nast_etp_kod IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , rodzaj IN VARCHAR2
            , wyj_id IN NUMBER
            , pod_stan IN NUMBER
            , utw_la_data IN DATE
            , elmo_id_blobbox IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , prgos_id => prgos_id
            , etp_kod => etp_kod
            , cdyd_kod => cdyd_kod
            , data_decyzji => data_decyzji
            , stan => stan
            , utw_id => utw_id
            , utw_data => utw_data
            , termin_do_modyfikacji => termin_do_modyfikacji
            , komentarz => komentarz
            , nast_etp_kod => nast_etp_kod
            , mod_id => mod_id
            , mod_data => mod_data
            , rodzaj => rodzaj
            , wyj_id => wyj_id
            , pod_stan => pod_stan
            , utw_la_data => utw_la_data
            , elmo_id_blobbox => elmo_id_blobbox
            );
            RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Decyzja_B_t
            , id IN NUMBER
            , prgos_id IN NUMBER
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , data_decyzji IN DATE
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , termin_do_modyfikacji IN DATE
            , komentarz IN VARCHAR2
            , nast_etp_kod IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , rodzaj IN VARCHAR2
            , wyj_id IN NUMBER
            , pod_stan IN NUMBER
            , utw_la_data IN DATE
            , elmo_id_blobbox IN VARCHAR2
        )
    IS
    BEGIN
        SELF.id := id;
        SELF.prgos_id := prgos_id;
        SELF.etp_kod := etp_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.data_decyzji := data_decyzji;
        SELF.stan := stan;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.termin_do_modyfikacji := termin_do_modyfikacji;
        SELF.komentarz := komentarz;
        SELF.nast_etp_kod := nast_etp_kod;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.rodzaj := rodzaj;
        SELF.wyj_id := wyj_id;
        SELF.pod_stan := pod_stan;
        SELF.utw_la_data := utw_la_data;
        SELF.elmo_id_blobbox := elmo_id_blobbox;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
