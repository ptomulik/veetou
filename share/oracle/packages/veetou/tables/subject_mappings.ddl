CREATE TABLE veetou_subject_mappings
     ( id NUMBER NOT NULL
     , subj_code VARCHAR(20 CHAR) NOT NULL
     , mapped_subj_code VARCHAR(20 CHAR)
     , matcher_id VARCHAR(128 CHAR)
     , matcher_arg VARCHAR(200 CHAR)
     , CONSTRAINT veetou_subject_mappings_pk PRIMARY KEY(id)
     , CONSTRAINT veetou_subject_mappings_uniq1 UNIQUE
           ( subj_code
           , matcher_id
           , matcher_arg)
     , CONSTRAINT veetou_subject_mappings_fk1
            FOREIGN KEY (matcher_id)
            REFERENCES veetou_subject_matchers(id));

COMMENT ON TABLE veetou_subject_mappings IS 'Odwzorowanie kodów przedmiotów (VEE->USOS)';
COMMENT ON COLUMN veetou_subject_mappings.subj_code IS 'Kod przedmiotu (VEE)';
COMMENT ON COLUMN veetou_subject_mappings.mapped_subj_code IS 'Kod przedmiotu (USOS)';
COMMENT ON COLUMN veetou_subject_mappings.matcher_id IS 'Funkcja wyróżniająca (dla niejednoznacznych odwzorowań)';
COMMENT ON COLUMN veetou_subject_mappings.matcher_arg IS 'Wyróżnik (dla niejednoznacznych odwzorowań)';

CREATE SEQUENCE veetou_subject_mappings_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER veetou_subject_mappings_tr1
    BEFORE INSERT ON veetou_subject_mappings
FOR EACH ROW
BEGIN
    SELECT veetou_subject_mappings_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX veetou_subject_mappings_idx1
     ON veetou_subject_mappings(subj_code);

CREATE INDEX veetou_subject_mappings_idx2
     ON veetou_subject_mappings(mapped_subj_code);

CREATE INDEX veetou_subject_mappings_idx3
     ON veetou_subject_mappings(subj_code, matcher_id);


-- vim: set ft=sql ts=4 sw=4 et:
