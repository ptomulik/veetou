CREATE TABLE v2u_ko_tbodies
OF V2u_Ko_Tbody_t
    (
      CONSTRAINTS v2u_ko_tbodies_pk PRIMARY KEY (job_uuid, id)
    , CONSTRAINTS v2u_ko_tbodies_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    );

COMMENT ON TABLE v2u_ko_tbodies IS 'Ciała tabel znajdujących sie Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_tbodies.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_tbodies.id IS 'Lokalny identyfikator ciała tabeli';
COMMENT ON COLUMN v2u_ko_tbodies.remark IS 'Uwagi zapisane w obszarze ciała tabeli';

-- vim: set ft=sql ts=4 sw=4 et:
