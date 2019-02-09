CREATE TABLE v2u_ko_strict_subj_map_j
OF V2u_Ko_Strict_Subj_Map_J_t
    (
          CONSTRAINT v2u_ko_strict_subj_map_j_pk
            PRIMARY KEY (subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_strict_subj_map_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_strict_subj_map_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_strict_subj_map_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_strict_subj_map_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_strict_subj_map_j_f4
            FOREIGN KEY (map_id)
            REFERENCES v2u_subject_map(id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE rejected_maps STORE AS v2u_ko_strct_subj_map_j_nt
--    ((CONSTRAINT v2u_ko_strct_subj_map_j_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)))
;

-- vim: set ft=sql ts=4 sw=4 et:
