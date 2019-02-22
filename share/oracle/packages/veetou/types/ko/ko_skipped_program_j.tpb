CREATE OR REPLACE TYPE BODY V2u_Ko_Skipped_Program_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_J_t(
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
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , prg_kod => prg_kod
            , where_tryb_studiow => where_tryb_studiow
            , where_rodzaj_studiow => where_rodzaj_studiow
            , where_jed_org_kod_podst => where_jed_org_kod_podst
            , where_opis_like => where_opis_like
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , prg_kod IN VARCHAR2
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , prg_kod => prg_kod
            , where_tryb_studiow => where_tryb_studiow
            , where_rodzaj_studiow => where_rodzaj_studiow
            , where_jed_org_kod_podst => where_jed_org_kod_podst
            , where_opis_like => where_opis_like
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            );
        SELF.prg_kod := prg_kod;
        SELF.where_tryb_studiow := where_tryb_studiow;
        SELF.where_rodzaj_studiow := where_rodzaj_studiow;
        SELF.where_jed_org_kod_podst := where_jed_org_kod_podst;
        SELF.where_opis_like := where_opis_like;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , prg_kod IN VARCHAR2
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            );
        SELF.prg_kod := prg_kod;
        SELF.where_tryb_studiow := where_tryb_studiow;
        SELF.where_rodzaj_studiow := where_rodzaj_studiow;
        SELF.where_jed_org_kod_podst := where_jed_org_kod_podst;
        SELF.where_opis_like := where_opis_like;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
