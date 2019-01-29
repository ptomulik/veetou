CREATE TABLE v2u_ko_specialty_entities
OF V2u_Ko_Specialty_Entity_t
    (
          CONSTRAINT v2u_ko_specialty_entities_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE sheet_ids STORE AS v2u_ko_specialty_sheets_nt
    ((CONSTRAINT v2u_ko_specialty_sheets_nt_pk PRIMARY KEY (NESTED_TABLE_ID, COLUMN_VALUE)));
/

CREATE SEQUENCE v2u_ko_specialty_entities_sq1 START WITH 1 INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER v2u_ko_specialty_entities_tr1
    BEFORE INSERT ON v2u_ko_specialty_entities
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_specialty_entities_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

CREATE INDEX v2u_ko_specialty_entities_idx1
     ON v2u_ko_specialty_entities(university, faculty, studies_modetier, studies_field, studies_specialty);
/
CREATE INDEX v2u_ko_specialty_entities_idx2
     ON v2u_ko_specialty_entities(university, faculty, studies_modetier, studies_field);
-- vim: set ft=sql ts=4 sw=4 et: