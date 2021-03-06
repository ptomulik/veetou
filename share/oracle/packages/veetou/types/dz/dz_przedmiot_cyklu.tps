CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_Cyklu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Cyklu_t
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , uczestnicy IN VARCHAR2
            , url IN VARCHAR2
            , uwagi IN CLOB
            , notes IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , opis IN CLOB
            , opis_ang IN CLOB
            , skrocony_opis IN VARCHAR2
            , skrocony_opis_ang IN VARCHAR2
            , status_sylabusu IN VARCHAR2
            , guid IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Przedmioty_Cykli_t
    AS TABLE OF V2u_Dz_Przedmiot_Cyklu_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
