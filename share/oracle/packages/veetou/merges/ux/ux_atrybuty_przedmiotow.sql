MERGE INTO v2u_ux_atrybuty_przedmiotow
USING
    (
        WITH u AS
        (
            SELECT
        )
    )
ON  (
    )
WHEN NOT MATCHED THEN
    INSERT
        (
        )
    VALUES
        (
        )
WHEN MATCHED THEN
    UPDATE SET
        tgt.xxx = src.xxx
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
