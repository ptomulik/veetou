CREATE TABLE v2u_ko_student_threads_j
    (
          job_uuid RAW(16)
        , id NUMBER(38)
        , student_id NUMBER(38) NOT NULL
        , specialty_id NUMBER(38) NOT NULL
        , specialty_map_id NUMBER(38)
        , thread_index NUMBER(2) NOT NULL
        , semester_ids V2u_Ids_t
        , max_admission_semester VARCHAR2(6 CHAR)
        , CONSTRAINT v2u_ko_student_threads_j_pk
            PRIMARY KEY (id, job_uuid)
        , CONSTRAINT v2u_ko_student_threads_j_u0
            UNIQUE (student_id, specialty_id, specialty_map_id, thread_index, job_uuid)
        , CONSTRAINT v2u_ko_student_threads_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_student_threads_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_student_threads_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_student_threads_j_f3
            FOREIGN KEY (specialty_map_id)
            REFERENCES v2u_specialty_map(id)
    )
NESTED TABLE semester_ids STORE AS v2u_ko_stud_thread_sems_nt
    ((CONSTRAINT v2u_ko_stud_thread_sems_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
/
CREATE SEQUENCE v2u_ko_student_threads_j_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_student_threads_j_tr1
    BEFORE INSERT ON v2u_ko_student_threads_j
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_student_threads_j_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/
CREATE INDEX v2u_ko_student_threads_j_idx1
    ON v2u_ko_student_threads_j(student_id, specialty_id, job_uuid);
/
CREATE INDEX v2u_ko_student_threads_j_idx2
    ON v2u_ko_student_threads_j(student_id, specialty_id, specialty_map_id, job_uuid);

-- vim: set ft=sql ts=4 sw=4 et: