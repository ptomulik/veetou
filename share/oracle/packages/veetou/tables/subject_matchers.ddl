CREATE TABLE veetou_subject_matchers
     ( id VARCHAR(128 CHAR) NOT NULL
     , description VARCHAR(1024 CHAR)
     , CONSTRAINT veetou_subject_matchers_u1 UNIQUE (id));

-- vim: set ft=sql ts=4 sw=4 et:
