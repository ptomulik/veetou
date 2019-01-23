CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_t
            , job_uuid IN RAW
            , id IN NUMBER
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , sheet_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;


    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Specialty_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
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
        RETURN V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
