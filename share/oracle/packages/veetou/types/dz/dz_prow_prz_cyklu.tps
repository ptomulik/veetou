CREATE OR REPLACE TYPE V2u_Dz_Prow_Prz_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Prow_Prz_Cyklu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Prow_Prz_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Dz_Prow_Prz_Cyklu_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prac_id IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Prow_Prz_Cykli_t
    AS TABLE OF V2u_Dz_Prow_Prz_Cyklu_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
