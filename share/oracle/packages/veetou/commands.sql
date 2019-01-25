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



-- Drops views, materialized views, packages, and some types (except those
-- related to tables). This does not touch tables.
@@uncompile.sql;



-- Creates views, materialized views, packages, and types (except
-- those related to tables). This does not touch tables.
@@compile.sql;



-- Drops and then recreates views, materialized views, packages, and types
-- (except those related to tables). This does not touch tables.
@@recompile.sql;



-- Refreshes materialized views. Execute it every time you (re)install/
-- (re)compile the project or import new data to tables. This operation may be
-- quite time-consuming.
@@refresh.sql;

-- vim: set ft=sql ts=4 sw=4 et:
