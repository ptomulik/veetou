CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Proto_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              missing_proto_j => missing_proto_j
            , grade_i => grade_i
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
            , grade_i IN V2u_Ko_Grade_I_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            )
    IS
    BEGIN
        SELF.init(
              grade_i => grade_i
            , subject => subject
            , specialty => specialty
            , semester => semester
            , student => student
            );
        SELF.subject_map_id := missing_proto_j.subject_map_id;
        SELF.classes_map_id := missing_proto_j.classes_map_id;
        SELF.protocol_map_id := missing_proto_j.protocol_map_id;
        SELF.map_subj_code := missing_proto_j.map_subj_code;
        SELF.map_classes_type := missing_proto_j.map_classes_type;
        SELF.proto_type := missing_proto_j.proto_type;
        SELF.zaj_cyk_id := missing_proto_j.zaj_cyk_id;
        SELF.prot_id := missing_proto_j.prot_id;
        SELF.reason := missing_proto_j.reason;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
