CREATE OR REPLACE TYPE V2u_Dz_Student_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Student_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Student_t(
              SELF IN OUT NOCOPY V2u_Dz_Student_t
            , id NUMBER
            , indeks VARCHAR2
            , jed_org_kod VARCHAR2
            , typ_ind_kod VARCHAR2
            , utw_id VARCHAR2
            , utw_data DATE
            , mod_id VARCHAR2
            , mod_data DATE
            , os_id NUMBER
            , indeks_glowny VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Studenci_t
    AS TABLE OF V2u_Dz_Student_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
