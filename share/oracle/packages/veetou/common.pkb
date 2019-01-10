CREATE OR REPLACE PACKAGE BODY VEETOU_Common AS
    FUNCTION To_Int(x IN BOOLEAN) RETURN INTEGER IS
        ans INTEGER;
    BEGIN
        ans := CASE x WHEN TRUE THEN 1
                      WHEN FALSE THEN 0
                      ELSE NULL
               END;
        RETURN ans;
    END;


    FUNCTION Records_Matcher_Match(lhs IN T_Veetou_Matchable,
                                   rhs IN T_Veetou_Subject_Conducted)
        RETURN BOOLEAN
    IS
        ans BOOLEAN;
    BEGIN
        ans := lhs.matcher_id IS NULL OR (CASE lhs.matcher_id
            WHEN 'tutor' THEN (lhs.matcher_arg = rhs.subj_tutor)
            ELSE FALSE
        END);
        RETURN ans;
    END;


    FUNCTION Records_Match(lhs IN T_Veetou_Matchable_Subject,
                           rhs IN T_Veetou_Subject_Conducted)
        RETURN INTEGER
    IS
        ans INTEGER;
        b BOOLEAN;
    BEGIN
        b := lhs.subj_code = rhs.subj_code AND Records_Matcher_Match(lhs,rhs);
        ans := To_Int(b);
        RETURN ans;
    END;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
