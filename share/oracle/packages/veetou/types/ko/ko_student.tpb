CREATE OR REPLACE TYPE BODY V2u_Ko_Student_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.student_index := student_index;
        SELF.student_name := student_name;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.student_index := preamble.student_index;
        SELF.student_name := preamble.student_name;
        SELF.first_name := preamble.first_name;
        SELF.last_name := preamble.last_name;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;


    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER
    IS
        ord INTEGER;
        obj V2u_Ko_Student_t;
    BEGIN
        obj := TREAT(other AS V2u_Ko_Student_t);
        ord := V2U_Cmp.StrNI(student_index, obj.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(student_name, obj.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(first_name, obj.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.StrNI(last_name, obj.last_name);
    END;

    MEMBER FUNCTION dup(new_sheet_ids V2u_Ids_t := NULL)
        RETURN V2u_Ko_Student_t
    IS
    BEGIN
        RETURN V2u_Ko_Student_t(
              id => id
            , job_uuid => job_uuid
            , student_index => student_index
            , student_name => student_name
            , first_name => first_name
            , last_name => last_name
            , sheet_ids => new_sheet_ids
        );
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
