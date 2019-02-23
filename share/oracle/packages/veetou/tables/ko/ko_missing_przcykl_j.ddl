CREATE TABLE v2u_ko_missing_przcykl_j
OF V2u_Ko_Missing_Przcykl_J_t
    (
        -- PK
          CONSTRAINT v2u_ko_missing_przcykl_j_pk
            PRIMARY KEY (subject_id, specialty_id, semester_id, job_uuid)
        -- FK
        , CONSTRAINT v2u_ko_missing_przcykl_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_missing_przcykl_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_przcykl_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_przcykl_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_missing_przcykl_j_f4
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE istniejace_cdyd_kody STORE AS v2u_ko_mprzcykl_j_cdyds_nt
    ((CONSTRAINT v2u_ko_mprzcykl_j_cdyds_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)))
;

-- vim: set ft=sql ts=4 sw=4 et:
