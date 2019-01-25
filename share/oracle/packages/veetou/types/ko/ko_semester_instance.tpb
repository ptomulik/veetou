CREATE OR REPLACE TYPE BODY V2u_Ko_Semester_Instance_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Semester_Instance_t(
              SELF IN OUT NOCOPY V2u_Ko_Semester_Instance_t
            , job_uuid IN RAW
            , id IN NUMBER
            , semester_code IN VARCHAR2 := NULL
            , semester_number IN NUMBER := NULL
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            , sheet_id IN NUMBER := NULL
            )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        SELF.sheet_id := sheet_id;
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Ko_Semester_Instance_t(
--              SELF IN OUT NOCOPY V2u_Ko_Semester_Instance_t
--            , job_uuid IN RAW
--            , id IN NUMBER
--            , preamble IN V2u_Ko_Preamble_t
--            , sheet IN V2u_Ko_Sheet_t
--            , sheet_id IN NUMBER := NULL
--      ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.id := id;
--        SELF.semester_code := preamble.semester_code;
--        SELF.semester_number := preamble.semester_number;
--        SELF.ects_mandatory := sheet.ects_mandatory;
--        SELF.ects_other := sheet.ects_other;
--        SELF.ects_total := sheet.ects_total;
--        SELF.ects_attained := sheet.ects_attained;
--        SELF.sheet_id := sheet_id;
--        RETURN;
--    END;

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Semester_Instance_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(
                      V2U_To.Semester_Id(semester_code)
                    , V2U_To.Semester_Id(other.semester_code)
                    );
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_attained, other.ects_attained);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.NumNullCmp(sheet_id, other.sheet_id);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
