/****************************************************************************
 *                  This file is for SQL Developer users.
 *            Just place a cursor on a command and press F9.
 ****************************************************************************/

-- Whipes-out whole database. --
@@uninstall.sql;


-- Creates empty veetou schema (first time, or after uninstall). --
@@install.sql;



-- Wipes-out whole database and recreates empty schema. --
-- This is merely a sequence of @@uninstall.sql and @@install.sql
@@reinstall.sql;



-- Drops views, packages, secondary tables and types.
@@uncompile.sql;



-- Creates views, packages, secondary tables and types.
@@compile.sql;



-- Drops and then recreates views, packages, secondary tables and types.
@@recompile.sql;


@@merge.sql;


-- vim: set ft=sql ts=4 sw=4 et:
