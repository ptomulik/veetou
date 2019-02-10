CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Zajcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            , tried_map_classes_type IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , reason => reason
            , tried_map_subj_code => tried_map_subj_code
            , tried_map_classes_type => tried_map_classes_type
            , istniejace_tzaj_kody => istniejace_tzaj_kody
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            , tried_map_classes_type IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            )
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
          , reason => reason
          , tried_map_subj_code => tried_map_subj_code
        );
        SELF.tried_map_classes_type := tried_map_classes_type;
        SELF.istniejace_tzaj_kody := istniejace_tzaj_kody;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
