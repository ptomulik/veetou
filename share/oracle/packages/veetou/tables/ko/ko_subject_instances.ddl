CREATE TABLE v2u_ko_subject_instances
OF V2u_Ko_Subject_Instance_t
    (
          CONSTRAINT v2u_ko_subject_instances_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
VARRAY subj_grades STORE AS LOB (ENABLE STORAGE IN ROW)
NESTED TABLE tr_ids STORE AS v2u_ko_subj_inst_trs_nt;
/
CREATE SEQUENCE v2u_ko_subject_instances_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_subject_instances_tr1
    BEFORE INSERT ON v2u_ko_subject_instances
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_subject_instances_sq1.NEXTVAL INTO :new.id FROM dual;
    END;

-- vim: set ft=sql ts=4 sw=4 et:
