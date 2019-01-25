CREATE OR REPLACE TYPE BODY V2u_Ko_Mapped_Subject_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Subject_t(
              SELF IN OUT NOCOPY V2u_Ko_Mapped_Subject_t
            , job_uuid IN RAW
            , id IN NUMBER
            , matching_score IN NUMBER := NULL
            , subject_instance IN REF V2u_Ko_Subject_Instance_t := NULL
            , subject_mapping IN REF V2u_Subject_Mapping_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.matching_score := matching_score;
        SELF.subject_instance := subject_instance;
        SELF.subject_mapping := subject_mapping;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
