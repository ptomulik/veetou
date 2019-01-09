CREATE OR REPLACE PACKAGE BODY VEETOU_Func AS
    FUNCTION SubjectConducted(row IN TKoRefinedRow) RETURN TSubjectConducted IS
        rec TSubjectConducted;
    BEGIN
        rec.subj_code = row.subj_code;
        rec.subj_name = row.subj_name;
        rec.university = row.university;
        rec.faculty = row.faculty;
        rec.studies_modetier = row.studies_modetier;
        rec.studies_field = row.studies_field;
        rec.studies_specialty = row.studies_specialty;
        rec.semester_code = row.semester_code;
        rec.subj_tutor = row.subj_tutor;
        rec.subj_hours_w = row.subj_hours_w;
        rec.subj_hours_c = row.subj_hours_c;
        rec.subj_hours_l = row.subj_hours_l;
        rec.subj_hours_p = row.subj_hours_p;
        rec.subj_hours_s = row.subj_hours_s;
        rec.subj_credit_kind = row.subj_credit_kind;
        rec.subj_ects = row.subj_ects;

        RETURN rec;
    END;

    FUNCTION SubjectConducted_Cmp(lhs IN TSubjectConducted,
                                  rhs IN TSubjectConducted)
        RETURN BOOLEAN IS
    BEGIN
        RETURN (lhs.subj_code = rhs.subj_code AND
                lsh.subj_name = rhs.subj_name AND
                lhs.university = rhs.university AND
                lhs.faculty = rhs.faculty AND
                lhs.studies_modetier = rhs.studies_modetier AND
                lhs.studies_field = rhs.studies_modetier AND
                lhs.studies_specialty = rhs.studies_specialty AND
                lhs.semester_code = rhs.semester_code AND
                lhs.subj_tutor = rhs.subj_tutor AND
                lhs.subj_hours_w = rhs.subj_hours_w AND
                lhs.subj_hours_c = rhs.subj_hours_c AND
                lhs.subj_hours_l = rhs.subj_hours_l AND
                lhs.subj_hours_p = rhs.subj_hours_p AND
                lhs.subj_hours_s = rhs.subj_hours_s AND
                lhs.subj_credit_kind = rhs.subj_credit_kind AND
                lhs.subj_ects = rhs.subj_ects);
    END;
END VEETOU_Func;

-- vim: set ft=sql ts=4 sw=4 et:
