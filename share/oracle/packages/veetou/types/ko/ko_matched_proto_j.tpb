CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Proto_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , tpro_kod_missmatch IN VARCHAR2
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
            , proto_type => proto_type
            , prot_id => prot_id
            , zaj_cyk_id => zaj_cyk_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tpro_kod => tpro_kod
            , tpro_kod_missmatch => tpro_kod_missmatch
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , tpro_kod_missmatch IN VARCHAR2
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
        SELF.proto_type := proto_type;
        SELF.prot_id := prot_id;
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tpro_kod := tpro_kod;
        SELF.tpro_kod_missmatch := tpro_kod_missmatch;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
