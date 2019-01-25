CREATE SEQUENCE v2u_ko_subject_instances_sq1 START WITH 1;
/
CREATE TABLE v2u_ko_subject_instances
OF V2u_Ko_Subject_Instance_t
    (
          CONSTRAINT v2u_ko_subject_instances_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
VARRAY subj_grades STORE AS LOB (ENABLE STORAGE IN ROW)
NESTED TABLE tr_ids STORE AS v2u_ko_subj_inst_trs_nt
AS WITH u AS
    (
        SELECT
              VALUE(trs) tr
            , V2u_To.Ko_Subject_Instance(
                      VALUE(trs).job_uuid
                    , NULL
                    , VALUE(headers)
                    , VALUE(preambles)
                    , VALUE(trs)
                    )
              subj_instance

        FROM v2u_ko_tbody_trs tbody_trs
        INNER JOIN v2u_ko_trs trs
            ON (tbody_trs.ko_tr_id = trs.id AND
                tbody_trs.job_uuid = trs.job_uuid)
        INNER JOIN v2u_ko_tbodies tbodies
            ON (tbody_trs.ko_tbody_id = tbodies.id AND
                tbody_trs.job_uuid = tbodies.job_uuid)
        INNER JOIN v2u_ko_page_tbody page_tbody
            ON (page_tbody.ko_tbody_id = tbodies.id AND
                page_tbody.job_uuid = tbodies.job_uuid)
        INNER JOIN v2u_ko_pages pages
            ON (page_tbody.ko_page_id = pages.id AND
                page_tbody.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_page_header page_header
            ON (page_header.ko_page_id = pages.id AND
                page_header.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_headers headers
            ON (page_header.ko_header_id = headers.id AND
                page_header.job_uuid = headers.job_uuid)
        INNER JOIN v2u_ko_page_preamble page_preamble
            ON (page_preamble.ko_page_id = pages.id AND
                page_preamble.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_preambles preambles
            ON (page_preamble.ko_preamble_id = preambles.id AND
                page_preamble.job_uuid = preambles.job_uuid)
    ),
    v AS
    (
        SELECT
              subj_instance
            , CAST(COLLECT(tr) AS V2u_Ko_Trs_t) trs
        FROM u u
        GROUP BY subj_instance
        ORDER BY subj_instance
    ),
    w AS
    (
        SELECT
              subj_instance
            -- 1. COLLECT(DISTINCT...) seems to be broken ("DISTINCT" is ignored)
            -- 2. COLLECT(s) with s VARCHAR2 is unpredictable - it returns a
            --    collection of VARCHAR2(n) with "n" unknown.
            , CAST(MULTISET(
                    SELECT t.id FROM TABLE(trs) t
                ) AS V2u_Ko_Ids_t) tr_ids
            , CAST(MULTISET(
                    SELECT DISTINCT t.subj_grade FROM TABLE(trs) t
                    ORDER BY t.subj_grade
              ) AS V2u_Subj_Grades20_t) distinct_subj_grades
        FROM v v
    )
SELECT
      w.subj_instance.job_uuid
    , V2u_Util.Next_Val('v2u_ko_subject_instances_sq1')
    , w.subj_instance.subj_code
    , w.subj_instance.subj_name
    , w.subj_instance.university
    , w.subj_instance.faculty
    , w.subj_instance.studies_modetier
    , w.subj_instance.studies_field
    , w.subj_instance.studies_specialty
    , w.subj_instance.semester_code
    , w.subj_instance.subj_hours_w
    , w.subj_instance.subj_hours_c
    , w.subj_instance.subj_hours_l
    , w.subj_instance.subj_hours_p
    , w.subj_instance.subj_hours_s
    , w.subj_instance.subj_credit_kind
    , w.subj_instance.subj_ects
    , w.subj_instance.subj_tutor
    , w.distinct_subj_grades
    , w.tr_ids
FROM w w;
/

CREATE OR REPLACE TRIGGER v2u_ko_subject_instances_tr1
    BEFORE INSERT ON v2u_ko_subject_instances
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_subject_instances_sq1.NEXTVAL INTO :new.id FROM dual;
    END;

-- vim: set ft=sql ts=4 sw=4 et:
