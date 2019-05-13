CREATE TABLE v2u_ko_matched_zalprz_j
OF V2u_Ko_Matched_Zalprz_J_t
    (
        -- PK

          CONSTRAINT v2u_ko_matched_zalprz_j_pk
            PRIMARY KEY ( os_id
                        , cdyd_kod
                        , prz_kod
                        , student_id
                        , subject_id
                        , specialty_id
                        , semester_id
                        , job_uuid
                        )
        -- FK
        , CONSTRAINT v2u_ko_matched_zalprz_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_zalprz_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zalprz_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zalprz_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zalprz_j_f4
            FOREIGN KEY (student_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_student_semesters_j(student_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zalprz_j_f5
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_ko_matched_zalprz_j_idx1
    ON v2u_ko_matched_zalprz_j(student_id, subject_id, specialty_id, semester_id, job_uuid);
/
-- vim: set ft=sql ts=4 sw=4 et:
