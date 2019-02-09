CREATE OR REPLACE TYPE BODY V2u_Ko_Strict_Subj_Map_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Strict_Subj_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , map_id => map_id
            , matching_score => matching_score
            , rejected_maps => rejected_maps
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Strict_Subj_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , map IN V2u_Subject_Map_t
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , subject => subject
            , map => map
            , matching_score => matching_score
            , rejected_maps => rejected_maps
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , map_id => map_id
            , matching_score => matching_score
            );
        SELF.rejected_maps := rejected_maps;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Strict_Subj_Map_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , map IN V2u_Subject_Map_t
            , matching_score IN NUMBER
            , rejected_maps IN V2u_Ko_Rejected_Maps_t
            )
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , subject => subject
            , map => map
            , matching_score => matching_score
            );
        SELF.rejected_maps := rejected_maps;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
