CREATE OR REPLACE TYPE V2u_Dz_Ocena_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( os_id NUMBER(10)
    , komentarz_pub VARCHAR2(2000 CHAR)
    , komentarz_pryw VARCHAR2(2000 CHAR)
    , toc_kod VARCHAR2(20 CHAR)
    , wart_oc_kolejnosc NUMBER(10)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , prot_id NUMBER(10)
    , term_prot_nr NUMBER(10)
    , zmiana_os_id NUMBER(10)
    , zmiana_data DATE
    , pos_komi_id NUMBER(10)


    , CONSTRUCTOR FUNCTION V2u_Dz_Ocena_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Ocena_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Ocena_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/

-- vim: set ft=sql ts=4 sw=4 et:
