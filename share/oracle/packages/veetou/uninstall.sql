--
-- NOTE: This destroys all the veetou data and structure.
--

@@pkg.pkg;

BEGIN
    VEETOU_Pkg.Uninstall('PURGE');
END;
/
DROP PACKAGE VEETOU_Pkg;

-- vim: set ft=sql ts=4 sw=4 et:
