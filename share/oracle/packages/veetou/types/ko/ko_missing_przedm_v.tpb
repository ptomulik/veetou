CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Przedm_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , reason => reason
            , tried_map_subj_code => tried_map_subj_code
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , reason IN VARCHAR2
            , tried_map_subj_code IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
            subject => subject
          , specialty => specialty
          , semester => semester
        );
        SELF.reason := reason;
        SELF.tried_map_subj_code := tried_map_subj_code;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
