CREATE TABLE v2u_ko_etapy_osob_j
    (
          id NUMBER(38)
        , job_uuid RAW(16)
        , student_id NUMBER(38)
        , specialty_id NUMBER(38)
        , semester_id NUMBER(38)
        , specialty_map_id NUMBER(38)
        , etpos_id NUMBER(10)
        , semester_number_missmatch VARCHAR2(32)

        , CONSTRAINT v2u_ko_etapy_osob_j_pk
            PRIMARY KEY (id)
        , CONSTRAINT v2u_ko_etapy_osob_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f4
            FOREIGN KEY (student_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_student_semesters_j(student_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f5
            FOREIGN KEY (specialty_id, semester_id, specialty_map_id, job_uuid)
            REFERENCES v2u_ko_specialty_map_j(specialty_id, semester_id, map_id, job_uuid)
        , CONSTRAINT v2u_ko_etapy_osob_j_f6
            FOREIGN KEY (etpos_id)
            REFERENCES v2u_dz_etapy_osob(id)
    );
/
CREATE SEQUENCE v2u_ko_etapy_osob_j_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_etapy_osob_j_tr1
    BEFORE INSERT ON v2u_ko_etapy_osob_j
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_etapy_osob_j_sq1.NEXTVAL INTO :new.id FROM dual;
    END;

-- vim: set ft=sql ts=4 sw=4 et:
