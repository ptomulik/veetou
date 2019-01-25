CREATE OR REPLACE TYPE BODY V2u_Ko_Tr_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Tr_t(
          SELF IN OUT NOCOPY V2u_Ko_Tr_t
        , job_uuid IN RAW
        , id IN NUMBER
        , subj_code IN VARCHAR2 := NULL
        , subj_name IN VARCHAR2 := NULL
        , subj_hours_w IN NUMBER := NULL
        , subj_hours_c IN NUMBER := NULL
        , subj_hours_l IN NUMBER := NULL
        , subj_hours_p IN NUMBER := NULL
        , subj_hours_s IN NUMBER := NULL
        , subj_credit_kind IN VARCHAR2 := NULL
        , subj_ects IN NUMBER := NULL
        , subj_tutor IN VARCHAR2 := NULL
        , subj_grade IN VARCHAR2 := NULL
        , subj_grade_date IN DATE := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.subj_code := subj_code;
        SELF.subj_name := subj_name;
        SELF.subj_hours_w := subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.subj_tutor := subj_tutor;
        SELF.subj_grade := subj_grade;
        SELF.subj_grade_date := subj_grade_date;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
