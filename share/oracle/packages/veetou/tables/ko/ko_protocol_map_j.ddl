CREATE TABLE v2u_ko_protocol_map_j
OF V2u_Ko_Protocol_Map_J_t
    (
          CONSTRAINT v2u_ko_protocol_map_j_pk
            PRIMARY KEY ( job_uuid
                        , semester_id
                        , specialty_id
                        , subject_id
                        , classes_type
                        , student_id
                        , map_id )
--        , CONSTRAINT v2u_ko_protocol_map_j_f0
--            FOREIGN KEY (job_uuid)
--            REFERENCES v2u_ko_jobs(job_uuid)
--        , CONSTRAINT v2u_ko_protocol_map_j_f1
--            FOREIGN KEY (subject_id, job_uuid)
--            REFERENCES v2u_ko_protocols(id, job_uuid)
--        , CONSTRAINT v2u_ko_protocol_map_j_f2
--            FOREIGN KEY (specialty_id, job_uuid)
--            REFERENCES v2u_ko_specialties(id, job_uuid)
--        , CONSTRAINT v2u_ko_protocol_map_j_f3
--            FOREIGN KEY (semester_id, job_uuid)
--            REFERENCES v2u_ko_semesters(id, job_uuid)
--        , CONSTRAINT v2u_ko_protocol_map_j_f4
--            FOREIGN KEY (map_id)
--            REFERENCES v2u_protocol_map(id)
--        , CONSTRAINT v2u_ko_protocol_map_j_f5
--            FOREIGN KEY (job_uuid, subject_id, specialty_id, semester_id)
--            REFERENCES v2u_ko_protocol_semesters_j(job_uuid, subject_id, specialty_id, semester_id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
--CREATE INDEX v2u_ko_protocol_map_j_idx1
--       ON v2u_ko_protocol_map_j(selected)
--/
--CREATE INDEX v2u_ko_protocol_map_j_idx2
--       ON v2u_ko_protocol_map_j(reason)
--/
--CREATE INDEX v2u_ko_protocol_map_j_idx3
--       ON v2u_ko_protocol_map_j(selected, reason)
--/
--CREATE INDEX v2u_ko_protocol_map_j_idx4
--       ON v2u_ko_protocol_map_j(job_uuid, subject_id, specialty_id, semester_id)
--/
--CREATE INDEX v2u_ko_protocol_map_j_idx5
--       ON v2u_ko_protocol_map_j(job_uuid, subject_id, specialty_id, semester_id, selected)
--/
-- vim: set ft=sql ts=4 sw=4 et:
