CREATE OR REPLACE TYPE BODY V2u_Ko_Semester_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , sheet_ids IN V2u_Ids_t := NULL
            )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Ko_Semester_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Ko_Semester_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.NumN(ects_total, other.ects_total);
    END;

    MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
        RETURN V2u_Ko_Semester_t
    IS
    BEGIN
        RETURN V2u_Ko_Semester_t(
              id => id
            , job_uuid => job_uuid
            , semester_code => semester_code
            , semester_number => semester_number
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            , sheet_ids => new_sheet_ids
        );
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
