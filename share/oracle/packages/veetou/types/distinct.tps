CREATE OR REPLACE TYPE V2u_Distinct_t FORCE AUTHID CURRENT_USER AS OBJECT
    -- V2u_Distinct_t is a base type for objects identified via their value
    -- (attributes). A subtype of V2u_Distinct_t should override the
    -- cmp_val() method. The method should compare objects using their
    -- values (attributes). It must return either -1, 0 or 1.
    --
    -- An object is said to be "unidentified" if its id IS NULL. If at least
    -- one of the objects being compared by cmp() is "unidentified", then
    -- objects get compared via value (attributes). If both objects are
    -- identified, then only their identifiers are compared.
    --
    -- NOTE: The cmp_val() is used automatically for grouping and ordering
    -- (GROUP BY, ORDER BY) in SQL. They seem to be ignored by expressions used
    -- in ON or WHERE clauese, i.e. MERGE INTO ... ON (src = tgt) ... ; will
    -- not work as you would expect (cmp() will not be used here for object
    -- comparison).
    ( id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Distinct_t(
              SELF IN OUT NOCOPY V2u_Distinct_t
            , id IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Distinct_t
            , id IN NUMBER := NULL
            )

    , ORDER MEMBER FUNCTION cmp(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_impl(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_id(other IN V2u_Distinct_t)
            RETURN INTEGER

    , MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
