CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Entity_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Entity_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Entity_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
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
            , sheet_ids IN V2u_Ids_t := NULL
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
        SELF.semester_number := semester_number;
        SELF.semester_code := semester_code;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;

    MEMBER FUNCTION dup_with(
              new_id IN NUMBER := NULL
            , new_sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_Entity_t
    IS
    BEGIN
        RETURN V2u_Ko_Specialty_Entity_t(
              job_uuid => job_uuid
            , id => new_id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , semester_number => semester_number
            , semester_code => semester_code
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            , sheet_ids => new_sheet_ids
        );
    END;


    MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
            , new_sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_Entity_t
    IS
    BEGIN
        RETURN dup_with(V2U_Util.Next_Val(new_id_seq), new_sheet_ids);
    END;


    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Specialty_Entity_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.RawN(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: