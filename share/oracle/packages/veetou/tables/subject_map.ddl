CREATE TABLE v2u_subject_map
OF V2u_Subject_Map_t
    ( CONSTRAINT v2u_subject_map_pk PRIMARY KEY(id) )
OBJECT IDENTIFIER IS PRIMARY KEY;

COMMENT ON TABLE v2u_subject_map IS 'Odwzorowanie kodów przedmiotów (VEE->USOS)';
COMMENT ON COLUMN v2u_subject_map.subj_code IS 'Kod przedmiotu (VEE)';
COMMENT ON COLUMN v2u_subject_map.map_subj_code IS 'Kod przedmiotu (USOS)';
COMMENT ON COLUMN v2u_subject_map.expr_subj_name IS 'Wyrażenie określające dopuszczalne nazwy przedmiotu';
COMMENT ON COLUMN v2u_subject_map.expr_university IS 'Wyrażenie określające dopuszczalne nazwy uczelni';
COMMENT ON COLUMN v2u_subject_map.expr_faculty IS 'Wyrażenie określające dopuszczalne nazwy wydziałów';
COMMENT ON COLUMN v2u_subject_map.expr_studies_modetier IS 'Wyrażenie określające dopuszczalne tryby/poziomy studiów';
COMMENT ON COLUMN v2u_subject_map.expr_studies_field IS 'Wyrażenie określające dopuszczalne kierunki studiów';
COMMENT ON COLUMN v2u_subject_map.expr_studies_specialty IS 'Wyrażenie zawężajace dopuszczalne specjalności';
COMMENT ON COLUMN v2u_subject_map.expr_semester_code IS 'Wyrażenie określające dopusczalne semestry prowadzenia przedmiotów';
COMMENT ON COLUMN v2u_subject_map.expr_subj_hours_w IS 'Wyrażenie określające dopuszczalny zakres godzin wykładu';
COMMENT ON COLUMN v2u_subject_map.expr_subj_hours_c IS 'Wyrażenie określające dopuszczalny zakres godzin ćwiczeń';
COMMENT ON COLUMN v2u_subject_map.expr_subj_hours_l IS 'Wyrażenie określające dopuszczalny zakres godzin laboratorium';
COMMENT ON COLUMN v2u_subject_map.expr_subj_hours_p IS 'Wyrażenie określające dopuszczalny zakres godzin projektowych';
COMMENT ON COLUMN v2u_subject_map.expr_subj_hours_s IS 'Wyrażenie określające dopuszczalny zakres godzin seminarium';
COMMENT ON COLUMN v2u_subject_map.expr_subj_credit_kind IS 'Wyrażenie określające dopuszczalne rodzaje zaliczeń';
COMMENT ON COLUMN v2u_subject_map.expr_subj_ects IS 'Wyrażenie określające dopuszczalny zakres ECTS z przedmiotu';
COMMENT ON COLUMN v2u_subject_map.expr_subj_tutor IS 'Wyrażenie określające dopuszczalne imię i nazwisko kierownika przedmiotu';

CREATE SEQUENCE v2u_subject_map_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_subject_map_tr1
    BEFORE INSERT ON v2u_subject_map
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
    SELECT v2u_subject_map_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_subject_map_idx1
     ON v2u_subject_map(subj_code);

CREATE INDEX v2u_subject_map_idx2
     ON v2u_subject_map(map_subj_code);

-- vim: set ft=sql ts=4 sw=4 et:
