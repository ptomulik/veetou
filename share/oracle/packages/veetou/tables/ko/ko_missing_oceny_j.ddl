CREATE TABLE v2u_ko_missing_oceny_j
OF V2u_Ko_Missing_Ocena_J_t
    (
        -- PK
          CONSTRAINT v2u_ko_missing_oceny_j_pk
            PRIMARY KEY ( student_id
                        , subject_id
                        , specialty_id
                        , semester_id
                        , classes_type
                        , job_uuid
                        )
        -- FK
        , CONSTRAINT v2u_ko_missing_oceny_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_missing_oceny_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_oceny_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_oceny_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_oceny_j_f4
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
-- vim: set ft=sql ts=4 sw=4 et:
