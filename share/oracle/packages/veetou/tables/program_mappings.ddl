CREATE TABLE veetou_program_mappings
    ( id NUMBER NOT NULL
    , expr_university VARCHAR(256 CHAR)
    , expr_faculty VARCHAR(256 CHAR)
    , expr_studies_modetier VARCHAR(256 CHAR)
    , expr_studies_field VARCHAR(256 CHAR)
    , expr_studies_specialty VARCHAR(256 CHAR)
    , mapped_program_code VARCHAR(32 CHAR)
    , mapped_modetier_code VARCHAR(32 CHAR)
    , mapped_field_code VARCHAR(32 CHAR)

    , CONSTRAINT veetou_program_mappings_pk PRIMARY KEY(id)
    );

COMMENT ON TABLE veetou_program_mappings IS 'Odwzorowanie programów studiów (VEE->USOS)';
COMMENT ON COLUMN veetou_program_mappings.expr_university IS 'Nazwa uczelni (VEE)';
COMMENT ON COLUMN veetou_program_mappings.expr_faculty IS 'Nazwa wydziału (VEE)';
COMMENT ON COLUMN veetou_program_mappings.expr_studies_modetier IS 'Poziom i tryb studiów (VEE)';
COMMENT ON COLUMN veetou_program_mappings.expr_studies_field IS 'Kierunek studiów (VEE)';
COMMENT ON COLUMN veetou_program_mappings.expr_studies_specialty IS 'Specjalność (VEE)';
COMMENT ON COLUMN veetou_program_mappings.mapped_program_code IS 'Wynikowy kod programu studiów (USOS)';
COMMENT ON COLUMN veetou_program_mappings.mapped_modetier_code IS 'Wynikowy kod poziomu i trybu studiów (USOS)';
COMMENT ON COLUMN veetou_program_mappings.mapped_field_code IS 'Wynikowy kod kierunku studiów';

CREATE SEQUENCE veetou_program_mappings_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER veetou_program_mappings_tr1
    BEFORE INSERT ON veetou_program_mappings
FOR EACH ROW
BEGIN
    SELECT veetou_program_mappings_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX veetou_program_mappings_idx1
     ON veetou_program_mappings(expr_faculty,expr_studies_modetier,expr_studies_field,expr_studies_specialty);

CREATE INDEX veetou_program_mappings_idx2
     ON veetou_program_mappings(mapped_program_code);

-- vim: set ft=sql ts=4 sw=4 et:
