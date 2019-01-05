CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Trmpro_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_V_t
            , matched_trmpro_j IN V2u_Ko_Matched_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , protokol IN V2u_Dz_Protokol_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => matched_trmpro_j.classes_type
            , student => student
        );
        -- PROTOKOL
        SELF.zaj_cyk_id := protokol.zaj_cyk_id;
        SELF.prot_opis := protokol.opis;
        SELF.tpro_kod := protokol.tpro_kod;
        SELF.prot_id := termin_protokolu.prot_id;
        SELF.prz_kod := protokol.prz_kod;
        SELF.cdyd_kod := protokol.cdyd_kod;
        SELF.czy_do_sredniej := protokol.czy_do_sredniej;
        SELF.edycja := protokol.edycja;
        SELF.prot_opis_ang := protokol.opis_ang;
        -- TERMIN_PROTOKOLU
        SELF.nr := termin_protokolu.nr;
        SELF.status := termin_protokolu.status;
        SELF.utw_id := termin_protokolu.utw_id;
        SELF.utw_data := termin_protokolu.utw_data;
        SELF.opis := termin_protokolu.opis;
        SELF.data_zwrotu := termin_protokolu.data_zwrotu;
        SELF.mod_id := termin_protokolu.mod_id;
        SELF.mod_data := termin_protokolu.mod_data;
        SELF.egzamin_komisyjny := termin_protokolu.egzamin_komisyjny;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
