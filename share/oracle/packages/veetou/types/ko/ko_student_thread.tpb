CREATE OR REPLACE TYPE BODY V2u_Ko_Student_Thread_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_Thread_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Thread_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , specialty_map_id IN NUMBER
            , thread_index IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , semester_ids IN V2u_Ids_t
            , semester_numbers IN V2u_Ints2_t
            , semester_codes IN V2u_Semester_Codes_t
            , max_admission_semester IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
            SELF.job_uuid := job_uuid;
            SELF.student_id := student_id;
            SELF.specialty_id := specialty_id;
            SELF.specialty_map_id := specialty_map_id;
            SELF.thread_index := thread_index;
            SELF.student_index := student_index;
            SELF.student_name := student_name;
            SELF.first_name := first_name;
            SELF.last_name := last_name;
            SELF.university := university;
            SELF.faculty := faculty;
            SELF.studies_modetier := studies_modetier;
            SELF.studies_field := studies_field;
            SELF.studies_specialty := studies_specialty;
            SELF.map_program_code := map_program_code;
            SELF.map_modetier_code := map_modetier_code;
            SELF.map_field_code := map_field_code;
            SELF.semester_ids := semester_ids;
            SELF.semester_numbers := semester_numbers;
            SELF.semester_codes := semester_codes;
            SELF.max_admission_semester := max_admission_semester;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Student_Thread_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Thread_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , specialty_map IN V2u_Specialty_Map_t
            , semester_ids IN V2u_Ids_t
            , thread_index IN NUMBER
            , max_admission_semester IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := student.job_uuid;
        SELF.student_id := student.id;
        SELF.specialty_id := specialty.id;
        SELF.specialty_map_id := specialty_map.id;
        SELF.thread_index := thread_index;
        SELF.student_index := student.student_index;
        SELF.student_name := student.student_name;
        SELF.first_name := student.first_name;
        SELF.last_name := student.last_name;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.map_program_code := specialty_map.map_program_code;
        SELF.map_modetier_code := specialty_map.map_modetier_code;
        SELF.map_field_code := specialty_map.map_field_code;
        --
        SELF.semester_ids := semester_ids;
        SELF.semester_numbers := V2u_Ints2_t();
        SELF.semester_codes := V2u_Semester_Codes_t();
        SELECT
              s.semester_number
            , s.semester_code
        BULK COLLECT INTO
              SELF.semester_numbers
            , SELF.semester_codes
        FROM v2u_ko_semesters s
        CROSS JOIN TABLE(semester_ids) s_ids
            WHERE (s.id  = VALUE(s_ids));
        --
        SELF.max_admission_semester := max_admission_semester;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Student_Thread_t)
            RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
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
        ord := V2U_Cmp.NumN(thread_index, other.thread_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.StrNI(max_admission_semester, other.max_admission_semester);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
