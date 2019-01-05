CREATE OR REPLACE PACKAGE BODY V2U_Fit AS
    FUNCTION Attributes(
              protocol_map IN V2u_Protocol_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , grade_i IN V2u_Ko_Grade_I_t
            ) RETURN INTEGER DETERMINISTIC
    IS
        pattern V2u_Protocol_Map_Pattern_t;
    BEGIN
        IF protocol_Map IS NOT NULL AND
           grade_i IS NOT NULL AND
           student IS NOT NULL AND
           subject IS NOT NULL AND
           specialty IS NOT NULL AND
           semester IS NOT NULL
        THEN
            pattern := V2u_Protocol_Map_Pattern_t(protocol_map);
            return pattern.match_attributes(
                  subj_code => subject.subj_code
                , subj_name => subject.subj_name
                , subj_hours_w => subject.subj_hours_w
                , subj_hours_c => subject.subj_hours_c
                , subj_hours_l => subject.subj_hours_l
                , subj_hours_p => subject.subj_hours_p
                , subj_hours_s => subject.subj_hours_s
                , subj_credit_kind => subject.subj_credit_kind
                , subj_ects => subject.subj_ects
                , subj_tutor => subject.subj_tutor
                , university => specialty.university
                , faculty => specialty.faculty
                , studies_modetier => specialty.studies_modetier
                , studies_field => specialty.studies_field
                , studies_specialty => specialty.studies_specialty
                , semester_code => semester.semester_code
                , semester_number => semester.semester_number
                , ects_mandatory => semester.ects_mandatory
                , ects_other => semester.ects_other
                , ects_total => semester.ects_total
                , student_index => student.student_index
                , student_name => student.student_name
                , first_name => student.first_name
                , last_name => student.last_name
                , classes_type => grade_i.classes_type
                , subj_grade => grade_i.subj_grade
                , subj_grade_date => grade_i.subj_grade_date
                , map_subj_grade => grade_i.map_subj_grade
                , map_subj_grade_type => grade_i.map_subj_grade_type
                );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              classes_map IN V2u_Classes_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER
    IS
        pattern V2u_Classes_Map_Pattern_t;
    BEGIN
        IF classes_map IS NOT NULL AND
           subject IS NOT NULL AND
           specialty IS NOT NULL AND
           semester IS NOT NULL
        THEN
            pattern := V2u_Classes_Map_Pattern_t(classes_map);
            RETURN pattern.match_attributes(
                      subj_code => subject.subj_code
                    , subj_name => subject.subj_name
                    , subj_hours_w => subject.subj_hours_w
                    , subj_hours_c => subject.subj_hours_c
                    , subj_hours_l => subject.subj_hours_l
                    , subj_hours_p => subject.subj_hours_p
                    , subj_hours_s => subject.subj_hours_s
                    , subj_credit_kind => subject.subj_credit_kind
                    , subj_ects => subject.subj_ects
                    , subj_tutor => subject.subj_tutor
                    , university => specialty.university
                    , faculty => specialty.faculty
                    , studies_modetier => specialty.studies_modetier
                    , studies_field => specialty.studies_field
                    , studies_specialty => specialty.studies_specialty
                    , semester_code => semester.semester_code
                    , semester_number => semester.semester_number
                    , ects_mandatory => semester.ects_mandatory
                    , ects_other => semester.ects_other
                    , ects_total => semester.ects_total
                    );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              subject_map IN V2u_Subject_Map_B_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN INTEGER
    IS
        pattern V2u_Subject_Map_Pattern_t;
    BEGIN
        IF subject_map IS NOT NULL AND
           subject IS NOT NULL AND
           specialty IS NOT NULL AND
           semester IS NOT NULL
        THEN
            pattern := V2u_Subject_Map_Pattern_t(subject_map);
            RETURN pattern.match_attributes(
                      subj_name => subject.subj_name
                    , subj_hours_w => subject.subj_hours_w
                    , subj_hours_c => subject.subj_hours_c
                    , subj_hours_l => subject.subj_hours_l
                    , subj_hours_p => subject.subj_hours_p
                    , subj_hours_s => subject.subj_hours_s
                    , subj_credit_kind => subject.subj_credit_kind
                    , subj_ects => subject.subj_ects
                    , subj_tutor => subject.subj_tutor
                    , university => specialty.university
                    , faculty => specialty.faculty
                    , studies_modetier => specialty.studies_modetier
                    , studies_field => specialty.studies_field
                    , studies_specialty => specialty.studies_specialty
                    , semester_code => semester.semester_code
                    , semester_number => semester.semester_number
                    , ects_mandatory => semester.ects_mandatory
                    , ects_other => semester.ects_other
                    , ects_total => semester.ects_total
                    );
        ELSE
            RETURN 0;
        END IF;
    END;


    FUNCTION Attributes(
                  specialty_map IN V2u_Specialty_Map_B_t
                , semester IN V2u_Ko_Semester_t
                ) RETURN INTEGER
    IS
        pattern V2u_Specialty_Map_Pattern_t;
    BEGIN
        IF specialty_map IS NOT NULL AND
           semester IS NOT NULL
        THEN
            pattern := V2u_Specialty_Map_Pattern_t(specialty_map);
            RETURN pattern.match_attributes(
              semester_number => semester.semester_number
            , semester_code => semester.semester_code
            , ects_mandatory => semester.ects_mandatory
            , ects_other => semester.ects_other
            , ects_total => semester.ects_total
            );
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION Attributes(
              grade_i IN V2u_Ko_Grade_I_t
            , wartosc_oceny IN V2u_Dz_Wartosc_Oceny_B_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_B_t
            , data_zwrotu_rank IN NUMBER
            ) RETURN INTEGER
    IS
        total INTEGER;
    BEGIN
        total := 0;
        IF          grade_i.map_subj_grade = wartosc_oceny.opis
                AND grade_i.map_subj_grade_type = wartosc_oceny.toc_kod
            OR      grade_i.map_subj_grade IS NULL
                AND (   grade_i.map_subj_grade_type = wartosc_oceny.toc_kod
                     OR grade_i.map_subj_grade_type IS NULL
                    )
        THEN
            total := total + 10;
            IF TRUNC(grade_i.subj_grade_date, 'DD') = TRUNC(termin_protokolu.data_zwrotu, 'DD') THEN
                total := total + 50;
            ELSE
                total := total + data_zwrotu_rank;
            END IF;
        END IF;
        RETURN total;
    END;
END V2U_Fit;
/
-- vim: set ft=sql ts=4 sw=4 et:
