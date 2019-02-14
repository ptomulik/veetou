CREATE OR REPLACE TYPE V2u_Subject_Map_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Subject_Map_B_t
    (
    )
;
/
CREATE OR REPLACE TYPE V2u_Subject_Maps_t
    AS TABLE OF V2u_Subject_Map_t;

-- vim: set ft=sql ts=4 sw=4 et:
