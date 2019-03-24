--
-- NOTE: This destroys all the veetou data and structure.
--

@@packages/drop.pkg;

BEGIN
    V2U_Drop.Tier1_Uv();
END;
/
DROP PACKAGE V2U_Drop;
/
COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
