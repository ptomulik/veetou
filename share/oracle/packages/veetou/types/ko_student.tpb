CREATE OR REPLACE TYPE BODY V2u_Ko_Student_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
          SELF IN OUT NOCOPY V2u_Ko_Student_t
        , student_index IN VARCHAR
        , student_name IN VARCHAR := NULL
        , first_name IN VARCHAR := NULL
        , last_name IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := student_index;
        SELF.student_name := student_name;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Ko_Student_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.student_index := preamble.student_index;
        SELF.student_name := preamble.student_name;
        SELF.first_name := preamble.first_name;
        SELF.last_name := preamble.last_name;
        RETURN;
    END;

    MAP MEMBER FUNCTION map_fcn
        RETURN VARCHAR
    IS
    BEGIN
        RETURN student_index;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
