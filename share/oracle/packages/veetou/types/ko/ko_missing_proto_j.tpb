CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Proto_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , protocol_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , student_id => student_id
            , subject_map_id => subject_map_id
            , classes_map_id => classes_map_id
            , protocol_map_id => protocol_map_id
            , map_subj_code => map_subj_code
            , map_classes_type => map_classes_type
            , proto_type => proto_type
            , zaj_cyk_id => zaj_cyk_id
            , prot_id => prot_id
            , reason => reason
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
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , protocol_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , student_id => student_id
            );
        SELF.subject_map_id := subject_map_id;
        SELF.classes_map_id := classes_map_id;
        SELF.protocol_map_id := protocol_map_id;
        SELF.map_subj_code := map_subj_code;
        SELF.map_classes_type := map_classes_type;
        SELF.proto_type := proto_type;
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.prot_id := prot_id;
        SELF.reason := reason;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
