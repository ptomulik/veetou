CREATE TABLE v2u_ko_grades_j
    (
          job_uuid RAW(16)
        , student_id NUMBER(38)
        , subject_id NUMBER(38)
        , specialty_id NUMBER(38)
        , semester_id NUMBER(38)
        , subj_grade VARCHAR2(10 CHAR)
        , subj_grade_date DATE
        , tr_id NUMBER(38)

        , CONSTRAINT v2u_ko_grades_j_pk
            PRIMARY KEY (student_id, subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f0 FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f2
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f3
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f4
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f5
            FOREIGN KEY (specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_specialty_semesters_j(specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f6
            FOREIGN KEY (student_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_student_semesters_j(student_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_grades_j_f7
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
