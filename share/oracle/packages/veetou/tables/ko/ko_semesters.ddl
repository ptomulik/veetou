CREATE TABLE v2u_ko_semesters
OF V2u_Ko_Semester_t
    (
          CONSTRAINT v2u_ko_semesters_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE sheet_ids STORE AS v2u_ko_semester_sheets_nt
    ((CONSTRAINT v2u_ko_semester_sheets_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
/

CREATE SEQUENCE v2u_ko_semesters_sq1 START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER v2u_ko_semesters_tr1
    BEFORE INSERT ON v2u_ko_semesters
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_semesters_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
