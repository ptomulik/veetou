CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Trmpro_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Trmpro_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , student_id IN NUMBER
            , subj_grade_date IN DATE
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , reason IN VARCHAR2
            , max_istniejacy_nr IN NUMBER
            , istniejace_daty_zwrotow IN V2u_20Dates_t
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
            , subj_grade_date => subj_grade_date
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , classes_map_id => classes_map_id
            , map_classes_type => map_classes_type
            , coalesced_proto_type => coalesced_proto_type
            , prot_id => prot_id
            , nr => nr
            , reason => reason
            , max_istniejacy_nr => max_istniejacy_nr
            , istniejace_daty_zwrotow => istniejace_daty_zwrotow
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , student_id IN NUMBER
            , subj_grade_date IN DATE
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , reason IN VARCHAR2
            , max_istniejacy_nr IN NUMBER
            , istniejace_daty_zwrotow IN V2u_20Dates_t
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
        SELF.subj_grade_date := subj_grade_date;
        SELF.subject_map_id := subject_map_id;
        SELF.map_subj_code := map_subj_code;
        SELF.classes_map_id := classes_map_id;
        SELF.map_classes_type := map_classes_type;
        SELF.coalesced_proto_type := coalesced_proto_type;
        SELF.nr := nr;
        SELF.prot_id := prot_id;
        SELF.reason := reason;
        SELF.max_istniejacy_nr := max_istniejacy_nr;
        SELF.istniejace_daty_zwrotow := istniejace_daty_zwrotow;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
