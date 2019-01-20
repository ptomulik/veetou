CREATE OR REPLACE TYPE BODY Veetou_Ko_Student_Program_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Student_Program_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Program_Typ
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , studies_specialty IN VARCHAR := NULL
            , semesters Veetou_Ko_Semester_Summlog_Typ := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        IF semesters IS NULL THEN
            SELF.semesters := Veetou_Ko_Semester_Summlog_Typ();
        ELSE
            SELF.semesters := semesters;
        END IF;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Student_Program_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Student_Program_Typ
            , sheet_info IN Veetou_Ko_Sheet_Info_Typ
      ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := sheet_info.student_index;
        SELF.first_name := sheet_info.first_name;
        SELF.last_name := sheet_info.last_name;
        SELF.student_name := sheet_info.student_name;
        SELF.university := sheet_info.university;
        SELF.faculty := sheet_info.faculty;
        SELF.studies_modetier := sheet_info.studies_modetier;
        SELF.studies_field := sheet_info.studies_field;
        SELF.studies_specialty := sheet_info.studies_specialty;
        SELF.semesters := Veetou_Ko_Semester_Summlog_Typ();
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Student_Program_Typ)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN semesters.cmp_with(other.semesters);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
