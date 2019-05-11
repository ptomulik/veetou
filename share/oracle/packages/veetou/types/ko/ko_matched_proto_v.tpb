CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Proto_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_V_t
            , matched_proto_j IN V2u_Ko_Matched_Proto_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , protokol IN V2u_Dz_Protokol_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_proto_j.job_uuid;
        SELF.classes_type := matched_proto_j.classes_type;
        SELF.subject_id := matched_proto_j.subject_id;
        SELF.specialty_id := matched_proto_j.specialty_id;
        SELF.semester_id := matched_proto_j.semester_id;
        SELF.subject_map_id := matched_proto_j.subject_map_id;
        SELF.classes_map_id := matched_proto_j.classes_map_id;
        -- KO
        SELF.subj_code := subject.subj_code;
        SELF.subj_name := subject.subj_name;
        SELF.subj_hours_w := subject.subj_hours_w;
        SELF.subj_hours_c := subject.subj_hours_c;
        SELF.subj_hours_l := subject.subj_hours_l;
        SELF.subj_hours_p := subject.subj_hours_p;
        SELF.subj_hours_s := subject.subj_hours_s;
        SELF.subj_credit_kind := subject.subj_credit_kind;
        SELF.subj_ects := subject.subj_ects;
        SELF.subj_tutor := subject.subj_tutor;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.semester_code := semester.semester_code;
        SELF.semester_number := semester.semester_number;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.ects_total := semester.ects_total;
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
