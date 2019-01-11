CREATE OR REPLACE PACKAGE VEETOU_Common AUTHID CURRENT_USER AS
    FUNCTION Records_Match(lhs IN Veetou_Matchable_Subject_Typ,
                           rhs IN Veetou_Subject_Instance_Typ)
        RETURN INTEGER;

    -- Conversions
    FUNCTION To_Subject_Instance(row IN veetou_ko_refined%ROWTYPE)
        RETURN Veetou_Subject_Instance_Typ;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
