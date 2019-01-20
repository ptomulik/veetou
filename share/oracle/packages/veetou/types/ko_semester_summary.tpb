CREATE OR REPLACE TYPE BODY Veetou_Ko_Semester_Summary_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summary_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summary_Typ
            , semester_code IN VARCHAR := NULL
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
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        SELF.sheet_id := sheet_id;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summary_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summary_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            , sheet IN Veetou_Ko_Sheet_Typ
            , sheet_id IN NUMBER := NULL
      ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.semester_code := preamble.semester_code;
        SELF.semester_number := preamble.semester_number;
        SELF.ects_mandatory := sheet.ects_mandatory;
        SELF.ects_other := sheet.ects_other;
        SELF.ects_total := sheet.ects_total;
        SELF.ects_attained := sheet.ects_attained;
        SELF.sheet_id := sheet_id;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Semester_Summary_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.NumNullCmp(
                      VEETOU_Util.To_Semester_Id(semester_code)
                    , VEETOU_Util.To_Semester_Id(other.semester_code)
                    );
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_attained, other.ects_attained);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.NumNullCmp(sheet_id, other.sheet_id);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
