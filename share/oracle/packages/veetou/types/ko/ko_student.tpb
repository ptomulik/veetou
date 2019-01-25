CREATE OR REPLACE TYPE BODY V2u_Ko_Student_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , job_uuid IN RAW
            , id IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2 := NULL
            , first_name IN VARCHAR2 := NULL
            , last_name IN VARCHAR2 := NULL
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


    MAP MEMBER FUNCTION map_fcn
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN LPAD(student_index, 32) || RAWTOHEX(job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
