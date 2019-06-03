CREATE TABLE v2u_pp_grupy_zajec_1
    (
          id NUMBER(38)
        , zaklad VARCHAR2(20 CHAR)
        , kod_verbis VARCHAR2(32 CHAR)
        , kod_usos VARCHAR2(20 CHAR)
        , nazwa VARCHAR2(200 CHAR)
        , grupa NUMBER(38)
        , forma VARCHAR2(1 CHAR)
        , czestotliwosc VARCHAR2(32 CHAR)
        , dzien VARCHAR2(20 CHAR)
        , godzina_od VARCHAR2(20 CHAR)
        , godzina_do VARCHAR2(20 CHAR)
        , sala VARCHAR2(32 CHAR)
        , koord_nazwisko VARCHAR2(64 CHAR)
        , koord_imie VARCHAR2(64 CHAR)
        , koord_jed_org VARCHAR2(20 CHAR)
        , koord_prac_id NUMBER(10)
        , koord_os_id NUMBER(10)
        , koord_pesel VARCHAR2(11 CHAR)
        , prow_nazwisko VARCHAR2(64 CHAR)
        , prow_imie VARCHAR2(64 CHAR)
        , prow_jed_org VARCHAR2(20 CHAR)
        , prow_prac_id NUMBER(10)
        , prow_os_id NUMBER(10)
        , prow_pesel VARCHAR2(11 CHAR)
        , studenci VARCHAR2(10 CHAR)
        , prowadzacy_kolejni VARCHAR2(200 CHAR)
        , uwagi VARCHAR2(2048 CHAR)
        , daty_spotkan VARCHAR2(2048 CHAR)

        -- PK
        , CONSTRAINT v2u_pp_grupy_zajec_1_pk
            PRIMARY KEY (id)
    )
;
/
CREATE SEQUENCE v2u_pp_grupy_zajec_1_sq1
    START WITH 1
    INCREMENT BY 1;
/
CREATE OR REPLACE TRIGGER v2u_pp_grupy_zajec_1_tr1
    BEFORE INSERT ON v2u_pp_grupy_zajec_1
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_pp_grupy_zajec_1_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/
CREATE TABLE v2u_pp_grupy_zajec_1_koord_j
    (
          id NUMBER(38)
        , koord_pesel VARCHAR2(11 CHAR)
        , koord_prac_id NUMBER(10)
        , koord_os_id NUMBER(10)

        -- PK
        , CONSTRAINT v2u_pp_grupy_zajec_1_k_j_pk
            PRIMARY KEY (id)
    )
;
CREATE TABLE v2u_pp_grupy_zajec_1_prow_j
    (
          id NUMBER(38)
        , prow_pesel VARCHAR2(11 CHAR)
        , prow_prac_id NUMBER(10)
        , prow_os_id NUMBER(10)

        -- PK
        , CONSTRAINT v2u_pp_grupy_zajec_1_p_j_pk
            PRIMARY KEY (id)
    )
;
-- vim: set ft=sql ts=4 sw=4 et:
