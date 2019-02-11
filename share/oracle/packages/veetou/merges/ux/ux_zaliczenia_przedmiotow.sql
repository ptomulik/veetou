MERGE INTO v2u_ux_zaliczenia_przedmiotow tgt
USING
    (
        SELECT
              g_j.subj_grade
            , g_j.subj_grade_date
            , '?' status_rej
            , '?' status_zal
            , me_j.os_id
            , mp_j.cdyd_kod
            , mp_j.prz_kod
        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_matched_etpos_j me_j
            ON (me_j.student_id = g_j.student_id AND
                me_j.specialty_id = g_j.specialty_id AND
                me_j.semester_id = g_j.semester_id AND
                me_j.job_uuid = g_j.job_uuid)
        INNER JOIN v2u_ko_matched_przcykl_j mp_j
            ON (mp_j.subject_id = g_j.subject_id AND
                mp_j.specialty_id = g_j.specialty_id AND
                mp_j.semester_id = g_j.semester_id AND
                mp_j.job_uuid = g_j.job_uuid)
    ) src
ON  (tgt.prz_kod = src.prz_kod AND
     tgt.cdyd_kod = src.cdyd_kod AND
     tgt.os_id = src.os_id)
WHEN NOT MATCHED THEN
    INSERT
        ( status_rej
--        , opis_statusu_rej
        , status_zal
 --       , opis_statusu_zal
--        , suma_ocen
--        , liczba_ocen
        , os_id
        , cdyd_kod
        , prz_kod
--        , utw_data
--        , utw_id
--        , mod_id
--        , mod_data
--        , nr_wyb
        )
    VALUES
        ( src.status_rej
--        , src.opis_statusu_rej
        , src.status_zal
--        , src.opis_statusu_zal
--        , src.suma_ocen
--        , src.liczba_ocen
        , src.os_id
        , src.cdyd_kod
        , src.prz_kod
--        , src.utw_data
--        , src.utw_id
--        , src.mod_id
--        , src.mod_data
--        , src.nr_wyb
        )
WHEN MATCHED THEN UPDATE SET
          tgt.status_rej = src.status_rej
--        , tgt.opis_statusu_rej = src.opis_statusu_rej
        , tgt.status_zal = src.status_zal
--        , tgt.opis_statusu_zal = src.opis_statusu_zal
--        , tgt.suma_ocen = src.suma_ocen
--        , tgt.liczba_ocen = src.liczba_ocen
--        , tgt.utw_data = src.utw_data
--        , tgt.utw_id = src.utw_id
--        , tgt.mod_id = src.mod_id
--        , tgt.mod_data = src.mod_data
--        , tgt.nr_wyb = src.nr_wyb
;
-- vim: set ft=sql ts=4 sw=4 et:
