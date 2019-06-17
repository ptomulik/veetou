CREATE OR REPLACE TYPE BODY V2u_Protocol_Map_B_t AS
    CONSTRUCTOR FUNCTION V2u_Protocol_Map_B_t(
              SELF IN OUT NOCOPY V2u_Protocol_Map_B_t
            , id IN NUMBER
            , semester_code IN VARCHAR2
            , map_protocol_semester IN VARCHAR2
            , map_protocol_date IN DATE
            , map_protocol_date_match IN VARCHAR2
            , expr_subj_code IN VARCHAR2
            , expr_classes_type IN VARCHAR2
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
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , semester_code => semester_code
            , map_protocol_semester => map_protocol_semester
            , map_protocol_date => map_protocol_date
            , map_protocol_date_match => map_protocol_date_match
            , expr_subj_code => expr_subj_code
            , expr_classes_type => expr_classes_type
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
            , expr_student_index => expr_student_index
            , expr_student_name => expr_student_name
            , expr_first_name => expr_first_name
            , expr_last_name => expr_last_name
            , expr_subj_grade => expr_subj_grade
            , expr_subj_grade_date => expr_subj_grade_date
            , expr_map_subj_grade => expr_map_subj_grade
            , expr_map_subj_grade_type => expr_map_subj_grade_type
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Protocol_Map_B_t
            , id IN NUMBER := NULL
            , semester_code IN VARCHAR2
            , map_protocol_semester IN VARCHAR2
            , map_protocol_date IN DATE
            , map_protocol_date_match IN VARCHAR2
            , expr_subj_code IN VARCHAR2
            , expr_classes_type IN VARCHAR2
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
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(id => id);
        --
        SELF.semester_code := semester_code;
        SELF.map_protocol_semester := map_protocol_semester;
        SELF.map_protocol_date := map_protocol_date;
        SELF.map_protocol_date_match := map_protocol_date_match;
        SELF.expr_subj_code := expr_subj_code;
        SELF.expr_classes_type := expr_classes_type;
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
        SELF.expr_student_index := expr_student_index;
        SELF.expr_student_name := expr_student_name;
        SELF.expr_first_name := expr_first_name;
        SELF.expr_last_name := expr_last_name;
        SELF.expr_subj_grade := expr_subj_grade;
        SELF.expr_subj_grade_date := expr_subj_grade_date;
        SELF.expr_map_subj_grade := expr_map_subj_grade;
        SELF.expr_map_subj_grade_type := expr_map_subj_grade_type;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Protocol_Map_B_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Protocol_Map_B_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_protocol_semester, other.map_protocol_semester);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.DateN(map_protocol_date, other.map_protocol_date);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(map_protocol_date_match, other.map_protocol_date_match);
        IF ord <> 0 THEN RETURN ord; END IF;
        --
        ord := V2u_Cmp.StrNI(expr_subj_code, other.expr_subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_classes_type, other.expr_classes_type);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_name, other.expr_subj_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_hours_w, other.expr_subj_hours_w);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_hours_c, other.expr_subj_hours_c);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_hours_l, other.expr_subj_hours_l);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_hours_p, other.expr_subj_hours_p);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_hours_s, other.expr_subj_hours_s);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_credit_kind, other.expr_subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_ects, other.expr_subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_tutor, other.expr_subj_tutor);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_university, other.expr_university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_faculty, other.expr_faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_studies_modetier, other.expr_studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_studies_field, other.expr_studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_studies_specialty, other.expr_studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_semester_code, other.expr_semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_semester_number, other.expr_semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_ects_mandatory, other.expr_ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_ects_other, other.expr_ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_ects_total, other.expr_ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_student_index, other.expr_student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_student_name, other.expr_student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_first_name, other.expr_first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_last_name, other.expr_last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_grade, other.expr_subj_grade);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_subj_grade_date, other.expr_subj_grade_date);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.StrNI(expr_map_subj_grade, other.expr_map_subj_grade);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2u_Cmp.StrNI(expr_map_subj_grade_type, other.expr_map_subj_grade_type);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
