CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Trmpro_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade_date VARCHAR2
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , subj_grade_date => subj_grade_date
            , subject_map_id => subject_map_id
            , classes_map_id => classes_map_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tpro_kod => tpro_kod
            , prot_id => prot_id
            , nr => nr
            , data_zwrotu => data_zwrotu
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade_date VARCHAR2
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , data_zwrotu IN DATE
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
        SELF.subj_grade_date := subj_grade_date;
        SELF.subject_map_id := subject_map_id;
        SELF.classes_map_id := classes_map_id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tpro_kod := tpro_kod;
        SELF.prot_id := prot_id;
        SELF.nr := nr;
        SELF.data_zwrotu := data_zwrotu;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
