CREATE OR REPLACE TYPE BODY V2u_Ko_Preamble_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Preamble_t(
          SELF IN OUT NOCOPY V2u_Ko_Preamble_t
        , job_uuid IN RAW
        , id IN NUMBER
        , studies_modetier IN VARCHAR2 := NULL
        , title IN VARCHAR2 := NULL
        , student_index IN VARCHAR2 := NULL
        , first_name IN VARCHAR2 := NULL
        , last_name IN VARCHAR2 := NULL
        , student_name IN VARCHAR2 := NULL
        , semester_code IN VARCHAR2 := NULL
        , studies_field IN VARCHAR2 := NULL
        , semester_number IN NUMBER := NULL
        , studies_specialty IN VARCHAR2 := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.studies_modetier := studies_modetier;
        SELF.title := title;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.semester_code := semester_code;
        SELF.studies_field := studies_field;
        SELF.semester_number := semester_number;
        SELF.studies_specialty := studies_specialty;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
