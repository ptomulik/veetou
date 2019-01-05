CREATE OR REPLACE TYPE V2u_Ko_Matched_Ocena_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_U_t
    ( os_id NUMBER(10)
    , prot_id NUMBER(10)
    , term_prot_nr NUMBER(10)
    , matching_score NUMBER(38)
    , wart_oc_missmatch VARCHAR2(128 CHAR)
    -- DZ_PROTOKOL
    , zaj_cyk_id NUMBER(10)
    , protokol_opis VARCHAR2(100 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_do_sredniej VARCHAR2(1 CHAR)
    , edycja VARCHAR2(1 CHAR)
    , protokol_opis_ang VARCHAR2(100 CHAR)
    -- DZ_TERMIN_PROTOKOLU
    , term_prot_status VARCHAR2(2 CHAR)
    , term_prot_opis VARCHAR2(100 CHAR)
    , data_zwrotu DATE
    , egzamin_komisyjny VARCHAR(1 CHAR)
    -- DZ_OCENA
    , komentarz_pub VARCHAR2(2000 CHAR)
    , komentarz_pryw VARCHAR2(2000 CHAR)
    , toc_kod VARCHAR2(20 CHAR)
    , wart_oc_kolejnosc NUMBER(10)
    , zmiana_os_id NUMBER(10)
    , zmiana_data DATE
    , pos_komi_id NUMBER(10)
    -- DZ_WARTOSC_OCENY
    , wart_oc_opis VARCHAR2(100 CHAR)
    , czy_zal VARCHAR2(1 CHAR)
    , wartosc NUMBER(4,2)
    , wart_oc_description VARCHAR2(100 CHAR)
    , opis_oceny VARCHAR2(100 CHAR)
    , czy_dwoja_reg VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Ocena_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_V_t
            , matched_ocena_j IN V2u_Ko_Matched_Ocena_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , protokol IN V2u_Dz_Protokol_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            , ocena IN V2u_Dz_Ocena_t
            , wartosc_oceny IN V2u_Dz_Wartosc_Oceny_t
            ) RETURN SELF AS RESULT
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
