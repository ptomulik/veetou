CREATE OR REPLACE TYPE V2u_Protocol_Map_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( semester_code VARCHAR2(5 CHAR)
    , map_protocol_semester VARCHAR2(20 CHAR)
    , map_protocol_date DATE
    , map_protocol_date_match CHAR(1)
    , map_term_prot_nr NUMBER(10)
    , subject_pattern V2u_Subject_Pattern_t
    , specialty_pattern V2u_Specialty_Pattern_t
    , semester_pattern V2u_Semester_Pattern_t
    , student_pattern V2u_Student_Pattern_t
    , grade_pattern V2u_Grade_Pattern_t


    , CONSTRUCTOR FUNCTION V2u_Protocol_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , semester_code IN VARCHAR2
            , map_protocol_semester IN VARCHAR2
            , map_protocol_date IN DATE
            , map_protocol_date_match IN VARCHAR2
            , map_term_prot_nr IN NUMBER
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            , student_pattern IN V2u_Student_Pattern_t
            , grade_pattern IN V2u_Grade_Pattern_t
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Protocol_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , protocol_map IN V2u_Protocol_Map_B_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , semester_code IN VARCHAR2
            , map_protocol_semester IN VARCHAR2
            , map_protocol_date IN DATE
            , map_protocol_date_match IN VARCHAR2
            , map_term_prot_nr IN NUMBER
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            , student_pattern IN V2u_Student_Pattern_t
            , grade_pattern IN V2u_Grade_Pattern_t
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , protocol_map IN V2u_Protocol_Map_B_t
            )

    , MEMBER FUNCTION match_attributes(
              subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , classes_type IN VARCHAR2
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            ) RETURN INTEGER
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
