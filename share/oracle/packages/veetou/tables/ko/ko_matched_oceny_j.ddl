CREATE TABLE v2u_ko_matched_oceny_j
OF V2u_Ko_Matched_Ocena_J_t
    (
        -- PK
          CONSTRAINT v2u_ko_matched_oceny_j_pk
            PRIMARY KEY ( os_id
                        , prot_id
                        , term_prot_nr
                        , classes_type
                        , student_id
                        , subject_id
                        , specialty_id
                        , semester_id
                        , job_uuid)
        -- FK
        , CONSTRAINT v2u_ko_matched_oceny_j_f0 FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f2
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f3
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f4
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f5
            FOREIGN KEY (specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_specialty_semesters_j(specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f6
            FOREIGN KEY (student_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_student_semesters_j(student_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_oceny_j_f7
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)

        -- DEF
        , classes_type DEFAULT '-'
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_ko_matched_oceny_j_idx1
    ON v2u_ko_matched_oceny_j(
              subject_id
            , specialty_id
            , semester_id
            , job_uuid
            );
/
CREATE INDEX v2u_ko_matched_oceny_j_idx2
    ON v2u_ko_matched_oceny_j(
              student_id
            , subject_id
            , specialty_id
            , semester_id
            , job_uuid
            );
/
CREATE INDEX v2u_ko_matched_oceny_j_idx3
    ON v2u_ko_matched_oceny_j(
              classes_type
            , subject_id
            , specialty_id
            , semester_id
            , job_uuid
            );
/
CREATE INDEX v2u_ko_matched_oceny_j_idx4
    ON v2u_ko_matched_oceny_j(
              classes_type
            , subject_id
            , student_id
            , specialty_id
            , semester_id
            , job_uuid
            );
/
CREATE INDEX v2u_ko_matched_oceny_j_idx5
    ON v2u_ko_matched_oceny_j(
              classes_type
            , subject_id
            , student_id
            , specialty_id
            , semester_id
            , selected
            , job_uuid
            );
/
CREATE INDEX v2u_ko_matched_oceny_j_idx6
    ON v2u_ko_matched_oceny_j(
              prot_id
            , term_prot_nr
            , subj_grade_date
            , selected
            );
/
-- vim: set ft=sql ts=4 sw=4 et:
