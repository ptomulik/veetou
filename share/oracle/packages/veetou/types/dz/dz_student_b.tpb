CREATE OR REPLACE TYPE BODY V2u_Dz_Student_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Student_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Student_B_t
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
    IS
    BEGIN
        SELF.init(
              id => id
            , indeks => indeks
            , jed_org_kod => jed_org_kod
            , typ_ind_kod => typ_ind_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , os_id => os_id
            , indeks_glowny => indeks_glowny
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Student_B_t
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
            )
    IS
    BEGIN
        SELF.id := id;
        SELF.indeks := indeks;
        SELF.jed_org_kod := jed_org_kod;
        SELF.typ_ind_kod := typ_ind_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.os_id := os_id;
        SELF.indeks_glowny := indeks_glowny;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
