CREATE TABLE v2u_faculties
OF V2u_Faculty_t
    (
      CONSTRAINT v2u_faculties_pk PRIMARY KEY (id)
    , CONSTRAINT v2u_faculties_u1 UNIQUE (abbriev)
    , CONSTRAINT v2u_faculties_u2 UNIQUE (name)
    , CONSTRAINT v2u_faculties_u3 UNIQUE (abbriev, name)
    , CONSTRAINT v2u_faculties_abbriev_chk1 CHECK
        (REGEXP_INSTR(abbriev, '^([a-zA-Z][a-zA-Z0-9_]{0,7})$')=1)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

COMMENT ON TABLE v2u_faculties IS 'Wydziały';
COMMENT ON COLUMN v2u_faculties.id IS 'Klucz główny tabeli';
COMMENT ON COLUMN v2u_faculties.abbriev IS 'Skrótowa nazwa wydziału';
COMMENT ON COLUMN v2u_faculties.name IS 'Nazwa wydziału';

CREATE SEQUENCE v2u_faculties_sq1 START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER v2u_faculties_tr1
    BEFORE INSERT ON v2u_faculties
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_faculties_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

INSERT INTO v2u_faculties (abbriev, name) VALUES ('MEiL','WYDZIAŁ MECHANICZNY ENERGETYKI I LOTNICTWA');
INSERT INTO v2u_faculties (abbriev, name) VALUES ('GiK','WYDZIAŁ GEODEZJI I KARTOGRAFII');

-- vim: set ft=sql ts=4 sw=4 et:
