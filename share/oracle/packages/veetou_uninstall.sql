--
-- Drops VEETOU PL/SQL PACKAGES and PROCEDURES
--
-- NOTE: this does not drop TABLES, and other data structures.
--

BEGIN
  Veetou_Uninstall;
END;
/
DROP PROCEDURE Veetou_Uninstall;
