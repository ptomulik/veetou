CREATE OR REPLACE VIEW v2u_ko_skipped_programs_v
OF V2u_Ko_Skipped_Program_V_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_id, semester_id, prg_kod)
AS
    SELECT
        V2u_Ko_Skipped_Program_V_t(
              specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , where_tryb_studiow => sp_j.where_tryb_studiow
            , where_rodzaj_studiow => sp_j.where_rodzaj_studiow
            , where_jed_org_kod_podst => sp_j.where_jed_org_kod_podst
            , where_opis_like => sp_j.where_opis_like
            , program => VALUE(programy)
        )
    FROM v2u_ko_skipped_programs_j sp_j
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = sp_j.specialty_id
                AND specialties.job_uuid = sp_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = sp_j.semester_id
                AND semesters.job_uuid = sp_j.job_uuid
            )
    INNER JOIN v2u_dz_programy programy
        ON  (
                    programy.kod = sp_j.prg_kod
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
