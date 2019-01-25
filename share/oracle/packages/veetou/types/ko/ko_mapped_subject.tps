CREATE OR REPLACE TYPE V2u_Ko_Mapped_Subject_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , matching_score NUMBER(2)
    , subject_instance REF V2u_Ko_Subject_Instance_t
    , subject_mapping REF V2u_Subject_Mapping_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Subject_t(
              SELF IN OUT NOCOPY V2u_Ko_Mapped_Subject_t
            , job_uuid IN RAW
            , id IN NUMBER
            , matching_score IN NUMBER := NULL
            , subject_instance IN REF V2u_Ko_Subject_Instance_t := NULL
            , subject_mapping IN REF V2u_Subject_Mapping_t := NULL
            ) RETURN SELF AS RESULT
    );

-- vim: set ft=sql ts=4 sw=4 et:
