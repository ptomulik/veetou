CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_Cyklu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tpro_kod VARCHAR2(20 CHAR)
    , uczestnicy VARCHAR2(1 CHAR)
    , url VARCHAR2(500 CHAR)
    , uwagi CLOB
    , notes CLOB
    , literatura CLOB
    , literatura_ang CLOB
    , opis CLOB
    , opis_ang CLOB
    , skrocony_opis VARCHAR2(2000 CHAR)
    , skrocony_opis_ang VARCHAR2(2000 CHAR)
    , status_sylabusu VARCHAR2(1 CHAR)
    , guid VARCHAR2(32 CHAR)


    , CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_Cyklu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Cyklu_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_Cyklu_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
