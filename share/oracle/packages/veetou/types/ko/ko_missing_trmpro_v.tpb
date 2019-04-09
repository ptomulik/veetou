CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Trmpro_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Trmpro_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_V_t
            , missing_trmpro_j IN V2u_Ko_Missing_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              missing_trmpro_j => missing_trmpro_j
            , subject => subject
            , specialty => specialty
            , semester => semester
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_V_t
            , missing_trmpro_j IN V2u_Ko_Missing_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            );
        SELF.classes_type := missing_trmpro_j.classes_type;
        SELF.subj_grade_date := missing_trmpro_j.subj_grade_date;
        SELF.subject_map_id := missing_trmpro_j.subject_map_id;
        SELF.map_subj_code := missing_trmpro_j.map_subj_code;
        SELF.classes_map_id := missing_trmpro_j.classes_map_id;
        SELF.map_classes_type := missing_trmpro_j.map_classes_type;
        SELF.coalesced_proto_type := missing_trmpro_j.coalesced_proto_type;
        SELF.prot_id := missing_trmpro_j.prot_id;
        SELF.nr := missing_trmpro_j.nr;
        SELF.reason := missing_trmpro_j.reason;
        SELF.max_istniejacy_nr := missing_trmpro_j.max_istniejacy_nr;
        SELF.istniejace_daty_zwrotow := missing_trmpro_j.istniejace_daty_zwrotow;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
