CREATE OR REPLACE TYPE V2u_Dz_Ocena_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Ocena_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Ocena_t(
              SELF IN OUT NOCOPY V2u_Dz_Ocena_t
            , os_id IN NUMBER
            , komentarz_pub IN VARCHAR2
            , komentarz_pryw IN VARCHAR2
            , toc_kod IN VARCHAR2
            , wart_oc_kolejnosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , zmiana_os_id IN NUMBER
            , zmiana_data IN DATE
            , pos_komi_id IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Oceny_t
    AS TABLE OF V2u_Dz_Ocena_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
