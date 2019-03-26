CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Proto_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => classes_type
            , classes_hours => classes_hours
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , classes_map_id => classes_map_id
            , map_classes_type => map_classes_type
            , reason => reason
            , istniejace_tzaj_kody => istniejace_tzaj_kody
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            )
    IS
    BEGIN
        SELF.init(
              subject => subject
            , specialty => specialty
            , semester => semester
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        SELF.subject_map_id := subject_map_id;
        SELF.map_subj_code := map_subj_code;
        SELF.classes_map_id := classes_map_id;
        SELF.map_classes_type := map_classes_type;
        SELF.reason := reason;
        SELF.istniejace_tzaj_kody := istniejace_tzaj_kody;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
