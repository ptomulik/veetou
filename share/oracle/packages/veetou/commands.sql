/****************************************************************************
 *                  This file is for SQL Developer users.
 *            Just place a cursor on a command and press F9.
 ****************************************************************************/

-- Recreates empty veetou schema. --
@@uninstall.sql;


-- Creates empty veetou schema. --
@@install.sql;


-- Wipes-out whole database and recreates empty schema. --
@@reinstall.sql;


-- Recreates views, materialized views, packages, and types (except those
-- related to tables).
@@recompile.sql;


-- Refreshes materialized views. Execute it every time you import new data to
-- tables.
@@refresh.sql;

-- vim: set ft=sql ts=4 sw=4 et:
