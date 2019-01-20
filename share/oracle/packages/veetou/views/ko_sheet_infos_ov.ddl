CREATE OR REPLACE VIEW veetou_ko_sheet_infos_ov
AS SELECT
      job_uuid
    , header_id
    , preamble_id
    , sheet_id
    , Veetou_Ko_Sheet_Info_Typ(header, preamble, sheet) sheet_info
FROM veetou_ko_x_sheets_ov;



-- vim: set ft=sql ts=4 sw=4 et:
