CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Proto_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
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
            , classes_map_id => classes_map_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tpro_kod => tpro_kod
            , prot_id => prot_id
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
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
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
        SELF.classes_map_id := classes_map_id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tpro_kod := tpro_kod;
        SELF.prot_id := prot_id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
