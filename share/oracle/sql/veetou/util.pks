CREATE OR REPLACE PACKAGE VEETOU_Util AUTHID CURRENT_USER AS
    PROCEDURE Drop_Table_If_Exists(name IN VARCHAR, how IN VARCHAR := '');
    PROCEDURE Drop_Index_If_Exists(name IN VARCHAR, how IN VARCHAR := '');
    PROCEDURE Drop_View_If_Exists(name IN VARCHAR, how IN VARCHAR := '');

    PROCEDURE Create_Table_If_Not_Exists(name IN VARCHAR, decl IN LONG);
    PROCEDURE Create_Index_If_Not_Exists(name IN VARCHAR, decl IN LONG);
    PROCEDURE Create_View_If_Not_Exists(name IN VARCHAR, decl IN LONG);

    PROCEDURE Comment_On_Table(name IN VARCHAR, str IN VARCHAR);
    PROCEDURE Comment_On_Column(name IN VARCHAR, str IN VARCHAR);
END VEETOU_Util;

-- vim: ft=sql ts=4 sw=4 et:
