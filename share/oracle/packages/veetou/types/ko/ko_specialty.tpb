CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.university := V2U_Get.University(name => header.university).abbriev;
        SELF.faculty := V2U_Get.Faculty(name => header.faculty).abbriev;
        SELF.studies_modetier := preamble.studies_modetier;
        SELF.studies_field := preamble.studies_field;
        SELF.studies_specialty := preamble.studies_specialty;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;


    MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
            RETURN V2u_Ko_Specialty_t
    IS
    BEGIN
        RETURN V2u_Ko_Specialty_t(
              job_uuid => job_uuid
            , id => id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , sheet_ids => new_sheet_ids
        );
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
        ord INTEGER;
        obj V2u_Ko_Specialty_t;
    BEGIN
        obj := TREAT(other AS V2u_Ko_Specialty_t);
        ord := V2U_Cmp.StrNI(university, obj.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, obj.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, obj.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, obj.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.StrNI(studies_specialty, obj.studies_specialty);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
