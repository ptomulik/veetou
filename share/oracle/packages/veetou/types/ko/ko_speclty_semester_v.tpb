CREATE OR REPLACE TYPE BODY V2u_Ko_Speclty_Semester_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Speclty_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Speclty_Semester_V_t
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
--            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_number := semester_number;
        SELF.semester_code := semester_code;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
--        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Speclty_Semester_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Speclty_Semester_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := specialty.job_uuid;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.semester_number := semester.semester_number;
        SELF.semester_code := semester.semester_code;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.ects_total := semester.ects_total;
 --       SELF.sheet_ids := semester.sheet_ids;
        RETURN;
    END;

--      ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Speclty_Semester_V_t)
--            RETURN INTEGER
--    IS
--        ord INTEGER;
--    BEGIN
--        ord := V2U_Cmp.StrNI(university, other.university);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(faculty, other.faculty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(semester_number, other.semester_number);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(ects_mandatory, other.ects_mandatory);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(ects_other, other.ects_other);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        RETURN V2U_Cmp.NumN(ects_total, other.ects_total);
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
