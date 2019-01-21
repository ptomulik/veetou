CREATE OR REPLACE VIEW v2u_ko_sheet_infos_ov
AS SELECT
      job_uuid
    , header_id
    , preamble_id
    , sheet_id
    , V2u_Ko_Sheet_Info_t(header, preamble, sheet) sheet_info
FROM v2u_ko_x_sheets_ov;



-- vim: set ft=sql ts=4 sw=4 et:
