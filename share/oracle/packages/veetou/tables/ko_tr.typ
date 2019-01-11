CREATE OR REPLACE TYPE Veetou_Ko_Tr_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , subj_code VARCHAR(32 CHAR)
    , subj_name VARCHAR(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR(16 CHAR)
    , subj_ects NUMBER(16)
    , subj_tutor VARCHAR(256 CHAR)
    , subj_grade VARCHAR(32 CHAR)
    , subj_grade_date DATE

    , CONSTRUCTOR FUNCTION Veetou_Ko_Tr_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Tr_Typ
            , job_uuid IN RAW := NULL
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR := NULL
            , subj_name IN VARCHAR := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR := NULL
            , subj_grade IN VARCHAR := NULL
            , subj_grade_date IN DATE := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Tr_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Tr_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Tr_Typ
        , job_uuid IN RAW := NULL
        , id IN NUMBER := NULL
        , subj_code IN VARCHAR := NULL
        , subj_name IN VARCHAR := NULL
        , subj_hours_w IN NUMBER := NULL
        , subj_hours_c IN NUMBER := NULL
        , subj_hours_l IN NUMBER := NULL
        , subj_hours_p IN NUMBER := NULL
        , subj_hours_s IN NUMBER := NULL
        , subj_credit_kind IN VARCHAR := NULL
        , subj_ects IN NUMBER := NULL
        , subj_tutor IN VARCHAR := NULL
        , subj_grade IN VARCHAR := NULL
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
END;
-- vim: set ft=sql ts=4 sw=4 et:
