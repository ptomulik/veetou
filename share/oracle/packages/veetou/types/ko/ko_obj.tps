CREATE OR REPLACE TYPE V2u_Ko_Obj_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Obj_t(
              SELF IN OUT NOCOPY V2u_Ko_Obj_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Obj_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_id(other IN V2u_Ko_Obj_t)
        RETURN INTEGER

    , MEMBER FUNCTION cmp_attributes(other IN V2u_Ko_Obj_t)
        RETURN INTEGER
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
