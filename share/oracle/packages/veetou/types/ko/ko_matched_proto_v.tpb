CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Proto_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_V_t
            , matched_proto_j IN V2u_Ko_Matched_Proto_J_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , protokol IN V2u_Dz_Protokol_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => matched_proto_j.classes_type
            , student => student
        );
        -- DZ
        SELF.zaj_cyk_id := protokol.zaj_cyk_id;
        SELF.opis := protokol.opis;
        SELF.utw_id := protokol.utw_id;
        SELF.utw_data := protokol.utw_data;
        SELF.mod_id := protokol.mod_id;
        SELF.mod_data := protokol.mod_data;
        SELF.tpro_kod := protokol.tpro_kod;
        SELF.prot_id := protokol.id;
        SELF.prz_kod := protokol.prz_kod;
        SELF.cdyd_kod := protokol.cdyd_kod;
        SELF.czy_do_sredniej := protokol.czy_do_sredniej;
        SELF.edycja := protokol.edycja;
        SELF.opis_ang := protokol.opis_ang;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
