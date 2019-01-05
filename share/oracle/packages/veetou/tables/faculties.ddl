CREATE TABLE v2u_faculties
OF V2u_Faculty_t
    (
      CONSTRAINT v2u_faculties_pk PRIMARY KEY (id)
    , CONSTRAINT v2u_faculties_u1 UNIQUE (abbriev)
    , CONSTRAINT v2u_faculties_u2 UNIQUE (name)
    , CONSTRAINT v2u_faculties_u3 UNIQUE (code)
    , CONSTRAINT v2u_faculties_abbriev_chk1 CHECK
        (REGEXP_INSTR(abbriev, '^([a-zA-Z][a-zA-Z0-9_]{0,7})$')=1)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
COMMENT ON TABLE v2u_faculties IS 'Wydziały';
COMMENT ON COLUMN v2u_faculties.id IS 'Klucz główny tabeli';
COMMENT ON COLUMN v2u_faculties.abbriev IS 'Skrótowa nazwa wydziału';
COMMENT ON COLUMN v2u_faculties.name IS 'Nazwa wydziału';
COMMENT ON COLUMN v2u_faculties.code IS 'Kod wydziału jako jedn. org.';

CREATE SEQUENCE v2u_faculties_sq1 START WITH 1 INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER v2u_faculties_tr1
    BEFORE INSERT ON v2u_faculties
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_faculties_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

INSERT INTO v2u_faculties (abbriev, name, code)
    VALUES ('MEiL','WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA', '113000');
INSERT INTO v2u_faculties (abbriev, name, code)
    VALUES ('GiK','WYDZIAŁ GEODEZJI I KARTOGRAFII', '106000');

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
