/****************************************************************************
 *                  This file is for SQL Developer users.
 *            Just place a cursor on a command and press F9.
 ****************************************************************************/


-- Creates empty veetou schema (first time, or after uninstall). --
@@create_all.sql;



-- Wipes-out whole database. --
@@drop_all.sql;



-- Wipe-out whole databse and create the emtpy schema from scratch.
@@drop_create_all.sql;



-- Creates primary tables, types, packages, etc...
@@create_primaries.sql;



-- Wipes-out what was created by @@create_primaries.sql
@@drop_primaries.sql;



-- Wipes-out primaries and creates them from scratch.
@@drop_create_primaries.sql;



-- Creates secondary types, tables, views, packages, etc.
@@create_secondaries.sql;



-- Drops what was created by @@create_secondaries.sql;
@@drop_secondaries.sql;



-- Drops and then drop_creates views, packages, secondary tables and types.
@@drop_create_secondaries.sql;



-- Merge data from primary tables into secondary tables.
@reload_secondaries.sql;

-- vim: set ft=sql ts=4 sw=4 et:
