CREATE OR REPLACE TYPE BODY V2u_Ko_Student_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , preamble_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.student_index := student_index;
        SELF.student_name := student_name;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.preamble_ids := preamble_ids;
        RETURN;
    END;


    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Student_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.RawNullCmp(job_uuid, other.job_uuid);
    END;

    MEMBER FUNCTION dup_with(
              new_id IN NUMBER
            , new_preamble_ids V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t
    IS
    BEGIN
        RETURN V2u_Ko_Student_t(
              job_uuid => job_uuid
            , id => new_id
            , student_index => student_index
            , student_name => student_name
            , first_name => first_name
            , last_name => last_name
            , preamble_ids => new_preamble_ids
        );
    END;

    MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
            , new_preamble_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t
    IS
    BEGIN
        return dup_with(V2U_Util.Next_Val(new_id_seq), new_preamble_ids);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
