CREATE OR REPLACE TYPE BODY V2u_Ko_Classes_Map_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Classes_Map_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN VARCHAR2
            , map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
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
            , classes_hours => classes_hours
            , map_classes_type => map_classes_type
            , map_id => map_id
            , matching_score => matching_score
            , highest_score => highest_score
            , selected => selected
            , reason => reason
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Classes_Map_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
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
            , classes_hours => classes_hours
            );
        SELF.map_id := map_id;
        SELF.map_classes_type := map_classes_type;
        SELF.matching_score := matching_score;
        SELF.highest_score := highest_score;
        SELF.selected := selected;
        SELF.reason := reason;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
