CREATE TABLE v2u_universities
OF V2u_University_t
    (
      CONSTRAINT v2u_universities_pk PRIMARY KEY (id)
    , CONSTRAINT v2u_universities_u1 UNIQUE (abbriev)
    , CONSTRAINT v2u_universities_u2 UNIQUE (name)
    , CONSTRAINT v2u_universities_u3 UNIQUE (abbriev, name)
    , CONSTRAINT v2u_universities_abbriev_chk1 CHECK
        (REGEXP_INSTR(abbriev, '^([a-zA-Z][a-zA-Z0-9_]{0,7})$')=1)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

COMMENT ON TABLE v2u_universities IS 'Uczelnie';
COMMENT ON COLUMN v2u_universities.id IS 'Klucz główny tabeli';
COMMENT ON COLUMN v2u_universities.abbriev IS 'Skrótowa nazwa uczelni';
COMMENT ON COLUMN v2u_universities.name IS 'Nazwa uczelni';

CREATE SEQUENCE v2u_universities_sq1 START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER v2u_universities_tr1
    BEFORE INSERT ON v2u_universities
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_universities_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

INSERT INTO v2u_universities (abbriev, name) VALUES ('PW','POLITECHNIKA WARSZAWSKA');

-- vim: set ft=sql ts=4 sw=4 et:
