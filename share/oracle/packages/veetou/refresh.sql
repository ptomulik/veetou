BEGIN
    DBMS_MVIEW.REFRESH('v2u_ko_x_trs,v2u_ko_x_sheets');
    DBMS_MVIEW.REFRESH('v2u_ko_subject_instances');
    DBMS_MVIEW.REFRESH('v2u_ko_specialties');
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
