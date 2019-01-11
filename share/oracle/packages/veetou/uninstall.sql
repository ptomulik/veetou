--
-- NOTE: This destroys all the veetou data and structure.
--

@@uninstall.pkg;

BEGIN
    VEETOU_Uninstall.Uninstall(TRUE);
END;
/
DROP PACKAGE VEETOU_Uninstall;

-- vim: set ft=sql ts=4 sw=4 et:
-- vim: set ft=sql ts=4 sw=4 et:
