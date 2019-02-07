CREATE OR REPLACE PACKAGE BODY V2U_To AS
--    FUNCTION Semester_Code(semester_id IN NUMBER)
--        RETURN VARCHAR2
--    IS
--    BEGIN
--        RETURN V2u_Semester_t.to_code(semester_id);
--    END;
--
--    FUNCTION Semester_Id(semester_code IN VARCHAR2)
--        RETURN NUMBER
--    IS
--    BEGIN
--        RETURN V2u_Semester_t.to_id(semester_code);
--    END;
--
--
    FUNCTION Find_Threads(semesters IN V2u_Ko_Semesters_t)
        RETURN V2u_Ints2_t
    IS
        t V2u_Ints2_t := V2u_Ints2_t();
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        sn NUMBER(2);
        prev NUMBER(2);
    BEGIN
        t.EXTEND(semesters.COUNT);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            prev := 0;
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF t(j) IS NULL THEN
                    sn := s.semester_number;
                    IF sn >= prev AND ((prev = 0) OR (sn - prev <= 1)) THEN
                        t(j) := i;
                        prev := sn;
                        n := n + 1;
                    ELSE
                        EXIT;
                    END IF;
                END IF;
                j := j+1;
            END LOOP;
            i := i+1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN t;
    END;


    FUNCTION Threads(semesters IN V2u_Ko_Semesters_t)
        RETURN V2u_Ko_Semester_Tables_t
    IS
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        tn V2u_Ints2_t;
        tt V2u_Ko_Semester_Tables_t := V2u_Ko_Semester_Tables_t();
    BEGIN
        tn := Find_Threads(semesters);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            tt.EXTEND(1);
            tt(tt.COUNT) := V2u_Ko_Semesters_t();
            j := 1;
            FOR s IN (SELECT VALUE(t) sem FROM TABLE(semesters) t ORDER BY 1)
            LOOP
                IF tn(j) = i THEN
                    tt(i).EXTEND(1);
                    tt(i)(tt(i).COUNT) := s.sem.dup(new_sheet_ids => s.sem.sheet_ids);
                    n := n + 1;
                END IF;
                j := j + 1;
            END LOOP;
            i := i + 1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN tt;
    END;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
