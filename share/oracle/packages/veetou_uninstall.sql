--
-- Does the reverse of veetou_install.sql
--
-- NOTE: This destroys all the veetou data and structure.
--

@@veetou/uninstall.pkg;

BEGIN
    VEETOU_Uninstall.Uninstall(TRUE);
END;
/
DROP PACKAGE VEETOU_Uninstall;

-- vim: set ft=sql ts=4 sw=4 et:
