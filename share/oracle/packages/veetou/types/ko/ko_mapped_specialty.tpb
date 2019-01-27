CREATE OR REPLACE TYPE BODY V2u_Ko_Mapped_Specialty_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Specialty_t(
          SELF IN OUT NOCOPY V2u_Ko_Mapped_Specialty_t
        , job_uuid IN RAW
        , specialty_issue_id IN NUMBER
        , specialty_map_id IN NUMBER
        , matching_score IN NUMBER
        , university VARCHAR2
        , faculty VARCHAR2
        , studies_modetier VARCHAR2
        , studies_field VARCHAR2
        , studies_specialty VARCHAR2
        , semester_number NUMBER
        , expr_semester_number VARCHAR2
        , semester_code VARCHAR2
        , expr_semester_code VARCHAR2
        , ects_mandatory NUMBER
        , expr_ects_mandatory VARCHAR2
        , ects_other NUMBER
        , expr_ects_other VARCHAR2
        , ects_total NUMBER
        , expr_ects_total VARCHAR2
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.specialty_issue_id := specialty_issue_id;
        SELF.specialty_map_id := specialty_map_id;
        SELF.matching_score := matching_score;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_number := semester_number;
        SELF.expr_semester_number := expr_semester_number;
        SELF.semester_code := semester_code;
        SELF.expr_semester_code := expr_semester_code;
        SELF.ects_mandatory := ects_mandatory;
        SELF.expr_ects_mandatory := expr_ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.expr_ects_other := expr_ects_other;
        SELF.ects_total := ects_total;
        SELF.expr_ects_total := expr_ects_total;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(
              other V2u_Ko_Mapped_Specialty_t
            ) RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.NumNullCmp(matching_score, other.matching_score);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(expr_semester_number, other.expr_semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(expr_semester_code, other.expr_semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(expr_ects_mandatory, other.expr_ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(expr_ects_other, other.expr_ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(expr_ects_total, other.expr_ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
