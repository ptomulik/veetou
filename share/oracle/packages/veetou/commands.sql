/****************************************************************************
 *                  This file is for SQL Developer users.
 *            Just place a cursor on a command and press F9.
 ****************************************************************************/

-- Whipes-out whole database. --
@@drop_primaries.sql;


-- Creates empty veetou schema (first time, or after uninstall). --
@@create_primaries.sql;



-- Wipes-out whole database and recreates empty schema. --
-- This is merely a sequence of @@uninstall.sql and @@install.sql
@@recreate_primaries.sql;



-- Drops views, packages, secondary tables and types.
@@drop_secondaries.sql;



-- Creates views, packages, secondary tables and types.
@@create_secondaries.sql;



-- Drops and then recreates views, packages, secondary tables and types.
@@recreate_secondaries.sql;


-- Merge data from primary tables into secondary tables
@reload_secondaries.sql;

-- vim: set ft=sql ts=4 sw=4 et:
