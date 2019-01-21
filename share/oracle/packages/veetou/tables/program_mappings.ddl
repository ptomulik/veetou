CREATE TABLE v2u_program_mappings
    ( id NUMBER NOT NULL
    , university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , studies_specialty VARCHAR(256 CHAR)
    , mapped_program_code VARCHAR(32 CHAR)
    , mapped_modetier_code VARCHAR(32 CHAR)
    , mapped_field_code VARCHAR(32 CHAR)
    , expr_semester_code VARCHAR(256 CHAR)

    , CONSTRAINT v2u_program_mappings_pk PRIMARY KEY(id)
    );

COMMENT ON TABLE v2u_program_mappings IS 'Odwzorowanie programów studiów (VEE->USOS)';
COMMENT ON COLUMN v2u_program_mappings.university IS 'Nazwa uczelni (VEE)';
COMMENT ON COLUMN v2u_program_mappings.faculty IS 'Nazwa wydziału (VEE)';
COMMENT ON COLUMN v2u_program_mappings.studies_modetier IS 'Poziom i tryb studiów (VEE)';
COMMENT ON COLUMN v2u_program_mappings.studies_field IS 'Kierunek studiów (VEE)';
COMMENT ON COLUMN v2u_program_mappings.studies_specialty IS 'Specjalność (VEE)';
COMMENT ON COLUMN v2u_program_mappings.mapped_program_code IS 'Wynikowy kod programu studiów (USOS)';
COMMENT ON COLUMN v2u_program_mappings.mapped_modetier_code IS 'Wynikowy kod poziomu i trybu studiów (USOS)';
COMMENT ON COLUMN v2u_program_mappings.mapped_field_code IS 'Wynikowy kod kierunku studiów';
COMMENT ON COLUMN v2u_program_mappings.expr_semester_code IS 'Wyrażenie ograniczające dopuszczalny semestr występowania programu';

CREATE SEQUENCE v2u_program_mappings_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_program_mappings_tr1
    BEFORE INSERT ON v2u_program_mappings
FOR EACH ROW
BEGIN
    SELECT v2u_program_mappings_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_program_mappings_idx1
     ON v2u_program_mappings(faculty, studies_modetier, studies_field, studies_specialty);

CREATE INDEX v2u_program_mappings_idx2
     ON v2u_program_mappings(mapped_program_code);

-- vim: set ft=sql ts=4 sw=4 et:
