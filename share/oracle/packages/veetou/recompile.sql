@@pkg.pkg;

BEGIN
    V2U_Pkg.Uninstall('KEEP');
END;
/
DROP PACKAGE V2U_Pkg;

@@types/create_specs.sql;
@@packages/create_specs.sql;
@@types/create_bodies.sql;
@@packages/create_bodies.sql;
@@views/create_mview_logs.sql
@@views/create_views.sql;

-- vim: set ft=sql ts=4 sw=4 et:
