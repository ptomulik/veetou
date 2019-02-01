CREATE OR REPLACE TYPE BODY V2u_Specialty_Map_t AS
    CONSTRUCTOR FUNCTION V2u_Specialty_Map_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_t
            , id IN NUMBER
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , map_program_code IN VARCHAR2 := NULL
            , map_modetier_code IN VARCHAR2 := NULL
            , map_field_code IN VARCHAR2 := NULL
            , expr_semester_number VARCHAR2 := NULL
            , expr_semester_code VARCHAR2 := NULL
            , expr_ects_mandatory VARCHAR2 := NULL
            , expr_ects_other VARCHAR2 := NULL
            , expr_ects_total VARCHAR2 := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.map_program_code := map_program_code;
        SELF.map_modetier_code := map_modetier_code;
        SELF.map_field_code := map_field_code;
        SELF.expr_semester_number := expr_semester_number;
        SELF.expr_semester_code := expr_semester_code;
        SELF.expr_ects_mandatory := expr_ects_mandatory;
        SELF.expr_ects_other := expr_ects_other;
        SELF.expr_ects_total := expr_ects_total;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Specialty_Map_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Specialty_Map_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_program_code, other.map_program_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_modetier_code, other.map_modetier_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_field_code, other.map_field_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_semester_number, other.expr_semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_semester_code, other.expr_semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_ects_mandatory, other.expr_ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_ects_other, other.expr_ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.StrNI(expr_ects_total, other.expr_ects_total);
    END;

    MEMBER FUNCTION match_expr_fields(
              semester_number IN VARCHAR2
            , semester_code IN VARCHAR2
            , ects_mandatory IN VARCHAR2
            , ects_other IN VARCHAR2
            , ects_total IN VARCHAR2
            ) RETURN INTEGER
    IS
        total NUMBER;
        local NUMBER;
    BEGIN
        total := 1;     -- if all expressions are NULL, then match is positive
        IF expr_semester_number IS NOT NULL THEN
            local := match_semester_number(semester_number);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_semester_code IS NOT NULL THEN
            local := match_semester_code(semester_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_mandatory IS NOT NULL THEN
            local := match_ects_mandatory(ects_mandatory);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_other IS NOT NULL THEN
            local := match_ects_other(ects_other);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_total IS NOT NULL THEN
            local := match_ects_total(ects_total);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        -- bonus for mapped codes not being null
        IF map_program_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;

    MEMBER FUNCTION match_semester_number(semester_number IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_semester_number, semester_number);
    END;

    MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Range(expr_semester_code, semester_code);
    END;

    MEMBER FUNCTION match_ects_mandatory(ects_mandatory IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_mandatory, ects_mandatory);
    END;

    MEMBER FUNCTION match_ects_other(ects_other IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_other, ects_other);
    END;

    MEMBER FUNCTION match_ects_total(ects_total IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_total, ects_total);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
