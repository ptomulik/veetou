CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Ocena_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Ocena_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_V_t
            , missing_ocena_j IN V2u_Ko_Missing_Ocena_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , protokol IN V2u_Dz_Protokol_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              grade_i => missing_ocena_j
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
            );
        SELF.os_id := missing_ocena_j.os_id;
        SELF.prot_id := missing_ocena_j.prot_id;
        SELF.matching_scores := missing_ocena_j.matching_scores;
        SELF.highest_score := missing_ocena_j.highest_score;
        SELF.reason := missing_ocena_j.reason;
        -- DZ_PROTOKOL
        SELF.zaj_cyk_id := protokol.zaj_cyk_id;
        SELF.protokol_opis := protokol.opis;
        SELF.tpro_kod := protokol.tpro_kod;
        SELF.prz_kod := protokol.prz_kod;
        SELF.cdyd_kod := protokol.cdyd_kod;
        SELF.czy_do_sredniej := protokol.czy_do_sredniej;
        SELF.edycja := protokol.edycja;
        SELF.protokol_opis_ang := protokol.opis_ang;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
