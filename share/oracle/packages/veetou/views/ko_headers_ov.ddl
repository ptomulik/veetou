CREATE OR REPLACE VIEW v2u_ko_headers_ov
OF V2u_Ko_Header_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.university
        , t.faculty
FROM v2u_ko_headers t;

-- vim: set ft=sql ts=4 sw=4 et:
