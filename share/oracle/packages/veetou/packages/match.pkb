CREATE OR REPLACE PACKAGE BODY V2U_Match AS
    FUNCTION To_Number_Or_Null(value IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN TO_NUMBER(value);
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RETURN NULL;
    END;

    FUNCTION Strip_Person_Degrees(value IN VARCHAR2)
        RETURN VARCHAR2
    IS
        SUBTYPE Degree_Typ IS VARCHAR2(10);
        TYPE Degrees_Array IS VARRAY(20) OF Degree_Typ;
        n NUMBER;
        s VARCHAR2(1024);
        i NUMBER;
        d Degree_Typ;
        degrees Degrees_Array := Degrees_Array( 'prof. ',
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

    FUNCTION String_Like(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN CASE (value LIKE expr) WHEN TRUE THEN 1 ELSE 0 END;
    END;

    FUNCTION String_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;

        IF smin IS NOT NULL AND V2U_Cmp.Str(smin, value) > 0 THEN
            RETURN 0;
        ELSIF smax IS NOT NULL AND V2U_Cmp.Str(value, smax) > 0 THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;


    FUNCTION Code_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
    BEGIN
        RETURN String_Range(UPPER(expr), UPPER(value));
    END;

    FUNCTION Number_Range(expr IN VARCHAR2, value IN NUMBER)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
        nmin NUMBER;
        nmax NUMBER;
    BEGIN
        IF NOT V2U_Util.Split_Range(expr, smin, smax) THEN
            RETURN -1;
        END IF;
        nmin := To_Number_Or_Null(smin);
        nmax := To_Number_Or_Null(smax);
        IF nmin IS NOT NULL AND nmin > value THEN
            RETURN 0;
        ELSIF nmax IS NOT NULL AND value > nmax THEN
            RETURN 0;
        ELSE
            RETURN 1;
        END IF;
    END;

    FUNCTION Number_Range(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        smin VARCHAR2(1024);
        smax VARCHAR2(1024);
        nval NUMBER;
    BEGIN
        nval := To_Number_Or_Null(value);
        IF nval IS NULL THEN
            RETURN -1;
        ELSE
            RETURN Number_Range(expr, nval);
        END IF;
    END;

    FUNCTION Person_Name(expr IN VARCHAR2, value IN VARCHAR2)
        RETURN INTEGER
    IS
        name VARCHAR2(1024);
    BEGIN
        name := Strip_Person_Degrees(value);
        RETURN String_Like(expr, name);
    END;
END V2U_Match;

-- vim: set ft=sql ts=4 sw=4 et:
