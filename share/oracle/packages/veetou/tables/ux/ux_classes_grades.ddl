CREATE TABLE v2u_ux_classes_grades
OF V2u_Ux_Classes_Grade_t
    (
          CONSTRAINT v2u_ux_classes_grades_pk
            PRIMARY KEY (
                  v2u_job_uuid
                , v2u_student_id
                , v2u_subject_id
                , v2u_specialty_id
                , v2u_semester_id
                , v2u_classes_type
                )
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

CREATE INDEX v2u_ux_classes_grades_idx1
    ON v2u_ux_classes_grades(os_id);
CREATE INDEX v2u_ux_classes_grades_idx2
    ON v2u_ux_classes_grades(st_id);
CREATE INDEX v2u_ux_classes_grades_idx3
    ON v2u_ux_classes_grades(etpos_id);
CREATE INDEX v2u_ux_classes_grades_idx4
    ON v2u_ux_classes_grades(prgos_id);
--
CREATE INDEX v2u_ux_classes_grades_idx5
    ON v2u_ux_classes_grades(prg_kod);
CREATE INDEX v2u_ux_classes_grades_idx6
    ON v2u_ux_classes_grades(prz_kod);
CREATE INDEX v2u_ux_classes_grades_idx8
    ON v2u_ux_classes_grades(prz_kod, cdyd_kod);
CREATE INDEX v2u_ux_classes_grades_idx9
    ON v2u_ux_classes_grades(prz_kod, cdyd_kod, tzaj_kod);

CREATE INDEX v2u_ux_classes_grades_idx10
    ON v2u_ux_classes_grades(
          v2u_job_uuid
        , v2u_student_id
        , v2u_subject_id
        , v2u_specialty_id
        , v2u_semester_id
    );

-- vim: set ft=sql ts=4 sw=4 et:
