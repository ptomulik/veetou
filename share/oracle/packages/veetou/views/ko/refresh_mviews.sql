BEGIN
    DBMS_MVIEW.REFRESH('v2u_ko_tr_hdr_preamb_h');
    DBMS_MVIEW.REFRESH('v2u_ko_sh_hdr_preamb_h');
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
