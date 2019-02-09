CREATE TABLE v2u_classes_map
OF V2u_Classes_Map_t
    ( CONSTRAINT v2u_classes_map_pk PRIMARY KEY(id) );

COMMENT ON TABLE v2u_classes_map IS 'Odwzorowanie typow zajec (VEE->USOS)';
COMMENT ON COLUMN v2u_classes_map.id IS 'Klucz główny tabeli';
COMMENT ON COLUMN v2u_classes_map.classes_type IS 'Źródłowy kod typu zajęć (VEE)';
COMMENT ON COLUMN v2u_classes_map.map_classes_type IS 'Docelowy kod typu zajęć (USOS)';
COMMENT ON COLUMN v2u_classes_map.expr_subj_code IS 'Wyrażenie określające dopuszczalne kody przedmiotu';
COMMENT ON COLUMN v2u_classes_map.expr_subj_name IS 'Wyrażenie określające dopuszczalne nazwy przedmiotu';
COMMENT ON COLUMN v2u_classes_map.expr_university IS 'Wyrażenie określające dopuszczalne nazwy uczelni';
COMMENT ON COLUMN v2u_classes_map.expr_faculty IS 'Wyrażenie określające dopuszczalne nazwy wydziałów';
COMMENT ON COLUMN v2u_classes_map.expr_studies_modetier IS 'Wyrażenie określające dopuszczalne tryby/poziomy studiów';
COMMENT ON COLUMN v2u_classes_map.expr_studies_field IS 'Wyrażenie określające dopuszczalne kierunki studiów';
COMMENT ON COLUMN v2u_classes_map.expr_studies_specialty IS 'Wyrażenie zawężajace dopuszczalne specjalności';
COMMENT ON COLUMN v2u_classes_map.expr_semester_code IS 'Wyrażenie określające dopusczalne semestry prowadzenia przedmiotów';
COMMENT ON COLUMN v2u_classes_map.expr_subj_hours_w IS 'Wyrażenie określające dopuszczalny zakres godzin wykładu';
COMMENT ON COLUMN v2u_classes_map.expr_subj_hours_c IS 'Wyrażenie określające dopuszczalny zakres godzin ćwiczeń';
COMMENT ON COLUMN v2u_classes_map.expr_subj_hours_l IS 'Wyrażenie określające dopuszczalny zakres godzin laboratorium';
COMMENT ON COLUMN v2u_classes_map.expr_subj_hours_p IS 'Wyrażenie określające dopuszczalny zakres godzin projektowych';
COMMENT ON COLUMN v2u_classes_map.expr_subj_hours_s IS 'Wyrażenie określające dopuszczalny zakres godzin seminarium';
COMMENT ON COLUMN v2u_classes_map.expr_subj_credit_kind IS 'Wyrażenie określające dopuszczalne rodzaje zaliczeń';
COMMENT ON COLUMN v2u_classes_map.expr_subj_ects IS 'Wyrażenie określające dopuszczalny zakres ECTS z przedmiotu';
COMMENT ON COLUMN v2u_classes_map.expr_subj_tutor IS 'Wyrażenie określające dopuszczalne imię i nazwisko kierownika przedmiotu';

CREATE SEQUENCE v2u_classes_map_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_classes_map_tr1
    BEFORE INSERT ON v2u_classes_map
FOR EACH ROW
BEGIN
    SELECT v2u_classes_map_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_classes_map_idx1
     ON v2u_classes_map(classes_type);

CREATE INDEX v2u_classes_map_idx2
     ON v2u_classes_map(map_classes_type);

-- vim: set ft=sql ts=4 sw=4 et:
