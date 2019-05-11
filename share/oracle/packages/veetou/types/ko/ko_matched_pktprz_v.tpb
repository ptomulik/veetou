CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Pktprz_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Pktprz_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_V_t
            , matched_pktprz_j IN V2u_Ko_Matched_Pktprz_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , punkty_przedmiotu IN V2u_Dz_Punkty_Przedmiotu_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_pktprz_j.job_uuid;
        SELF.subject_id := matched_pktprz_j.subject_id;
        SELF.specialty_id := matched_pktprz_j.specialty_id;
        SELF.semester_id := matched_pktprz_j.semester_id;
        SELF.subject_map_id := matched_pktprz_j.subject_map_id;
        SELF.ilosc_missmatch := matched_pktprz_j.ilosc_missmatch;
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
        SELF.prz_kod := punkty_przedmiotu.prz_kod;
        SELF.prg_kod := punkty_przedmiotu.prg_kod;
        SELF.tpkt_kod := punkty_przedmiotu.tpkt_kod;
        SELF.ilosc := punkty_przedmiotu.ilosc;
        SELF.utw_id := punkty_przedmiotu.utw_id;
        SELF.utw_data := punkty_przedmiotu.utw_data;
        SELF.mod_id := punkty_przedmiotu.mod_id;
        SELF.mod_data := punkty_przedmiotu.mod_data;
        SELF.id := punkty_przedmiotu.id;
        SELF.cdyd_pocz := punkty_przedmiotu.cdyd_pocz;
        SELF.cdyd_kon := punkty_przedmiotu.cdyd_kon;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
