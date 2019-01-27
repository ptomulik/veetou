CREATE TABLE v2u_specialty_map
OF V2u_Specialty_Map_t
    ( CONSTRAINT v2u_specialty_map_pk PRIMARY KEY(id) );

COMMENT ON TABLE v2u_specialty_map IS 'Odwzorowanie programów studiów (VEE->USOS)';
COMMENT ON COLUMN v2u_specialty_map.university IS 'Nazwa uczelni (VEE)';
COMMENT ON COLUMN v2u_specialty_map.faculty IS 'Nazwa wydziału (VEE)';
COMMENT ON COLUMN v2u_specialty_map.studies_modetier IS 'Poziom i tryb studiów (VEE)';
COMMENT ON COLUMN v2u_specialty_map.studies_field IS 'Kierunek studiów (VEE)';
COMMENT ON COLUMN v2u_specialty_map.studies_specialty IS 'Specjalność (VEE)';
COMMENT ON COLUMN v2u_specialty_map.mapped_program_code IS 'Wynikowy kod programu studiów (USOS)';
COMMENT ON COLUMN v2u_specialty_map.mapped_modetier_code IS 'Wynikowy kod poziomu i trybu studiów (USOS)';
COMMENT ON COLUMN v2u_specialty_map.mapped_field_code IS 'Wynikowy kod kierunku studiów';
COMMENT ON COLUMN v2u_specialty_map.expr_semester_number IS 'Wyrażenie ograniczające dopuszczalny numer semestru studiów';
COMMENT ON COLUMN v2u_specialty_map.expr_semester_code IS 'Wyrażenie ograniczające dopuszczalny semestr występowania programu';
COMMENT ON COLUMN v2u_specialty_map.expr_ects_mandatory IS 'Wyrażenie określające liczbę wymaganych punktów ECTS';
COMMENT ON COLUMN v2u_specialty_map.expr_ects_other IS 'Wyrażenie określające liczbę pozostałych punktów ECTS';
COMMENT ON COLUMN v2u_specialty_map.expr_ects_total IS 'Wyrażenie określające całkowitą liczbę punktów ECTS';

CREATE SEQUENCE v2u_specialty_map_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_specialty_map_tr1
    BEFORE INSERT ON v2u_specialty_map
FOR EACH ROW
BEGIN
    SELECT v2u_specialty_map_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_specialty_map_idx1
     ON v2u_specialty_map(university, faculty, studies_modetier, studies_field, studies_specialty);
/
CREATE INDEX v2u_specialty_map_idx2
     ON v2u_specialty_map(university, faculty, studies_modetier, studies_field);
/
CREATE INDEX v2u_specialty_map_idx3
     ON v2u_specialty_map(mapped_program_code);

-- vim: set ft=sql ts=4 sw=4 et:
