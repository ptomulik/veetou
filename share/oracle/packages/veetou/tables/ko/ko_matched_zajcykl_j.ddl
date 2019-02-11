CREATE TABLE v2u_ko_matched_zajcykl_j
    (
          id NUMBER(38)
        , job_uuid RAW(16)
        , subject_id NUMBER(38)
        , specialty_id NUMBER(38)
        , semester_id NUMBER(38)
        , classes_type VARCHAR2(1 CHAR)
        , classes_hours NUMBER(8)
        , subject_map_id NUMBER(38)
        , subject_matching_score NUMBER(38)
        , classes_map_id NUMBER(38)
        , classes_matching_score NUMBER(38)
        , prz_kod VARCHAR2(20 CHAR)
        , cdyd_kod VARCHAR2(20 CHAR)
        , tzaj_kod VARCHAR2(20 CHAR)
        , zajcykl_id NUMBER(10)

        , CONSTRAINT v2u_ko_matched_zajcykl_j_pk
            PRIMARY KEY (id)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f4
            FOREIGN KEY (subject_map_id)
            REFERENCES v2u_subject_map(id)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f5
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f6
            FOREIGN KEY (subject_id, specialty_id, semester_id, subject_map_id, job_uuid)
            REFERENCES v2u_ko_subject_map_j(subject_id, specialty_id, semester_id, map_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f7
            FOREIGN KEY (zajcykl_id)
            REFERENCES v2u_dz_zajecia_cykli(id)
        --
        , CONSTRAINT v2u_ko_matched_zajcykl_j_u0
            UNIQUE (job_uuid, subject_id, specialty_id, semester_id, classes_type)
    );
/
CREATE INDEX v2u_ko_matched_zajcykl_j_idx1
    ON v2u_ko_matched_zajcykl_j(job_uuid, subject_id, specialty_id, semester_id);
/
CREATE SEQUENCE v2u_ko_matched_zajcykl_j_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_matched_zajcykl_j_tr1
    BEFORE INSERT ON v2u_ko_matched_zajcykl_j
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_matched_zajcykl_j_sq1.NEXTVAL INTO :new.id FROM dual;
    END;

-- vim: set ft=sql ts=4 sw=4 et:
