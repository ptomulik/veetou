CREATE TABLE v2u_ko_students
OF V2u_Ko_Student_t
    (
          CONSTRAINT v2u_ko_students_pk PRIMARY KEY (id, job_uuid)
        , CONSTRAINT v2u_ko_students_u1 UNIQUE (student_index, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE preamble_ids STORE AS v2u_ko_student_preambles_nt
    ((CONSTRAINT v2u_ko_student_preambs_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
/
CREATE SEQUENCE v2u_ko_students_sq1 START WITH 1;
/
CREATE OR REPLACE TRIGGER v2u_ko_students_tr1
    BEFORE INSERT ON v2u_ko_students
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_students_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

CREATE INDEX v2u_ko_students_idx1
     ON v2u_ko_students(student_index);

-- vim: set ft=sql ts=4 sw=4 et:
