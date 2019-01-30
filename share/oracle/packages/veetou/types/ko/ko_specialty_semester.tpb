CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Semester_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Semester_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            /* , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2 */
            , specialty IN REF V2u_Ko_Specialty_t
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        /* SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty; */
        SELF.specialty := specialty;
        SELF.semester_number := semester_number;
        SELF.semester_code := semester_code;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.sheet_ids := sheet_ids;
        RETURN;
    END;

    MEMBER FUNCTION dup(new_sheet_ids IN V2u_Ids_t := NULL)
        RETURN V2u_Ko_Specialty_Semester_t
    IS
    BEGIN
        RETURN V2u_Ko_Specialty_Semester_t(
              job_uuid => job_uuid
            , id => id
            /* , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty */
            , specialty => specialty
            , semester_number => semester_number
            , semester_code => semester_code
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            , sheet_ids => new_sheet_ids
        );
    END;


    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
        ord INTEGER;
        obj V2u_Ko_Specialty_Semester_t;
        spec_l V2u_Ko_Specialty_t;
        spec_r V2u_Ko_Specialty_t;
    BEGIN
        obj := TREAT(other AS V2u_Ko_Specialty_Semester_t);

        SELECT DEREF(specialty) INTO spec_l FROM dual;
        SELECT DEREF(obj.specialty) INTO spec_r FROM dual;
        /*ord := V2U_Cmp.StrNI(university, obj.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, obj.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, obj.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, obj.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_specialty, obj.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF; */
        ord := spec_l.cmp(spec_r);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(semester_number, obj.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(semester_code, obj.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_mandatory, obj.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(ects_other, obj.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.NumN(ects_total, obj.ects_total);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
