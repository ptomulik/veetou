CREATE TABLE v2u_ux_programy_osob
OF V2u_Ux_Program_Osoby_t
    (
          CONSTRAINT v2u_ux_programy_osob_pk
            PRIMARY KEY (pk_student_index, pk_program_osoby, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_programy_osob_idx1 ON v2u_ux_programy_osob(st_id);
/
CREATE INDEX v2u_ux_programy_osob_idx2 ON v2u_ux_programy_osob(os_id);
/
CREATE INDEX v2u_ux_programy_osob_idx3 ON v2u_ux_programy_osob(st_id, os_id);
/
CREATE INDEX v2u_ux_programy_osob_idx4 ON v2u_ux_programy_osob(st_id, os_id, prg_kod);
-- vim: set ft=sql ts=4 sw=4 et:
