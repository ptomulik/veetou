CREATE OR REPLACE TYPE BODY V2u_Subject_Mapping_t AS
    CONSTRUCTOR FUNCTION V2u_Subject_Mapping_t(
          SELF IN OUT NOCOPY V2u_Subject_Mapping_t
        , id IN NUMBER
        , subj_code IN VARCHAR2 := NULL
        , mapped_subj_code IN VARCHAR2 := NULL
        , expr_subj_name IN VARCHAR2 := NULL
        , expr_university IN VARCHAR2 := NULL
        , expr_faculty IN VARCHAR2 := NULL
        , expr_studies_modetier IN VARCHAR2 := NULL
        , expr_studies_field IN VARCHAR2 := NULL
        , expr_studies_specialty IN VARCHAR2 := NULL
        , expr_semester_code IN VARCHAR2 := NULL
        , expr_subj_hours_w IN VARCHAR2 := NULL
        , expr_subj_hours_c IN VARCHAR2 := NULL
        , expr_subj_hours_l IN VARCHAR2 := NULL
        , expr_subj_hours_p IN VARCHAR2 := NULL
        , expr_subj_hours_s IN VARCHAR2 := NULL
        , expr_subj_credit_kind IN VARCHAR2 := NULL
        , expr_subj_ects IN VARCHAR2 := NULL
        , expr_subj_tutor IN VARCHAR2 := NULL
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

    MEMBER FUNCTION match_expr_fields(
          subj_name IN VARCHAR2
        , university IN VARCHAR2
        , faculty IN VARCHAR2
        , studies_modetier IN VARCHAR2
        , studies_field IN VARCHAR2
        , studies_specialty IN VARCHAR2
        , semester_code IN VARCHAR2
        , subj_hours_w IN VARCHAR2
        , subj_hours_c IN VARCHAR2
        , subj_hours_l IN VARCHAR2
        , subj_hours_p IN VARCHAR2
        , subj_hours_s IN VARCHAR2
        , subj_credit_kind IN VARCHAR2
        , subj_ects IN VARCHAR2
        , subj_tutor IN VARCHAR2
        ) RETURN INTEGER
    IS
        score NUMBER;
        local NUMBER;
    BEGIN
        score := 1;     -- if all expressions are NULL, then match is positive
        IF expr_subj_name IS NOT NULL THEN
            local := match_subj_name(subj_name);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_university IS NOT NULL THEN
            local := match_university(university);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_faculty IS NOT NULL THEN
            local := match_faculty(faculty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_studies_modetier IS NOT NULL THEN
            local := match_studies_modetier(studies_modetier);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_studies_field IS NOT NULL THEN
            local := match_studies_field(studies_field);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_studies_specialty IS NOT NULL THEN
            local := match_studies_specialty(studies_specialty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_semester_code IS NOT NULL THEN
            local := match_semester_code(semester_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_hours_w IS NOT NULL THEN
            local := match_subj_hours_w(subj_hours_w);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_hours_c IS NOT NULL THEN
            local := match_subj_hours_c(subj_hours_c);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_hours_l IS NOT NULL THEN
            local := match_subj_hours_l(subj_hours_l);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_hours_p IS NOT NULL THEN
            local := match_subj_hours_p(subj_hours_p);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_hours_s IS NOT NULL THEN
            local := match_subj_hours_s(subj_hours_s);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_credit_kind IS NOT NULL THEN
            local := match_subj_credit_kind(subj_credit_kind);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_ects IS NOT NULL THEN
            local := match_subj_ects(subj_ects);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        IF expr_subj_tutor IS NOT NULL THEN
            local := match_subj_tutor(subj_tutor);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        RETURN score;
    END;


    MEMBER FUNCTION match_subj_name(subj_name IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_name, subj_name);
    END;


    MEMBER FUNCTION match_university(university IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_university, university);
    END;


    MEMBER FUNCTION match_faculty(faculty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_faculty, faculty);
    END;


    MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_modetier, studies_modetier);
    END;


    MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_field, studies_field);
    END;


    MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_specialty, studies_specialty);
    END;


    MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Range(expr_semester_code, semester_code);
    END;


    MEMBER FUNCTION match_subj_hours_w(subj_hours_w IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_w, subj_hours_w);
    END;


    MEMBER FUNCTION match_subj_hours_c(subj_hours_c IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_c, subj_hours_c);
    END;


    MEMBER FUNCTION match_subj_hours_l(subj_hours_l IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_l, subj_hours_l);
    END;


    MEMBER FUNCTION match_subj_hours_p(subj_hours_p IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_p, subj_hours_p);
    END;


    MEMBER FUNCTION match_subj_hours_s(subj_hours_s IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_hours_s, subj_hours_s);
    END;


    MEMBER FUNCTION match_subj_credit_kind(subj_credit_kind IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_credit_kind, subj_credit_kind);
    END;


    MEMBER FUNCTION match_subj_ects(subj_ects IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_subj_ects, subj_ects);
    END;


    MEMBER FUNCTION match_subj_tutor(subj_tutor IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Person_Name(expr_subj_tutor, subj_tutor);
    END;


END;

-- vim: set ft=sql ts=4 sw=4 et:
