CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Proto_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              missing_proto_j => missing_proto_j
            , subject => subject
            , specialty => specialty
            , semester => semester
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
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
        SELF.classes_type := missing_proto_j.classes_type;
        SELF.subject_map_id := missing_proto_j.subject_map_id;
        SELF.map_subj_code := missing_proto_j.map_subj_code;
        SELF.classes_map_id := missing_proto_j.classes_map_id;
        SELF.map_classes_type := missing_proto_j.map_classes_type;
        SELF.coalesced_proto_type := missing_proto_j.coalesced_proto_type;
        SELF.zaj_cyk_id := missing_proto_j.zaj_cyk_id;
        SELF.prot_id := missing_proto_j.prot_id;
        SELF.reason := missing_proto_j.reason;
        SELF.istniejace_tpro_kody := missing_proto_j.istniejace_tpro_kody;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
