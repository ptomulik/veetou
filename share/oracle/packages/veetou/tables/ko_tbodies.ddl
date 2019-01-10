CREATE TABLE veetou_ko_tbodies
     ( job_uuid RAW(16) NOT NULL
     , id NUMBER(38) NOT NULL
     , remark VARCHAR(256)
     , CONSTRAINTS veetou_ko_tbodies_pk PRIMARY KEY (job_uuid, id)
     , CONSTRAINTS veetou_ko_tbodies_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid));

COMMENT ON TABLE veetou_ko_tbodies IS 'Ciała tabel znajdujących sie Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_tbodies.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_tbodies.id IS 'Lokalny identyfikator ciała tabeli';
COMMENT ON COLUMN veetou_ko_tbodies.remark IS 'Uwagi zapisane w obszarze ciała tabeli';

-- vim: set ft=sql ts=4 sw=4 et:
