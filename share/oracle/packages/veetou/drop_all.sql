--
-- NOTE: This destroys all the veetou data and structure.
--

@@packages/drop.pkg;

BEGIN
    V2U_Drop.Secondaries();
    V2U_Drop.Primaries();
END;
/
DROP PACKAGE V2U_Drop;

-- vim: set ft=sql ts=4 sw=4 et:
