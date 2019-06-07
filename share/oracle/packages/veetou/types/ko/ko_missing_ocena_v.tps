CREATE OR REPLACE TYPE V2u_Ko_Missing_Ocena_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_U_t
    ( os_id NUMBER(10)
    , prot_id NUMBER(10)
    , matching_scores V2u_20Ints_t
    , highest_score NUMBER(38)
    , reason VARCHAR2(128 CHAR)
    -- DZ_PROTOKOL
    , zaj_cyk_id NUMBER(10)
    , protokol_opis VARCHAR2(100 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_do_sredniej VARCHAR2(1 CHAR)
    , edycja VARCHAR2(1 CHAR)
    , protokol_opis_ang VARCHAR2(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Ocena_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Ocena_V_t
            , missing_ocena_j IN V2u_Ko_Missing_Ocena_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , protokol IN V2u_Dz_Protokol_t
            ) RETURN SELF AS RESULT
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
