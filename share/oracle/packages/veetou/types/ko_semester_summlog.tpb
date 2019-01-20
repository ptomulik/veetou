CREATE OR REPLACE TYPE BODY Veetou_Ko_Semester_Summlog_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summlog_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summlog_Typ
            , semesters IN Veetou_Ko_Semester_Summaries_Typ := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        IF semesters IS NULL THEN
            SELF.semesters := Veetou_Ko_Semester_Summaries_Typ();
        ELSE
            SELF.semesters := semesters;
        END IF;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Semester_Summlog_Typ)
            RETURN NUMBER
    IS
        n NUMBER;
        n1 NUMBER;
        n2 NUMBER;
        ord NUMBER;
    BEGIN
        IF semesters IS NULL THEN
            n1 := 0;
        ELSE
            n1 := semesters.COUNT;
        END IF;
        IF other.semesters IS NULL THEN
            n2 := 0;
        ELSE
            n2 := other.semesters.COUNT;
        END IF;
        n := GREATEST(n1, n2);
        FOR i IN 1..n
        LOOP
            IF i > n1 THEN
                RETURN -1;
            ELSIF i > n2 THEN
                RETURN 1;
            ELSE
                ord := semesters(i).cmp_with(other.semesters(i));
                IF ord <> 0 THEN
                    RETURN ord;
                END IF;
            END IF;
        END LOOP;
        RETURN 0;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
