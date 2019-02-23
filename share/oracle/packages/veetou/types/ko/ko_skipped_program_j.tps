CREATE OR REPLACE TYPE V2u_Ko_Skipped_Program_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Specialty_Semester_J_t
    ( prg_kod VARCHAR2(20 CHAR)
    , where_tryb_studiow VARCHAR2(100 CHAR)
    , where_rodzaj_studiow VARCHAR2(100 CHAR)
    , where_jed_org_kod_podst VARCHAR2(32 CHAR)
    , where_opis_like VARCHAR(200 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , prg_kod IN VARCHAR2
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            ) RETURN SELF AS RESULT

--    , CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_J_t(
--              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , prg_kod IN VARCHAR2
--            , where_tryb_studiow IN VARCHAR2
--            , where_rodzaj_studiow IN VARCHAR2
--            , where_jed_org_kod_podst IN VARCHAR2
--            , where_opis_like IN VARCHAR2
--            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , prg_kod IN VARCHAR2
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            )

--    , MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , prg_kod IN VARCHAR2
--            , where_tryb_studiow IN VARCHAR2
--            , where_rodzaj_studiow IN VARCHAR2
--            , where_jed_org_kod_podst IN VARCHAR2
--            , where_opis_like IN VARCHAR2
--            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Skipped_Programs_J_t
    AS TABLE OF V2u_Ko_Skipped_Program_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
