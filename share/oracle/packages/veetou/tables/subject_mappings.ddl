CREATE TABLE v2u_subject_mappings
OF V2u_Subject_Mapping_t
    ( CONSTRAINT v2u_subject_mappings_pk PRIMARY KEY(id) );

COMMENT ON TABLE v2u_subject_mappings IS 'Odwzorowanie kodów przedmiotów (VEE->USOS)';
COMMENT ON COLUMN v2u_subject_mappings.subj_code IS 'Kod przedmiotu (VEE)';
COMMENT ON COLUMN v2u_subject_mappings.mapped_subj_code IS 'Kod przedmiotu (USOS)';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_name IS 'Wyrażenie zawężające dopuszczalne nazwy przedmiotu';
COMMENT ON COLUMN v2u_subject_mappings.expr_university IS 'Wyrażenie zawężające dopuszczalne nazwy uczelni';
COMMENT ON COLUMN v2u_subject_mappings.expr_faculty IS 'Wyrażenie zawężające dopuszczalne nazwy wydziałów';
COMMENT ON COLUMN v2u_subject_mappings.expr_studies_modetier IS 'Wyrażenie zawężające dopuszczalne tryby/poziomy studiów';
COMMENT ON COLUMN v2u_subject_mappings.expr_studies_field IS 'Wyrażenie zawężające dopuszczalne kierunki studiów';
COMMENT ON COLUMN v2u_subject_mappings.expr_studies_specialty IS 'Wyrażenie zawężajace dopuszczalne specjalności';
COMMENT ON COLUMN v2u_subject_mappings.expr_semester_code IS 'Wyrażenie zawężające dopusczalne semestry prowadzenia przedmiotów';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_hours_w IS 'Wyrażenie zawężające dopuszczalny zakres godzin wykładu';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_hours_c IS 'Wyrażenie zawężające dopuszczalny zakres godzin ćwiczeń';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_hours_l IS 'Wyrażenie zawężające dopuszczalny zakres godzin laboratorium';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_hours_p IS 'Wyrażenie zawężające dopuszczalny zakres godzin projektowych';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_hours_s IS 'Wyrażenie zawężające dopuszczalny zakres godzin seminarium';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_credit_kind IS 'Wyrażenie zawężające dopuszczalne rodzaje zaliczeń';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_ects IS 'Wyrażenie zawężające dopuszczalny zakres ECTS z przedmiotu';
COMMENT ON COLUMN v2u_subject_mappings.expr_subj_tutor IS 'Wyrażenie określające dopuszczalne imię i nazwisko kierownika przedmiotu';

CREATE SEQUENCE v2u_subject_mappings_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_subject_mappings_tr1
    BEFORE INSERT ON v2u_subject_mappings
FOR EACH ROW
BEGIN
    SELECT v2u_subject_mappings_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_subject_mappings_idx1
     ON v2u_subject_mappings(subj_code);

CREATE INDEX v2u_subject_mappings_idx2
     ON v2u_subject_mappings(mapped_subj_code);

-- vim: set ft=sql ts=4 sw=4 et:
