CREATE SEQUENCE v2u_ko_students_sq1 START WITH 1;
/
CREATE TABLE v2u_ko_students
OF V2u_Ko_Student_t
    (
          CONSTRAINT v2u_ko_students_pk PRIMARY KEY (id, job_uuid)
        , CONSTRAINT v2u_ko_students_u1 UNIQUE (student_index, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE preamble_ids STORE AS v2u_ko_students_c1_nt
AS WITH u AS
    (
        SELECT
              job_uuid
            , student_index
            , student_name
            , first_name
            , last_name
            , CAST(COLLECT(p.id) AS V2u_Ko_Ids_t) preamble_ids
        FROM v2u_ko_preambles p
        GROUP BY student_index, student_name, first_name, last_name, job_uuid
        ORDER BY student_index, student_name, first_name, last_name, job_uuid
    )
SELECT
      job_uuid
    , (SELECT v2u_ko_students_sq1.NEXTVAL FROM dual)
    , student_index
    , student_name
    , first_name
    , last_name
    , preamble_ids
FROM u;

CREATE OR REPLACE TRIGGER v2u_ko_students_tr1
    BEFORE INSERT ON v2u_ko_students
FOR EACH ROW
BEGIN
    SELECT v2u_ko_students_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

CREATE INDEX v2u_ko_students_idx1
     ON v2u_ko_students(student_index);

-- vim: set ft=sql ts=4 sw=4 et:
