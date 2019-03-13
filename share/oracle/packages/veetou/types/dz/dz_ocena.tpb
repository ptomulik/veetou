CREATE OR REPLACE TYPE BODY V2u_Dz_Ocena_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Ocena_t(
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
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , komentarz_pub => komentarz_pub
            , komentarz_pryw => komentarz_pryw
            , toc_kod => toc_kod
            , wart_oc_kolejnosc => wart_oc_kolejnosc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , prot_id => prot_id
            , term_prot_nr => term_prot_nr
            , zmiana_os_id => zmiana_os_id
            , zmiana_data => zmiana_data
            , pos_komi_id => pos_komi_id
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
