CREATE OR REPLACE TYPE BODY T_Veetou_Subject_Instance AS
    CONSTRUCTOR FUNCTION T_Veetou_Subject_Instance(
            ko_refined IN T_Veetou_Ko_Refined
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.subj_code := ko_refined.subj_code;
        SELF.subj_name := ko_refined.subj_name;
        SELF.university := ko_refined.university;
        SELF.faculty := ko_refined.faculty;
        SELF.studies_modetier := ko_refined.studies_modetier;
        SELF.studies_field := ko_refined.studies_field;
        SELF.studies_specialty := ko_refined.studies_specialty;
        SELF.semester_code := ko_refined.semester_code;
        SELF.subj_tutor := ko_refined.subj_tutor;
        SELF.subj_hours_w := ko_refined.subj_hours_w;
        SELF.subj_hours_c := ko_refined.subj_hours_c;
        SELF.subj_hours_l := ko_refined.subj_hours_l;
        SELF.subj_hours_p := ko_refined.subj_hours_p;
        SELF.subj_hours_s := ko_refined.subj_hours_s;
        SELF.subj_credit_kind := ko_refined.subj_credit_kind;
        SELF.subj_ects := ko_refined.subj_ects;
        RETURN;
    END;
END;
/

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
                                   rhs IN T_Veetou_Subject_Instance)
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
                           rhs IN T_Veetou_Subject_Instance)
        RETURN INTEGER
    IS
        ans INTEGER;
        b BOOLEAN;
    BEGIN
        b := lhs.subj_code = rhs.subj_code AND Records_Matcher_Match(lhs,rhs);
        ans := To_Int(b);
        RETURN ans;
    END;

    FUNCTION To_Subject_Instance(row IN veetou_ko_refined%ROWTYPE)
        RETURN T_Veetou_Subject_Instance
    IS
        obj T_Veetou_Subject_Instance;
    BEGIN
        obj.subj_code := row.subj_code;
        obj.subj_name := row.subj_name;
        obj.university := row.university;
        obj.faculty := row.faculty;
        obj.studies_modetier := row.studies_modetier;
        obj.studies_field := row.studies_field;
        obj.studies_specialty := row.studies_specialty;
        obj.semester_code := row.semester_code;
        obj.subj_tutor := row.subj_tutor;
        obj.subj_hours_w := row.subj_hours_w;
        obj.subj_hours_c := row.subj_hours_c;
        obj.subj_hours_l := row.subj_hours_l;
        obj.subj_hours_p := row.subj_hours_p;
        obj.subj_hours_s := row.subj_hours_s;
        obj.subj_credit_kind := row.subj_credit_kind;
        obj.subj_ects := row.subj_ects;
        RETURN obj;
    END;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
