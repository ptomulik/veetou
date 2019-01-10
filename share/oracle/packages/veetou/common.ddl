--
-- DATA TABLES
--

CREATE TABLE veetou_subject_matchers
     ( id VARCHAR(128 CHAR) NOT NULL
     , description VARCHAR(1024 CHAR)
     , CONSTRAINT veetou_subject_matchers_u1 UNIQUE (id));


CREATE TABLE veetou_subject_mappings
     ( id NUMBER NOT NULL
     , subj_code VARCHAR(20 CHAR) NOT NULL
     , mapped_subj_code VARCHAR(20 CHAR)
     , matcher_id VARCHAR(128 CHAR)
     , matcher_arg VARCHAR(200 CHAR)
     , CONSTRAINT veetou_subject_mappings_uniq1 UNIQUE
       (
         subj_code
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


--
-- JUNCTION TABLES
--


--
-- VIEWS
--


--
-- INDEXES
--

CREATE INDEX veetou_subject_mappings_idx1
     ON veetou_subject_mappings(subj_code);

CREATE INDEX veetou_subject_mappings_idx2
     ON veetou_subject_mappings(mapped_subj_code);

CREATE INDEX veetou_subject_mappings_idx3
     ON veetou_subject_mappings(subj_code, matcher_id);


-- vim: ft=sql ts=4 sw=4 et:
