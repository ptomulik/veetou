CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Pktprz_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Pktprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , specialty_map_ids IN V2u_20Ids_t
            , map_program_codes IN V2u_Program_20Codes_t
            , istniejace_pkt_prz_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , specialty_map_ids => specialty_map_ids
            , map_program_codes => map_program_codes
            , istniejace_pkt_prz_ids => istniejace_pkt_prz_ids
            , reason => reason
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , specialty_map_ids IN V2u_20Ids_t
            , map_program_codes IN V2u_Program_20Codes_t
            , istniejace_pkt_prz_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.subject_map_id := subject_map_id;
        SELF.map_subj_code := map_subj_code;
        SELF.specialty_map_ids := specialty_map_ids;
        SELF.map_program_codes := map_program_codes;
        SELF.istniejace_pkt_prz_ids := istniejace_pkt_prz_ids;
        SELF.reason := reason;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
