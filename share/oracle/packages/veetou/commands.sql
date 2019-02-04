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



-- Creates tier1 tables, types, packages, etc...
@@create_tier1.sql;



-- Wipes-out what was created by @@create_tier1.sql
@@drop_tier1.sql;



-- Wipes-out tier1 and creates them from scratch.
@@drop_create_tier1.sql;



-- Creates tier2 types, tables, views, packages, etc.
@@create_tier2.sql;



-- Drops what was created by @@create_tier2.sql;
@@drop_tier2.sql;



-- Drops and then drop_creates views, packages, tier2 tables and types.
@@drop_create_tier2.sql;



-- Merge data from tier1 tables into tier2 tables.
@reload_tier2.sql;



-- Creates tier3 types, tables, views, packages, etc.
@@create_tier3.sql;



-- Drops what was created by @@create_tier3.sql;
@@drop_tier3.sql;



-- Drops and then drop_creates views, packages, tier3 tables and types.
@@drop_create_tier3.sql;

-- vim: set ft=sql ts=4 sw=4 et:
