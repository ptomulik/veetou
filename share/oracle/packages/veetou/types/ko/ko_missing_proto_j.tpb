CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Proto_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            , istniejace_tpro_kody IN V2u_Prot_20Codes_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , classes_map_id => classes_map_id
            , map_classes_type => map_classes_type
            , coalesced_proto_type => coalesced_proto_type
            , zaj_cyk_id => zaj_cyk_id
            , prot_id => prot_id
            , reason => reason
            , istniejace_tpro_kody => istniejace_tpro_kody
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            , istniejace_tpro_kody IN V2u_Prot_20Codes_t
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.classes_type := classes_type;
        SELF.subject_map_id := subject_map_id;
        SELF.map_subj_code := map_subj_code;
        SELF.classes_map_id := classes_map_id;
        SELF.map_classes_type := map_classes_type;
        SELF.coalesced_proto_type := coalesced_proto_type;
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.prot_id := prot_id;
        SELF.reason := reason;
        SELF.istniejace_tpro_kody := istniejace_tpro_kody;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
