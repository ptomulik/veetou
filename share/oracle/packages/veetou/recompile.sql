@@pkg.pkg;

BEGIN
    VEETOU_Pkg.Uninstall('KEEP');
END;
/
DROP PACKAGE VEETOU_Pkg;

@@types/create_specs.sql;
@@packages/create_specs.sql;
@@types/create_bodies.sql;
@@packages/create_bodies.sql;
--@@tables/create_tables.sql; -- we keep old tables with data
--@@junctions/create_tables.sql; -- we keep old tables with data
@@tables/create_views.sql;
@@views/create_views.sql;

-- vim: set ft=sql ts=4 sw=4 et:
