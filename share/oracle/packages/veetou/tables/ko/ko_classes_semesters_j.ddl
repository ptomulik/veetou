CREATE TABLE v2u_ko_classes_semesters_j
OF V2u_Ko_Classes_Semester_J_t
    (
          CONSTRAINT v2u_ko_classes_semesters_j_pk
            PRIMARY KEY (job_uuid, semester_id, specialty_id, subject_id, classes_type)
        , CONSTRAINT v2u_ko_classes_semesters_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_classes_semesters_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_classes_semesters_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_classes_semesters_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_classes_semesters_j_f4
            FOREIGN KEY (job_uuid, semester_id, specialty_id)
            REFERENCES v2u_ko_specialty_semesters_j(job_uuid, semester_id, specialty_id)
        , CONSTRAINT v2u_ko_classes_semesters_j_f5
            FOREIGN KEY (job_uuid, semester_id, specialty_id, subject_id)
            REFERENCES v2u_ko_subject_semesters_j(job_uuid, semester_id, specialty_id, subject_id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

-- vim: set ft=sql ts=4 sw=4 et:
