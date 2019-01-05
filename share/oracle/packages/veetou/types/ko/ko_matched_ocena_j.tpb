CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Ocena_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Ocena_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , matching_score IN NUMBER
            , wart_oc_kolejnosc IN NUMBER
            , wart_oc_toc_kod IN VARCHAR2
            , wart_oc_opis IN VARCHAR2
            , wart_oc_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , student_id => student_id
            , classes_type => classes_type
            , subj_grade => subj_grade
            , subj_grade_date => subj_grade_date
            , map_subj_grade => map_subj_grade
            , map_subj_grade_type => map_subj_grade_type
            , os_id => os_id
            , prot_id => prot_id
            , term_prot_nr => term_prot_nr
            , matching_score => matching_score
            , wart_oc_kolejnosc => wart_oc_kolejnosc
            , wart_oc_toc_kod => wart_oc_toc_kod
            , wart_oc_opis => wart_oc_opis
            , wart_oc_missmatch => wart_oc_missmatch
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , classes_type IN CHAR
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            , os_id IN NUMBER
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , matching_score IN NUMBER
            , wart_oc_kolejnosc IN NUMBER
            , wart_oc_toc_kod IN VARCHAR2
            , wart_oc_opis IN VARCHAR2
            , wart_oc_missmatch IN VARCHAR2
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
            , subj_grade => subj_grade
            , subj_grade_date => subj_grade_date
            , map_subj_grade => map_subj_grade
            , map_subj_grade_type => map_subj_grade_type
            );
        SELF.os_id := os_id;
        SELF.prot_id := prot_id;
        SELF.term_prot_nr := term_prot_nr;
        SELF.matching_score := matching_score;
        SELF.wart_oc_kolejnosc := wart_oc_kolejnosc;
        SELF.wart_oc_toc_kod := wart_oc_toc_kod;
        SELF.wart_oc_opis := wart_oc_opis;
        SELF.wart_oc_missmatch := wart_oc_missmatch;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
