CREATE VIEW veetou_ko_footers_ov AS
    SELECT Veetou_Ko_Footer_Typ
        ( job_uuid => f.job_uuid
        , id => f.id
        , pagination => f.pagination
        , sheet_page_number => f.sheet_page_number
        , sheet_pages_total => f.sheet_pages_total
        , generator_name => f.generator_name
        , generator_home => f.generator_home
        )
    AS footer
    FROM Veetou_Ko_Footers  f;

-- vim: set ft=sql ts=4 sw=4 et:
