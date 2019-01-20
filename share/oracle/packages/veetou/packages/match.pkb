CREATE OR REPLACE PACKAGE BODY VEETOU_Match AS

    FUNCTION Strip_Person_Degrees(value IN VARCHAR)
        RETURN VARCHAR
    IS
        SUBTYPE Degree_Typ IS VARCHAR(10);
        TYPE Degrees_Array IS VARRAY(20) OF Degree_Typ;
        n NUMBER;
        s VARCHAR(1024);
        i NUMBER;
        d Degree_Typ;
        degrees Degrees_Array := Degrees_Array('prof. ',
                                                'dr ',
                                                'hab. ',
                                                'mgr ',
                                                'inż. ',
                                                'lic. ',
                                                'doc. ',
                                                'nzw. ',
                                                ' prof.',
                                                ', ',
                                                ' PW');
    BEGIN
        s := value;
        FOR i IN 1 .. degrees.COUNT LOOP
            d := degrees(i);
            n := INSTR(UPPER(s), UPPER(d));
            IF n != 0 THEN
                s := TRIM(SUBSTR(s, 1, n-1) || ' ' || SUBSTR(s, n + LENGTH(d)));
            END IF;
        END LOOP;
        --
        RETURN s;
    END;

    FUNCTION String_Like(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
    BEGIN
        RETURN CASE (value LIKE expr) WHEN TRUE THEN 1 ELSE 0 END;
    END;

    FUNCTION String_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
    BEGIN
        IF NOT VEETOU_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;

        DBMS_Output.Put_Line('smin: ' || smin || ', smax: ' || smax);

        IF smin IS NOT NULL AND VEETOU_Util.StrCmp(smin, value) > 0 THEN
            RETURN 0;
        ELSIF smax IS NOT NULL AND VEETOU_Util.StrCmp(value, smax) > 0 THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;


    FUNCTION Code_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
    BEGIN
        RETURN String_Range(UPPER(expr), UPPER(value));
    END;

    FUNCTION Number_Range(expr IN VARCHAR, value IN NUMBER)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
        nmin NUMBER;
        nmax NUMBER;
    BEGIN
        IF NOT VEETOU_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;
        nmin := VEETOU_Util.To_Number_Or_Null(smin);
        nmax := VEETOU_Util.To_Number_Or_Null(smax);
        IF nmin IS NOT NULL AND nmin > value THEN
            RETURN 0;
        ELSIF nmax IS NOT NULL AND value > nmax THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;

    FUNCTION Number_Range(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        smin VARCHAR(1024);
        smax VARCHAR(1024);
        nval NUMBER;
    BEGIN
        nval := VEETOU_Util.To_Number_Or_Null(value);
        IF nval IS NULL THEN
            RETURN -1;
        ELSE
            RETURN Number_Range(expr, nval);
        END IF;
    END;

    FUNCTION Person_Name(expr IN VARCHAR, value IN VARCHAR)
        RETURN INTEGER
    IS
        name VARCHAR(1024);
    BEGIN
        name := Strip_Person_Degrees(value);
        RETURN String_Like(expr, name);
    END;
END VEETOU_Match;

-- vim: set ft=sql ts=4 sw=4 et:
