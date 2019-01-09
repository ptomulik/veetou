CREATE OR REPLACE PACKAGE BODY VEETOU_Schema AS
    PROCEDURE Create_Subject_Selectors IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_subject_selectors',
            '( func VARCHAR(20 CHAR) NOT NULL
             , description VARCHAR(200 CHAR)
             , CONSTRAINT veetou_subject_selectors_u1 UNIQUE (func))'
        );
    END;


    PROCEDURE Create_Subject_Mappings IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_subject_mappings',
            '( id NUMBER NOT NULL
             , subj_code VARCHAR(20 CHAR) NOT NULL
             , usos_subj_code VARCHAR(20 CHAR)
             , selector_func VARCHAR(20 CHAR)
             , selector_args VARCHAR(200 CHAR)
             , CONSTRAINT veetou_subject_mappings_uniq1 UNIQUE
               (
                 subj_code
               , selector_func
               , selector_args)
             , CONSTRAINT veetou_subject_mappings_fk1
                    FOREIGN KEY (selector_func)
                    REFERENCES veetou_subject_selectors(func))'
        );
        VEETOU_Util.Comment_On_Table('veetou_subject_mappings', 'Odwzorowanie kodów przedmiotów (VEE->USOS)');
        VEETOU_Util.Comment_On_Column('veetou_subject_mappings.subj_code', 'Kod przedmiotu (VEE)');
        VEETOU_Util.Comment_On_Column('veetou_subject_mappings.usos_subj_code', 'Kod przedmiotu (USOS)');
        VEETOU_Util.Comment_On_Column('veetou_subject_mappings.selector_func', 'Funkcja wyróżniająca (dla niejednoznacznych odwzorowań)');
        VEETOU_Util.Comment_On_Column('veetou_subject_mappings.selector_args', 'Wyróżnik (dla niejednoznacznych odwzorowań)');
    END;


    PROCEDURE Create_Tables IS
    BEGIN
      Create_Subject_Selectors;
      Create_Subject_Mappings;
    END;


    PROCEDURE Create_Indexes IS
    BEGIN
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_subject_mappings_idx1',
            'ON veetou_subject_mappings(subj_code)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_subject_mappings_idx2',
            'ON veetou_subject_mappings(usos_subj_code)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_subject_mappings_idx3',
            'ON veetou_subject_mappings(subj_code, selector_func)'
        );
    END;


    --
    -- VIEWS
    --

    PROCEDURE Create_Views AS
    BEGIN
        NULL;
    END;

    PROCEDURE Create_Schema AS
    BEGIN
        --
        -- NOTE: the order is important here!
        --

        Create_Tables;
        Create_Indexes;
        Create_Views;
    END;

    PROCEDURE Drop_Schema(purge IN BOOLEAN := FALSE) AS
        how VARCHAR(100);
    BEGIN

        --
        -- NOTE: the order is important here!
        --

        -- DROP VIEWS

        -- DROP INDEXES
        VEETOU_Util.Drop_Index_If_Exists('veetou_subject_mappings_idx1');
        VEETOU_Util.Drop_Index_If_Exists('veetou_subject_mappings_idx2');
        VEETOU_Util.Drop_Index_If_Exists('veetou_subject_mappings_idx3');
        VEETOU_Util.Drop_Index_If_Exists('veetou_subject_selectors_idx1');


        if purge THEN
            how := 'PURGE';
        ELSE
            how := '';
        END IF;

        -- DROP JUNCTION TABLES

        -- DROP DATA TABLES
        VEETOU_Util.Drop_Table_If_Exists('veetou_subject_mappings', how);
        VEETOU_Util.Drop_Table_If_Exists('veetou_subject_selectors', how);
    END;


    PROCEDURE Create_All_Schemas AS
    BEGIN
        Create_Schema;
        VEETOU_Schema_KO.Create_Schema;
    END;


    PROCEDURE Drop_All_Schemas(purge IN BOOLEAN := FALSE) AS
    BEGIN
        VEETOU_Schema_KO.Drop_Schema(purge);
        Drop_Schema(purge);
    END;
END VEETOU_Schema;
-- vim: ft=sql ts=4 sw=4 et:
