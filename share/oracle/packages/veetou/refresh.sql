BEGIN
    DBMS_MVIEW.REFRESH('v2u_ko_x_trs_mv');
    DBMS_MVIEW.REFRESH('v2u_ko_x_sheets_mv');
    DBMS_MVIEW.REFRESH('v2u_ko_subject_instances_mv');
    DBMS_MVIEW.REFRESH('v2u_ko_specialties_mv');
    DBMS_MVIEW.REFRESH('v2u_ko_mapped_subjects_mv');
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
