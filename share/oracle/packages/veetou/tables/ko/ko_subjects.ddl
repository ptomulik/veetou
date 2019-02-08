CREATE TABLE v2u_ko_subjects
OF V2u_Ko_Subject_t
    (
          CONSTRAINT v2u_ko_subjects_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE tr_ids STORE AS v2u_ko_subject_trs_nt
    ((CONSTRAINT v2u_ko_subject_trs_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
/
CREATE SEQUENCE v2u_ko_subjects_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_subjects_tr1
    BEFORE INSERT ON v2u_ko_subjects
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_subjects_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/
CREATE INDEX v2u_ko_subjects_idx1 ON v2u_ko_subjects(subj_code);

-- vim: set ft=sql ts=4 sw=4 et:
