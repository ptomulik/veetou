CREATE TABLE v2u_ko_tbody_trs
     ( job_uuid RAW(16) NOT NULL
     , ko_tbody_id NUMBER(38)
     , ko_tr_id NUMBER(38)
     , CONSTRAINT v2u_ko_tbody_trs_pk PRIMARY KEY (job_uuid, ko_tbody_id, ko_tr_id)
     , CONSTRAINT v2u_ko_tbody_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
     , CONSTRAINT v2u_ko_tbody_trs_fk1 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES v2u_ko_tbodies(job_uuid, id)
     , CONSTRAINT v2u_ko_tbody_trs_fk2 FOREIGN KEY (job_uuid, ko_tr_id) REFERENCES v2u_ko_trs(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
