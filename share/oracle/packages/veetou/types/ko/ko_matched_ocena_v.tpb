CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Ocena_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Ocena_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_V_t
            , matched_ocena_j IN V2u_Ko_Matched_Ocena_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , protokol IN V2u_Dz_Protokol_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            , ocena IN V2u_Dz_Ocena_t
            , wartosc_oceny IN V2u_Dz_Wartosc_Oceny_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              grade_i => matched_ocena_j
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
            );
        SELF.os_id := matched_ocena_j.os_id;
        SELF.prot_id := matched_ocena_j.prot_id;
        SELF.term_prot_nr := matched_ocena_j.term_prot_nr;
        SELF.matching_score := matched_ocena_j.matching_score;
        SELF.wart_oc_missmatch := matched_ocena_j.wart_oc_missmatch;
        -- DZ_PROTOKOL
        SELF.zaj_cyk_id := protokol.zaj_cyk_id;
        SELF.protokol_opis := protokol.opis;
        SELF.tpro_kod := protokol.tpro_kod;
        SELF.prz_kod := protokol.prz_kod;
        SELF.cdyd_kod := protokol.cdyd_kod;
        SELF.czy_do_sredniej := protokol.czy_do_sredniej;
        SELF.edycja := protokol.edycja;
        SELF.protokol_opis_ang := protokol.opis_ang;
        -- DZ_TERMINY_PROTOKOLOW
        SELF.term_prot_status := termin_protokolu.status;
        SELF.term_prot_opis := termin_protokolu.opis;
        SELF.data_zwrotu := termin_protokolu.data_zwrotu;
        SELF.egzamin_komisyjny := termin_protokolu.egzamin_komisyjny;
        -- DZ_OCENA
        SELF.komentarz_pub := ocena.komentarz_pub;
        SELF.komentarz_pryw := ocena.komentarz_pryw;
        SELF.toc_kod := ocena.toc_kod;
        SELF.wart_oc_kolejnosc := ocena.wart_oc_kolejnosc;
        SELF.zmiana_os_id := ocena.zmiana_os_id;
        SELF.zmiana_data := ocena.zmiana_data;
        SELF.pos_komi_id := ocena.pos_komi_id;
        -- DZ_WARTOSC_OCENY
        SELF.wart_oc_opis := wartosc_oceny.opis;
        SELF.czy_zal := wartosc_oceny.czy_zal;
        SELF.wartosc := wartosc_oceny.wartosc;
        SELF.wart_oc_description := wartosc_oceny.description;
        SELF.opis_oceny := wartosc_oceny.opis_oceny;
        SELF.czy_dwoja_reg := wartosc_oceny.czy_dwoja_reg;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
