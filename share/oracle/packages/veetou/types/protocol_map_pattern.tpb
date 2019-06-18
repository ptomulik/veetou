CREATE OR REPLACE TYPE BODY V2u_Protocol_Map_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Protocol_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , map_semester_code IN VARCHAR2
            , map_proto_type IN VARCHAR2
            , map_term_prot_nr IN NUMBER
            , map_return_date IN DATE
            , map_return_date_prec IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            , student_pattern IN V2u_Student_Pattern_t
            , grade_pattern IN V2u_Grade_Pattern_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester_code => semester_code
            , map_subj_code => map_subj_code
            , map_classes_type => map_classes_type
            , map_semester_code => map_semester_code
            , map_proto_type => map_proto_type
            , map_term_prot_nr => map_term_prot_nr
            , map_return_date => map_return_date
            , map_return_date_prec => map_return_date_prec
            , subject_pattern => subject_pattern
            , specialty_pattern => specialty_pattern
            , semester_pattern => semester_pattern
            , student_pattern => student_pattern
            , grade_pattern => grade_pattern
            );
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Protocol_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , protocol_map IN V2u_Protocol_Map_B_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(protocol_map);
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , map_classes_type IN VARCHAR2
            , map_semester_code IN VARCHAR2
            , map_proto_type IN VARCHAR2
            , map_term_prot_nr IN NUMBER
            , map_return_date IN DATE
            , map_return_date_prec IN VARCHAR2
            , subject_pattern IN V2u_Subject_Pattern_t
            , specialty_pattern IN V2u_Specialty_Pattern_t
            , semester_pattern IN V2u_Semester_Pattern_t
            , student_pattern IN V2u_Student_Pattern_t
            , grade_pattern IN V2u_Grade_Pattern_t
            )
    IS
    BEGIN
        SELF.semester_code := semester_code;
        SELF.map_subj_code := map_subj_code;
        SELF.map_classes_type := map_classes_type;
        SELF.map_semester_code := map_semester_code;
        SELF.map_proto_type := map_proto_type;
        SELF.map_term_prot_nr := map_term_prot_nr;
        SELF.map_return_date := map_return_date;
        SELF.map_return_date_prec := map_return_date_prec;
        SELF.subject_pattern := subject_pattern;
        SELF.specialty_pattern := specialty_pattern;
        SELF.semester_pattern := semester_pattern;
        SELF.student_pattern := student_pattern;
        SELF.grade_pattern := grade_pattern;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Protocol_Map_Pattern_t
            , protocol_map IN V2u_Protocol_Map_B_t
            )
    IS
    BEGIN
        SELF.init(
              semester_code => protocol_map.semester_code
            , map_subj_code => protocol_map.map_subj_code
            , map_classes_type => protocol_map.map_classes_type
            , map_semester_code => protocol_map.map_semester_code
            , map_proto_type => protocol_map.map_proto_type
            , map_term_prot_nr => protocol_map.map_term_prot_nr
            , map_return_date => protocol_map.map_return_date
            , map_return_date_prec => protocol_map.map_return_date_prec
            , subject_pattern => V2u_Subject_Pattern_t(
                      expr_subj_code => protocol_map.expr_subj_code
                    , expr_subj_name => protocol_map.expr_subj_name
                    , expr_subj_hours_w => protocol_map.expr_subj_hours_w
                    , expr_subj_hours_c => protocol_map.expr_subj_hours_c
                    , expr_subj_hours_l => protocol_map.expr_subj_hours_l
                    , expr_subj_hours_p => protocol_map.expr_subj_hours_p
                    , expr_subj_hours_s => protocol_map.expr_subj_hours_s
                    , expr_subj_credit_kind => protocol_map.expr_subj_credit_kind
                    , expr_subj_ects => protocol_map.expr_subj_ects
                    , expr_subj_tutor => protocol_map.expr_subj_tutor
                    )
            , specialty_pattern => V2u_Specialty_Pattern_t(
                      expr_university => protocol_map.expr_university
                    , expr_faculty => protocol_map.expr_faculty
                    , expr_studies_modetier => protocol_map.expr_studies_modetier
                    , expr_studies_field => protocol_map.expr_studies_field
                    , expr_studies_specialty => protocol_map.expr_studies_specialty
                    )
            , semester_pattern => V2u_Semester_Pattern_t(
                      expr_semester_code => NULL
                    , expr_semester_number => protocol_map.expr_semester_number
                    , expr_ects_mandatory => protocol_map.expr_ects_mandatory
                    , expr_ects_other => protocol_map.expr_ects_other
                    , expr_ects_total => protocol_map.expr_ects_total
                    )
            , student_pattern => V2u_Student_Pattern_t(
                      expr_student_index => protocol_map.expr_student_index
                    , expr_student_name => protocol_map.expr_student_name
                    , expr_first_name => protocol_map.expr_first_name
                    , expr_last_name => protocol_map.expr_last_name
                    )
            , grade_pattern => V2u_Grade_Pattern_t(
                      expr_classes_type => protocol_map.expr_classes_type
                    , expr_subj_grade => protocol_map.expr_subj_grade
                    , expr_subj_grade_date => protocol_map.expr_subj_grade_date
                    , expr_map_subj_grade => protocol_map.expr_map_subj_grade
                    , expr_map_subj_grade_type => protocol_map.expr_map_subj_grade_type
                    )
            );
    END;

    MEMBER FUNCTION match_attributes(
              subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , classes_type IN VARCHAR2
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        total := 1;

        local := subject_pattern.match_attributes(
                      subj_code => subj_code
                    , subj_name => subj_name
                    , subj_hours_w => subj_hours_w
                    , subj_hours_c => subj_hours_c
                    , subj_hours_l => subj_hours_l
                    , subj_hours_p => subj_hours_p
                    , subj_hours_s => subj_hours_s
                    , subj_credit_kind => subj_credit_kind
                    , subj_ects => subj_ects
                    , subj_tutor => subj_tutor
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := specialty_pattern.match_attributes(
                      university => university
                    , faculty => faculty
                    , studies_modetier => studies_modetier
                    , studies_field => studies_field
                    , studies_specialty => studies_specialty
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := semester_pattern.match_attributes(
                      semester_code => semester_code
                    , semester_number => semester_number
                    , ects_mandatory => ects_mandatory
                    , ects_other => ects_other
                    , ects_total => ects_total
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := student_pattern.match_attributes(
                      student_index => student_index
                    , student_name => student_name
                    , first_name => first_name
                    , last_name => last_name
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;

        local := grade_pattern.match_attributes(
                      classes_type => classes_type
                    , subj_grade => subj_grade
                    , subj_grade_date => subj_grade_date
                    , map_subj_grade => map_subj_grade
                    , map_subj_grade_type => map_subj_grade_type
                    );
        IF local < 1 THEN
            RETURN local;
        ELSE
            total := total + (local - 1);
        END IF;


        -- bonus for map_subj_code being NOT NULL
        IF map_subj_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        -- bonus for map_classes_type being NOT NULL
        IF map_classes_type IS NOT NULL THEN
            total := total + 1;
        END IF;
        -- bonus for map_semester_code being NOT NULL
        IF map_semester_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        -- bonus for map_term_prot_nr being NOT NULL
        IF map_term_prot_nr IS NOT NULL THEN
            total := total + 1;
        END IF;
        -- bonus for map_return_date being NOT NULL
        IF map_return_date IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
