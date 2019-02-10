CREATE OR REPLACE TYPE BODY V2u_Classes_Map_Base_t AS
    CONSTRUCTOR FUNCTION V2u_Classes_Map_Base_t(
              SELF IN OUT NOCOPY V2u_Classes_Map_Base_t
            , id IN NUMBER
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , expr_subj_code IN VARCHAR2
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , classes_type => classes_type
            , map_classes_type => map_classes_type
            , expr_subj_code => expr_subj_code
            , expr_subj_name => expr_subj_name
            , expr_subj_hours_w => expr_subj_hours_w
            , expr_subj_hours_c => expr_subj_hours_c
            , expr_subj_hours_l => expr_subj_hours_l
            , expr_subj_hours_p => expr_subj_hours_p
            , expr_subj_hours_s => expr_subj_hours_s
            , expr_subj_credit_kind => expr_subj_credit_kind
            , expr_subj_ects => expr_subj_ects
            , expr_subj_tutor => expr_subj_tutor
            , expr_university => expr_university
            , expr_faculty => expr_faculty
            , expr_studies_modetier => expr_studies_modetier
            , expr_studies_field => expr_studies_field
            , expr_studies_specialty => expr_studies_specialty
            , expr_semester_code => expr_semester_code
            , expr_semester_number => expr_semester_number
            , expr_ects_mandatory => expr_ects_mandatory
            , expr_ects_other => expr_ects_other
            , expr_ects_total => expr_ects_total
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Map_Base_t
            , id IN NUMBER := NULL
            , classes_type IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , expr_subj_code IN VARCHAR2
            , expr_subj_name IN VARCHAR2
            , expr_subj_hours_w IN VARCHAR2
            , expr_subj_hours_c IN VARCHAR2
            , expr_subj_hours_l IN VARCHAR2
            , expr_subj_hours_p IN VARCHAR2
            , expr_subj_hours_s IN VARCHAR2
            , expr_subj_credit_kind IN VARCHAR2
            , expr_subj_ects IN VARCHAR2
            , expr_subj_tutor IN VARCHAR2
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            )
    IS
    BEGIN
        SELF.id := id;
        SELF.classes_type := classes_type;
        SELF.map_classes_type := map_classes_type;
        SELF.expr_subj_code := expr_subj_code;
        SELF.expr_subj_name := expr_subj_name;
        SELF.expr_subj_hours_w := expr_subj_hours_w;
        SELF.expr_subj_hours_c := expr_subj_hours_c;
        SELF.expr_subj_hours_l := expr_subj_hours_l;
        SELF.expr_subj_hours_p := expr_subj_hours_p;
        SELF.expr_subj_hours_s := expr_subj_hours_s;
        SELF.expr_subj_credit_kind := expr_subj_credit_kind;
        SELF.expr_subj_ects := expr_subj_ects;
        SELF.expr_subj_tutor := expr_subj_tutor;
        SELF.expr_university := expr_university;
        SELF.expr_faculty := expr_faculty;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.expr_studies_field := expr_studies_field;
        SELF.expr_studies_specialty := expr_studies_specialty;
        SELF.expr_semester_code := expr_semester_code;
        SELF.expr_semester_number := expr_semester_number;
        SELF.expr_ects_mandatory := expr_ects_mandatory;
        SELF.expr_ects_other := expr_ects_other;
        SELF.expr_ects_total := expr_ects_total;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Classes_Map_Base_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Classes_Map_Base_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(classes_type, other.classes_type);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_classes_type, other.map_classes_type);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(expr_subj_code, other.expr_subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN (SELF AS V2u_Map_Base_t).cmp_val(other);
    END;

    MEMBER FUNCTION match_expr_fields(
          subj_code IN VARCHAR2
        , subj_name IN VARCHAR2
        , subj_hours_w IN VARCHAR2
        , subj_hours_c IN VARCHAR2
        , subj_hours_l IN VARCHAR2
        , subj_hours_p IN VARCHAR2
        , subj_hours_s IN VARCHAR2
        , subj_credit_kind IN VARCHAR2
        , subj_ects IN VARCHAR2
        , subj_tutor IN VARCHAR2
        , university IN VARCHAR2
        , faculty IN VARCHAR2
        , studies_modetier IN VARCHAR2
        , studies_field IN VARCHAR2
        , studies_specialty IN VARCHAR2
        , semester_code IN VARCHAR2
        , semester_number IN VARCHAR2
        , ects_mandatory IN VARCHAR2
        , ects_other IN VARCHAR2
        , ects_total IN VARCHAR2
        ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        total := SELF.match_expr_fields(
              subj_name => subj_name
            , subj_hours_w => subj_hours_w
            , subj_hours_c => subj_hours_c
            , subj_hours_l => subj_hours_l
            , subj_hours_p => subj_hours_p
            , subj_hours_s => subj_hours_s
            , subj_credit_kind => subj_credit_kind
            , subj_ects => subj_ects
            , subj_tutor => subj_tutor
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , semester_code => semester_code
            , semester_number => semester_number
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            );
        IF total < 1 THEN
            RETURN total;
        END IF;
        IF expr_subj_code IS NOT NULL THEN
            local := match_subj_code(subj_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + local;
            END IF;
        END IF;
        -- bonus for map_classes_type being not NULL
        IF map_classes_type IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;

    MEMBER FUNCTION match_subj_code(subj_code IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_subj_code, subj_code);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
