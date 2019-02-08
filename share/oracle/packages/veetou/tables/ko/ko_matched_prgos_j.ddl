CREATE TABLE v2u_ko_matched_prgos_j
    (
          id NUMBER(38)
        , job_uuid RAW(16)
        , student_id NUMBER(38)
        , specialty_id NUMBER(38)
        , prgos_id NUMBER(10)
        , semester_ids V2u_Ids_t

        , CONSTRAINT v2u_ko_matched_prgos_j_pk
            PRIMARY KEY (id)
        , CONSTRAINT v2u_ko_matched_prgos_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_prgos_j_f1
            FOREIGN KEY (student_id, job_uuid)
            REFERENCES v2u_ko_students(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_prgos_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_prgos_j_f3
            FOREIGN KEY (prgos_id)
            REFERENCES v2u_dz_programy_osob(id)
        , CONSTRAINT v2u_ko_matched_prgos_j_u0
            UNIQUE (job_uuid, student_id, specialty_id, prgos_id)
    )
NESTED TABLE semester_ids STORE AS v2u_ko_prgos_semesters_nt
    ((CONSTRAINT v2u_ko_prgos_semesters_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
    ;
/
CREATE SEQUENCE v2u_ko_matched_prgos_j_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_matched_prgos_j_tr1
    BEFORE INSERT ON v2u_ko_matched_prgos_j
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_matched_prgos_j_sq1.NEXTVAL INTO :new.id FROM dual;
    END;

-- vim: set ft=sql ts=4 sw=4 et:
