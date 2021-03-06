/****************************************************************************
 *                  This file is for SQL Developer users.
 *            Just place a cursor on a command and press F9.
 ****************************************************************************/

-- Disaster prevention (we don't want to run all the commands below at once).
EXIT;



-- Creates empty veetou schema (first time, or after uninstall). --
@@tiers/create_all.sql;



-- Wipes-out whole database. --
@@tiers/drop_all.sql;



-- Wipe-out whole databse and create the emtpy schema from scratch.
@@tiers/drop_create_all.sql;



-- Creates tier1 tables, types, packages, etc...
@@tiers/create_tier1.sql;



-- Wipes-out what was created by @@create_tier1.sql
@@tiers/drop_tier1.sql;



-- Wipes-out tier1 and creates them from scratch.
@@tiers/drop_create_tier1.sql;



-- Creates parts of tier1 not related to dz_*, ko_*, etc..
@@tiers/create_tier1_basis.sql



-- Wipes-out tier1 part not related to dz_*, ko_*, etc.
@@tiers/drop_tier1_basis.sql



-- Creates tier1 dz_* tables and related stuff.
@@tiers/create_tier1_dz.sql



-- Wipes-out tier1 part related to dz_* tables.
@@tiers/drop_tier1_dz.sql



-- Creates tier1 ko_* tables and related stuff.
@@tiers/create_tier1_ko.sql



-- Wipes-out tier1 part related to ko_* tables.
@@tiers/drop_tier1_ko.sql



-- Creates tier2 types, tables, views, packages, etc.
@@tiers/create_tier2.sql;



-- Drops what was created by @@create_tier2.sql;
@@tiers/drop_tier2.sql;



-- Drops and then drop_creates views, packages, tier2 tables and types.
@@tiers/drop_create_tier2.sql;



-- Creates tier3 types, tables, views, packages, etc.
@@tiers/create_tier3.sql;



-- Drops what was created by @@create_tier3.sql;
@@tiers/drop_tier3.sql;



-- Drops and then drop_creates views, packages, tier3 tables and types.
@@tiers/drop_create_tier3.sql;



-- Merge data from dz_* tables to v2u_dz_* tables
@@tiers/merge_tier1_dz.sql;


-- Merge data into v2u_ko_* tables
@@tiers/merge_tier2_ko.sql;



-- Merge data into v2u_uu_* tables
@@tiers/merge_tier2_uu.sql;



-- Merge data from tier1 tables into tier2 tables.
@@tiers/merge_tier2.sql;

-- vim: set ft=sql ts=4 sw=4 et:
