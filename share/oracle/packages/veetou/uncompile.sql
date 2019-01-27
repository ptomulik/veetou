@@pkg.pkg;

BEGIN
    V2U_Pkg.Uninstall('KEEP');
END;
/
DROP PACKAGE V2U_Pkg;
COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
