--
-- NOTE: This destroys all the veetou data and structure.
--

@@packages/drop.pkg;

BEGIN
    V2U_Drop.Tier4();
    V2U_Drop.Tier3();
    V2U_Drop.Tier2();
    V2U_Drop.Tier1();
END;
/
DROP PACKAGE V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
