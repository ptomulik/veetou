CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Pktprz_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Pktprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_J_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subject_map_id => subject_map_id
            , matching_score => matching_score
            , prz_kod => prz_kod
            , pktprz_id => pktprz_id
            , prg_kod => prg_kod
            , cdyd_pocz => cdyd_pocz
            , cdyd_kon => cdyd_kon
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
