CREATE MATERIALIZED VIEW v2u_ko_subject_instances_mv
OF V2u_Ko_Subject_Instance_t
    VARRAY subj_grades STORE AS LOB (ENABLE STORAGE IN ROW)
    NESTED TABLE tr_ids STORE AS v2u_ko_subj_inst_tr_ids_nt
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT *
FROM v2u_ko_subject_instances_dv;

-- vim: set ft=sql ts=4 sw=4 et:
