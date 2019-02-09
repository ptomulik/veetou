CREATE OR REPLACE TYPE BODY V2u_Ko_Rejected_Map_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Rejected_Map_t(
              SELF IN OUT NOCOPY V2u_Ko_Rejected_Map_t
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.map_id := map_id;
        SELF.matching_score := matching_score;
        SELF.reason := reason;
        RETURN;
    END;

    MAP MEMBER FUNCTION map_fcn
            RETURN NUMBER
    IS
    BEGIN
        return map_id;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
