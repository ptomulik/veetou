CREATE TABLE v2u_ux_grades_flat
OF V2u_Ux_Grade_Flat_t
    (
          CONSTRAINT v2u_ux_grades_flat_pk
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

CREATE INDEX v2u_ux_grades_flat_idx1
    ON v2u_ux_grades_flat(os_id);
CREATE INDEX v2u_ux_grades_flat_idx2
    ON v2u_ux_grades_flat(st_id);
CREATE INDEX v2u_ux_grades_flat_idx3
    ON v2u_ux_grades_flat(etpos_id);
CREATE INDEX v2u_ux_grades_flat_idx4
    ON v2u_ux_grades_flat(prgos_id);
--
CREATE INDEX v2u_ux_grades_flat_idx5
    ON v2u_ux_grades_flat(prg_kod);
CREATE INDEX v2u_ux_grades_flat_idx6
    ON v2u_ux_grades_flat(prz_kod);
CREATE INDEX v2u_ux_grades_flat_idx8
    ON v2u_ux_grades_flat(prz_kod, cdyd_kod);
CREATE INDEX v2u_ux_grades_flat_idx9
    ON v2u_ux_grades_flat(prz_kod, cdyd_kod, tzaj_kod);

CREATE INDEX v2u_ux_grades_flat_idx10
    ON v2u_ux_grades_flat(
          v2u_job_uuid
        , v2u_student_id
        , v2u_subject_id
        , v2u_specialty_id
        , v2u_semester_id
    );

-- vim: set ft=sql ts=4 sw=4 et:
