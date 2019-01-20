CREATE OR REPLACE TYPE Veetou_Ko_Subject_Instance_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(32 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
            , subj_code IN VARCHAR2 := NULL
            , subj_name IN VARCHAR2 := NULL
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR2 := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
            , header IN Veetou_Ko_Header_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            , tr IN Veetou_Ko_Tr_Typ
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION ord_all_attr (
              other Veetou_Ko_Subject_Instance_Typ
            ) RETURN NUMBER
    );

-- vim: set ft=sql ts=4 sw=4 et:
