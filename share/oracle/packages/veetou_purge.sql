
--
-- Drops VEETOU TABLES, INDEXES, VIEWS, etc. Tables are PURGED.
--
-- NOTE: This does not drop VEETOU PL/SQL PACKAGES and PROCEDURES.
--

BEGIN
  Veetou_Drop(TRUE);
END;
