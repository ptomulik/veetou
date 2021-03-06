CREATE TABLE v2u_protocol_map
OF V2u_Protocol_Map_t
    ( CONSTRAINT v2u_protocol_map_pk
        PRIMARY KEY(id)
    , CONSTRAINT v2u_protocol_map_c1           -- how map_return_date is cmp'd:
        CHECK(map_return_date_prec IN   ( '--' -- do not truncate dates
                                        , 'YY' -- truncate dates to year
                                        , 'MM' -- truncate dates to months
                                        , 'DD' -- truncate dates to days
                                        , 'HH' -- truncate dates to hours
                                        , 'MI' -- truncate dates to minutes
                                        , 'XX' -- exact match with NULL = NULL.
                                        )
        )
    , CONSTRAINT v2u_protocol_map_c2
        CHECK(map_classes_type      IN  ( 'WYK'
                                        , 'CWI'
                                        , 'LAB'
                                        , 'PRO'
                                        , 'SED'
                                        , 'LEK'
                                        , 'FIZ'
                                        , 'DOM'
                                        , 'PRA'
                                        , 'EGZ'
                                        , 'SEM'
                                        , 'KON'
                                        , 'ZKO'
                                        , 'PPR'
                                        , 'ZIN'
                                        , '-'
                                        )
        )
    , map_return_date_prec DEFAULT '--'
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
--COMMENT ON TABLE v2u_protocol_map IS 'Odwzorowanie kodów przedmiotów (wydział -> USOS)';
--COMMENT ON COLUMN v2u_protocol_map.id IS 'Indeks główny tabeli (generowany automatycznie)';
--COMMENT ON COLUMN v2u_protocol_map.subj_code IS 'Wydziałowy kod przedmiotu';
--COMMENT ON COLUMN v2u_protocol_map.usr_subj_name IS 'Wydziałoa nazwa przedmiotu, kolumna pomocnicza dla użytkownika';
--COMMENT ON COLUMN v2u_protocol_map.map_subj_code IS 'Kod przedmiotu dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_subj_name IS 'Nazwa przedmiotu dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_subj_lang IS 'Język prowadzenia przedmiotu dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_org_unit IS 'Kod jednostki organizacyjnej (dawca) dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_org_unit_recipient IS 'Kod jednostki organizacyjnej (biorca) dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_proto_type IS 'Typ protokołu zaliczeniowego dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.map_grade_type IS 'Typ skali ocen dla USOS';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_name IS 'Wyrażenie określające dopuszczalne nazwy przedmiotu';
--COMMENT ON COLUMN v2u_protocol_map.expr_university IS 'Wyrażenie określające dopuszczalne nazwy uczelni';
--COMMENT ON COLUMN v2u_protocol_map.expr_faculty IS 'Wyrażenie określające dopuszczalne nazwy wydziałów';
--COMMENT ON COLUMN v2u_protocol_map.expr_studies_modetier IS 'Wyrażenie określające dopuszczalne tryby/poziomy studiów';
--COMMENT ON COLUMN v2u_protocol_map.expr_studies_field IS 'Wyrażenie określające dopuszczalne kierunki studiów';
--COMMENT ON COLUMN v2u_protocol_map.expr_studies_specialty IS 'Wyrażenie zawężajace dopuszczalne specjalności';
--COMMENT ON COLUMN v2u_protocol_map.expr_semester_code IS 'Wyrażenie określające dopusczalne semestry prowadzenia przedmiotów';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_hours_w IS 'Wyrażenie określające dopuszczalny zakres godzin wykładu';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_hours_c IS 'Wyrażenie określające dopuszczalny zakres godzin ćwiczeń';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_hours_l IS 'Wyrażenie określające dopuszczalny zakres godzin laboratorium';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_hours_p IS 'Wyrażenie określające dopuszczalny zakres godzin projektowych';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_hours_s IS 'Wyrażenie określające dopuszczalny zakres godzin seminarium';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_credit_kind IS 'Wyrażenie określające dopuszczalne rodzaje zaliczeń';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_ects IS 'Wyrażenie określające dopuszczalny zakres ECTS z przedmiotu';
--COMMENT ON COLUMN v2u_protocol_map.expr_subj_tutor IS 'Wyrażenie określające dopuszczalne imię i nazwisko kierownika przedmiotu';

CREATE SEQUENCE v2u_protocol_map_sq1 START WITH 1;
/

CREATE OR REPLACE TRIGGER v2u_protocol_map_tr1
    BEFORE INSERT ON v2u_protocol_map
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
    SELECT v2u_protocol_map_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

--
-- INDEXES
--

CREATE INDEX v2u_protocol_map_idx1
     ON v2u_protocol_map(semester_code);
/
-- vim: set ft=sql ts=4 sw=4 et:
