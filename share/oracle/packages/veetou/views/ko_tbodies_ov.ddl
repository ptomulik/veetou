CREATE OR REPLACE VIEW v2u_ko_tbodies_ov
OF V2u_Ko_Tbody_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.remark
FROM v2u_ko_tbodies t;

-- vim: set ft=sql ts=4 sw=4 et:
