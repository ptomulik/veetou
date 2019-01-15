CREATE OR REPLACE TYPE Veetou_Subject_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER
    , subj_code VARCHAR(20 CHAR)
    , mapped_subj_code VARCHAR(20 CHAR)
    , expr_subj_name VARCHAR(256 CHAR)
    , expr_university VARCHAR(256 CHAR)
    , expr_faculty VARCHAR(256 CHAR)
    , expr_studies_modetier VARCHAR(256 CHAR)
    , expr_studies_field VARCHAR(256 CHAR)
    , expr_studies_specialty VARCHAR(256 CHAR)
    , expr_semester_code VARCHAR(256 CHAR)
    , expr_subj_hours_w VARCHAR(256 CHAR)
    , expr_subj_hours_c VARCHAR(256 CHAR)
    , expr_subj_hours_l VARCHAR(256 CHAR)
    , expr_subj_hours_p VARCHAR(256 CHAR)
    , expr_subj_hours_s VARCHAR(256 CHAR)
    , expr_subj_credit_kind VARCHAR(256 CHAR)
    , expr_subj_ects VARCHAR(256 CHAR)
    , expr_subj_tutor VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Subject_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Subject_Mapping_Typ
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR := NULL
            , mapped_subj_code IN VARCHAR := NULL
            , expr_subj_name IN VARCHAR := NULL
            , expr_university IN VARCHAR := NULL
            , expr_faculty IN VARCHAR := NULL
            , expr_studies_modetier IN VARCHAR := NULL
            , expr_studies_field IN VARCHAR := NULL
            , expr_studies_specialty IN VARCHAR := NULL
            , expr_semester_code IN VARCHAR := NULL
            , expr_subj_hours_w IN VARCHAR := NULL
            , expr_subj_hours_c IN VARCHAR := NULL
            , expr_subj_hours_l IN VARCHAR := NULL
            , expr_subj_hours_p IN VARCHAR := NULL
            , expr_subj_hours_s IN VARCHAR := NULL
            , expr_subj_credit_kind IN VARCHAR := NULL
            , expr_subj_ects IN VARCHAR := NULL
            , expr_subj_tutor IN VARCHAR := NULL
            )
        RETURN SELF AS RESULT


    , MEMBER FUNCTION match_subject(
              SELF IN Veetou_Subject_Mapping_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
      ) RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
              SELF IN Veetou_Subject_Mapping_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_name(
              SELF IN Veetou_Subject_Mapping_Typ
            , subj_name IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_university(
            SELF IN Veetou_Subject_Mapping_Typ
          , university IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_faculty(
            SELF IN Veetou_Subject_Mapping_Typ
          , faculty IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_modetier(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_modetier IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_field(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_field IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_studies_specialty(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_specialty IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(
            SELF IN Veetou_Subject_Mapping_Typ
          , semester_code IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_w(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_w IN VARCHAR
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_c(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_c IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_l(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_l IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_p(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_p IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_hours_s(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_s IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_credit_kind(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_credit_kind IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_ects(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_ects IN INTEGER
      ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_tutor(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_tutor IN VARCHAR
      ) RETURN INTEGER

    );
/
CREATE OR REPLACE TYPE BODY Veetou_Subject_Mapping_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Subject_Mapping_Typ(
          SELF IN OUT NOCOPY Veetou_Subject_Mapping_Typ
        , id IN NUMBER := NULL
        , subj_code IN VARCHAR := NULL
        , mapped_subj_code IN VARCHAR := NULL
        , expr_subj_name IN VARCHAR := NULL
        , expr_university IN VARCHAR := NULL
        , expr_faculty IN VARCHAR := NULL
        , expr_studies_modetier IN VARCHAR := NULL
        , expr_studies_field IN VARCHAR := NULL
        , expr_studies_specialty IN VARCHAR := NULL
        , expr_semester_code IN VARCHAR := NULL
        , expr_subj_hours_w IN VARCHAR := NULL
        , expr_subj_hours_c IN VARCHAR := NULL
        , expr_subj_hours_l IN VARCHAR := NULL
        , expr_subj_hours_p IN VARCHAR := NULL
        , expr_subj_hours_s IN VARCHAR := NULL
        , expr_subj_credit_kind IN VARCHAR := NULL
        , expr_subj_ects IN VARCHAR := NULL
        , expr_subj_tutor IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.subj_code := subj_code;
        SELF.mapped_subj_code := mapped_subj_code;
        SELF.expr_subj_name := expr_subj_name;
        SELF.expr_university := expr_university;
        SELF.expr_faculty := expr_faculty;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.expr_studies_field := expr_studies_field;
        SELF.expr_studies_specialty := expr_studies_specialty;
        SELF.expr_semester_code := expr_semester_code;
        SELF.expr_subj_hours_w := expr_subj_hours_w;
        SELF.expr_subj_hours_c := expr_subj_hours_c;
        SELF.expr_subj_hours_l := expr_subj_hours_l;
        SELF.expr_subj_hours_p := expr_subj_hours_p;
        SELF.expr_subj_hours_s := expr_subj_hours_s;
        SELF.expr_subj_credit_kind := expr_subj_credit_kind;
        SELF.expr_subj_ects := expr_subj_ects;
        SELF.expr_subj_tutor := expr_subj_tutor;
        RETURN;
    END;

    MEMBER FUNCTION match_subject(
              SELF IN Veetou_Subject_Mapping_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
        ) RETURN INTEGER
    IS
    BEGIN
        IF SELF.subj_code != subject.subj_code THEN
            RETURN 0;
        ELSE
            RETURN 1 + SELF.match_expr_fields(subject);
        END IF;
    END;

    MEMBER FUNCTION match_expr_fields(
            SELF IN Veetou_Subject_Mapping_Typ,
            subject IN Veetou_Ko_Subject_Instance_Typ
        ) RETURN INTEGER
    IS
        score NUMBER;
    BEGIN
        score := 0;
        IF SELF.expr_subj_name IS NOT NULL THEN
            IF 0 = SELF.match_subj_name(subject.subj_name) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_university IS NOT NULL THEN
            IF 0 = SELF.match_university(subject.university) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_faculty IS NOT NULL THEN
            IF 0 = SELF.match_faculty(subject.faculty) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_studies_modetier IS NOT NULL THEN
            IF 0 = SELF.match_studies_modetier(subject.studies_modetier) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_studies_field IS NOT NULL THEN
            IF 0 = SELF.match_studies_field(subject.studies_field) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_studies_specialty IS NOT NULL THEN
            IF 0 = SELF.match_studies_specialty(subject.studies_specialty) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_semester_code IS NOT NULL THEN
            IF 0 = SELF.match_semester_code(subject.semester_code) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_hours_w IS NOT NULL THEN
            IF 0 = SELF.match_subj_hours_w(subject.subj_hours_w) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_hours_c IS NOT NULL THEN
            IF 0 = SELF.match_subj_hours_c(subject.subj_hours_c) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_hours_l IS NOT NULL THEN
            IF 0 = SELF.match_subj_hours_l(subject.subj_hours_l) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_hours_p IS NOT NULL THEN
            IF 0 = SELF.match_subj_hours_p(subject.subj_hours_p) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_hours_s IS NOT NULL THEN
            IF 0 = SELF.match_subj_hours_s(subject.subj_hours_s) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_credit_kind IS NOT NULL THEN
            IF 0 = SELF.match_subj_credit_kind(subject.subj_credit_kind) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_ects IS NOT NULL THEN
            IF 0 = SELF.match_subj_ects(subject.subj_ects) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF SELF.expr_subj_tutor IS NOT NULL THEN
            IF 0 = SELF.match_subj_tutor(subject.subj_tutor) THEN
                RETURN 0;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        RETURN 1;
    END;


    MEMBER FUNCTION match_subj_name(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_name IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_subj_name, subj_name);
    END;


    MEMBER FUNCTION match_university(
            SELF IN Veetou_Subject_Mapping_Typ
          , university IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_university, university);
    END;


    MEMBER FUNCTION match_faculty(
            SELF IN Veetou_Subject_Mapping_Typ
          , faculty IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_faculty, faculty);
    END;


    MEMBER FUNCTION match_studies_modetier(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_modetier IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_studies_modetier, studies_modetier);
    END;


    MEMBER FUNCTION match_studies_field(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_field IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_studies_field, studies_field);
    END;


    MEMBER FUNCTION match_studies_specialty(
            SELF IN Veetou_Subject_Mapping_Typ
          , studies_specialty IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_studies_specialty, studies_specialty);
    END;


    MEMBER FUNCTION match_semester_code(
            SELF IN Veetou_Subject_Mapping_Typ
          , semester_code IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Range(SELF.expr_semester_code, semester_code);
    END;


    MEMBER FUNCTION match_subj_hours_w(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_w IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_hours_w, subj_hours_w);
    END;


    MEMBER FUNCTION match_subj_hours_c(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_c IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_hours_c, subj_hours_c);
    END;


    MEMBER FUNCTION match_subj_hours_l(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_l IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_hours_l, subj_hours_l);
    END;


    MEMBER FUNCTION match_subj_hours_p(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_p IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_hours_p, subj_hours_p);
    END;


    MEMBER FUNCTION match_subj_hours_s(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_hours_s IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_hours_s, subj_hours_s);
    END;


    MEMBER FUNCTION match_subj_credit_kind(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_credit_kind IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Like(SELF.expr_subj_credit_kind, subj_credit_kind);
    END;


    MEMBER FUNCTION match_subj_ects(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_ects IN INTEGER
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Number_Range(SELF.expr_subj_ects, subj_ects);
    END;


    MEMBER FUNCTION match_subj_tutor(
            SELF IN Veetou_Subject_Mapping_Typ
          , subj_tutor IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.Person_Name(SELF.expr_subj_tutor, subj_tutor);
    END;


END;
-- vim: set ft=sql ts=4 sw=4 et:
