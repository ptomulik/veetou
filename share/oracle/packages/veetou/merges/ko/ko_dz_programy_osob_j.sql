MERGE INTO v2u_ko_dz_programy_osob_j tgt
USING
    (
        SELECT
              j.job_uuid ko_job_uuid
            , j.id ko_thread_id
            , programy_osob.id dz_programy_osob_id
        FROM v2u_ko_student_threads_j j
        INNER JOIN v2u_ko_students students
            ON (students.id = j.student_id AND
                students.job_uuid = j.job_uuid)
        LEFT JOIN v2u_specialty_map specialty_map
            ON (specialty_map.id = j.specialty_map_id)
        INNER JOIN v2u_dz_studenci studenci
            ON (studenci.indeks = students.student_index)
        INNER JOIN v2u_dz_programy_osob programy_osob
            ON (programy_osob.os_id = studenci.os_id AND
                programy_osob.st_id = studenci.id AND
                programy_osob.prg_kod = specialty_map.map_program_code AND
                programy_osob.data_przyjecia = V2U_Get.Semester(j.max_admission_semester).start_date)
    ) src
ON  (tgt.ko_job_uuid = src.ko_job_uuid AND
     tgt.ko_thread_id = src.ko_thread_id AND
     tgt.dz_programy_osob_id = src.dz_programy_osob_id)
WHEN NOT MATCHED THEN
    INSERT (    ko_job_uuid,     ko_thread_id,     dz_programy_osob_id)
    VALUES (src.ko_job_uuid, src.ko_thread_id, src.dz_programy_osob_id);

-- vim: set ft=sql ts=4 sw=4 et:
