--@@types/create_specs.sql;
@@types/create_secondary_specs.sql;
COMMIT;
@@packages/create_specs.sql;
COMMIT;
@@types/create_bodies.sql;
COMMIT;
@@packages/create_bodies.sql;
COMMIT;
@@tables/create_secondary_tables.sql;
COMMIT;
@@views/create_views.sql;
COMMIT;
@@merges/execute_merges.sql;
COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
