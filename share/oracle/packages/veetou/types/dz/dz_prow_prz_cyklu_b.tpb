CREATE OR REPLACE TYPE BODY V2u_Dz_Prow_Prz_Cyklu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Prow_Prz_Cyklu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Prow_Prz_Cyklu_B_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prac_id IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , prac_id => prac_id
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Prow_Prz_Cyklu_B_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prac_id IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
        )
    IS
    BEGIN
        SELF.id := id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.prac_id := prac_id;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
