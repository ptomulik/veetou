--
-- NOTE: This destroys all the veetou data and structure.
--

@@pkg.pkg;

BEGIN
    V2U_Pkg.Uninstall('CASCADE CONSTRAINTS PURGE');
END;
/
DROP PACKAGE V2U_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
