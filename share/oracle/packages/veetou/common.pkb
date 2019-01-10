CREATE OR REPLACE PACKAGE BODY VEETOU_Common AS
    -- Record types for table rows
    SUBTYPE T_Subject_Mappings_Row IS veetou_subject_mappings%ROWTYPE;


    FUNCTION Subject_Conducted( subj_code IN VARCHAR2 := NULL
                              , subj_name IN VARCHAR2 := NULL
                              , university IN VARCHAR2 := NULL
                              , faculty IN VARCHAR2 := NULL
                              , studies_modetier IN VARCHAR2 := NULL
                              , studies_field IN VARCHAR2 := NULL
                              , studies_specialty IN VARCHAR2 := NULL
                              , semester_code IN VARCHAR2 := NULL
                              , subj_tutor IN VARCHAR2 := NULL
                              , subj_hours_w IN NUMBER := NULL
                              , subj_hours_c IN NUMBER := NULL
                              , subj_hours_l IN NUMBER := NULL
                              , subj_hours_p IN NUMBER := NULL
                              , subj_hours_s IN NUMBER := NULL
                              , subj_credit_kind IN VARCHAR2 := NULL
                              , subj_ects IN NUMBER := NULL)
        RETURN T_Subject_Conducted
    IS
        rec T_Subject_Conducted;
    BEGIN
        rec.subj_code := subj_code;
        rec.subj_name := subj_name;
        rec.university := university;
        rec.faculty := faculty;
        rec.studies_modetier := studies_modetier;
        rec.studies_field := studies_field;
        rec.studies_specialty := studies_specialty;
        rec.semester_code := semester_code;
        rec.subj_tutor := subj_tutor;
        rec.subj_hours_w := subj_hours_w;
        rec.subj_hours_c := subj_hours_c;
        rec.subj_hours_l := subj_hours_l;
        rec.subj_hours_p := subj_hours_p;
        rec.subj_hours_s := subj_hours_s;
        rec.subj_credit_kind := subj_credit_kind;
        rec.subj_ects := subj_ects;

        RETURN rec;
    END;


    FUNCTION To_Subject_Conducted(row IN veetou_ko_refined%ROWTYPE)
        RETURN T_Subject_Conducted
    IS
    BEGIN
        RETURN Subject_Conducted( subj_code => row.subj_code
                                , subj_name => row.subj_name
                                , university => row.university
                                , faculty => row.faculty
                                , studies_modetier => row.studies_modetier
                                , studies_field => row.studies_field
                                , studies_specialty => row.studies_specialty
                                , semester_code => row.semester_code
                                , subj_tutor => row.subj_tutor
                                , subj_hours_w => row.subj_hours_w
                                , subj_hours_c => row.subj_hours_c
                                , subj_hours_l => row.subj_hours_l
                                , subj_hours_p => row.subj_hours_p
                                , subj_hours_s => row.subj_hours_s
                                , subj_credit_kind => row.subj_credit_kind
                                , subj_ects => row.subj_ects );
    END;

--    FUNCTION SubjectConducted_Cmp(lhs IN T_SubjectConducted,
--                                  rhs IN T_SubjectConducted)
--        RETURN BOOLEAN IS
--    BEGIN
--        RETURN (lhs.subj_code = rhs.subj_code AND
--                lsh.subj_name = rhs.subj_name AND
--                lhs.university = rhs.university AND
--                lhs.faculty = rhs.faculty AND
--                lhs.studies_modetier = rhs.studies_modetier AND
--                lhs.studies_field = rhs.studies_modetier AND
--                lhs.studies_specialty = rhs.studies_specialty AND
--                lhs.semester_code = rhs.semester_code AND
--                lhs.subj_tutor = rhs.subj_tutor AND
--                lhs.subj_hours_w = rhs.subj_hours_w AND
--                lhs.subj_hours_c = rhs.subj_hours_c AND
--                lhs.subj_hours_l = rhs.subj_hours_l AND
--                lhs.subj_hours_p = rhs.subj_hours_p AND
--                lhs.subj_hours_s = rhs.subj_hours_s AND
--                lhs.subj_credit_kind = rhs.subj_credit_kind AND
--                lhs.subj_ects = rhs.subj_ects);
--    END;

    FUNCTION Subject_Matches(subject IN T_Subject_Conducted,
                             transform IN VARCHAR,
                             value IN VARCHAR)
        RETURN BOOLEAN
    IS
        ret BOOLEAN;
    BEGIN
        ret := TRUE;
        RETURN ret;
    END;


    FUNCTION Matching_Subject_Mappings2(subject IN T_Subject_Conducted,
                                        rows IN T_Subject_Mappings_Rows)
        RETURN T_Subject_Mappings_Rows
    IS
        rows2 T_Subject_Mappings_Rows;
        r T_Subject_Mappings_Row;
    BEGIN
        rows2 := T_Subject_Mappings_Rows();
        FOR i IN 1 .. rows.COUNT LOOP
            r := rows(i);
            IF row.matcher IS NULL THEN
                rows2.extend;
                rows2(rows2.count) := r;
            ELSIF Subject_Matches(subject, r.matcher_name, r.discriminant) THEN
                rows2.extend;
                rows2(rows2.count) := r;
            THEN
            END IF;
        END LOOP;
        RETURN rows2;
    END;


    FUNCTION Matching_Subject_Mappings(subject IN T_Subject_Conducted)
        RETURN T_Subject_Mappings_Rows
    IS
        rows T_Subject_Mappings_Rows;
    BEGIN
        SELECT DISTINCT * BULK COLLECT INTO rows
            FROM veetou_subject_mappings sm
            WHERE sm.subj_code = subject.subj_code;

        IF rows.COUNT <= 1 THEN
            RETURN rows;
        ELSE
            RETURN Matching_Subject_Mappings2(subject, rows);
        END IF;
    END;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
