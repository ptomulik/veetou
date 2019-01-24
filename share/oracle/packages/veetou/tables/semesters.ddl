CREATE TABLE v2u_semesters
OF V2u_Semester_t
    (
      CONSTRAINT v2u_semesters_pk PRIMARY KEY (id)
    , CONSTRAINT v2u_semesters_u1 UNIQUE (code)
    , CONSTRAINT v2u_semesters_code_chk1 CHECK
        (REGEXP_INSTR(UPPER(code), '^(19|20)[0-9]{2}[LZ]$')=1)
    );

COMMENT ON TABLE v2u_semesters IS 'Semestry';
COMMENT ON COLUMN v2u_semesters.id IS 'Identyfikator semestru (0->0000Z, 1->0000L, 4037->2018Z)';
COMMENT ON COLUMN v2u_semesters.code IS 'Kod semestru, np. 2018Z';
COMMENT ON COLUMN v2u_semesters.start_date IS 'Pierwszy dzień semestru';
COMMENT ON COLUMN v2u_semesters.end_date IS 'Ostatni dzień semestru';

CREATE OR REPLACE TRIGGER v2u_semesters_tr1
    BEFORE INSERT ON v2u_semesters
FOR EACH ROW
BEGIN
    SELECT V2U_To.Semester_Id(:new.code)
        INTO :new.id
    FROM dual;
END;
/

INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1900Z',TO_DATE('1900-01-01','YYYY-MM-DD'),TO_DATE('1900-01-01','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1980Z',TO_DATE('1980-10-01','YYYY-MM-DD'),TO_DATE('1981-02-16','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1981L',TO_DATE('1981-02-17','YYYY-MM-DD'),TO_DATE('1981-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1981Z',TO_DATE('1981-10-01','YYYY-MM-DD'),TO_DATE('1982-02-21','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1982L',TO_DATE('1982-02-22','YYYY-MM-DD'),TO_DATE('1982-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1982Z',TO_DATE('1982-10-01','YYYY-MM-DD'),TO_DATE('1983-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1983L',TO_DATE('1983-02-21','YYYY-MM-DD'),TO_DATE('1983-10-02','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1983Z',TO_DATE('1983-10-03','YYYY-MM-DD'),TO_DATE('1984-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1984L',TO_DATE('1984-02-20','YYYY-MM-DD'),TO_DATE('1984-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1984Z',TO_DATE('1984-10-01','YYYY-MM-DD'),TO_DATE('1985-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1985L',TO_DATE('1985-02-21','YYYY-MM-DD'),TO_DATE('1985-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1985Z',TO_DATE('1985-10-01','YYYY-MM-DD'),TO_DATE('1986-02-23','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1986L',TO_DATE('1986-02-24','YYYY-MM-DD'),TO_DATE('1986-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1986Z',TO_DATE('1986-10-01','YYYY-MM-DD'),TO_DATE('1987-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1987L',TO_DATE('1987-02-23','YYYY-MM-DD'),TO_DATE('1987-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1987Z',TO_DATE('1987-10-01','YYYY-MM-DD'),TO_DATE('1988-02-21','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1988L',TO_DATE('1988-02-22','YYYY-MM-DD'),TO_DATE('1988-10-02','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1988Z',TO_DATE('1988-10-03','YYYY-MM-DD'),TO_DATE('1989-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1989L',TO_DATE('1989-02-20','YYYY-MM-DD'),TO_DATE('1989-10-01','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1989Z',TO_DATE('1989-10-02','YYYY-MM-DD'),TO_DATE('1990-02-18','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1990L',TO_DATE('1990-02-19','YYYY-MM-DD'),TO_DATE('1990-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1990Z',TO_DATE('1990-10-01','YYYY-MM-DD'),TO_DATE('1991-02-17','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1991L',TO_DATE('1991-02-18','YYYY-MM-DD'),TO_DATE('1991-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1991Z',TO_DATE('1991-10-01','YYYY-MM-DD'),TO_DATE('1992-02-23','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1992L',TO_DATE('1992-02-24','YYYY-MM-DD'),TO_DATE('1992-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1992Z',TO_DATE('1992-10-01','YYYY-MM-DD'),TO_DATE('1993-02-21','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1993L',TO_DATE('1993-02-22','YYYY-MM-DD'),TO_DATE('1993-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1993Z',TO_DATE('1993-10-01','YYYY-MM-DD'),TO_DATE('1994-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1994L',TO_DATE('1994-02-21','YYYY-MM-DD'),TO_DATE('1994-10-02','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1994Z',TO_DATE('1994-10-03','YYYY-MM-DD'),TO_DATE('1995-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1995L',TO_DATE('1995-02-20','YYYY-MM-DD'),TO_DATE('1995-10-01','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1995Z',TO_DATE('1995-10-02','YYYY-MM-DD'),TO_DATE('1996-02-18','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1996L',TO_DATE('1996-02-19','YYYY-MM-DD'),TO_DATE('1996-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1996Z',TO_DATE('1996-10-01','YYYY-MM-DD'),TO_DATE('1997-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1997L',TO_DATE('1997-02-20','YYYY-MM-DD'),TO_DATE('1997-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1997Z',TO_DATE('1997-10-01','YYYY-MM-DD'),TO_DATE('1998-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1998L',TO_DATE('1998-02-23','YYYY-MM-DD'),TO_DATE('1998-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1998Z',TO_DATE('1998-10-01','YYYY-MM-DD'),TO_DATE('1999-02-21','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1999L',TO_DATE('1999-02-22','YYYY-MM-DD'),TO_DATE('1999-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('1999Z',TO_DATE('1999-10-01','YYYY-MM-DD'),TO_DATE('2000-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2000L',TO_DATE('2000-02-21','YYYY-MM-DD'),TO_DATE('2000-10-01','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2000Z',TO_DATE('2000-10-02','YYYY-MM-DD'),TO_DATE('2001-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2001L',TO_DATE('2001-02-20','YYYY-MM-DD'),TO_DATE('2001-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2001Z',TO_DATE('2001-10-01','YYYY-MM-DD'),TO_DATE('2002-02-17','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2002L',TO_DATE('2002-02-18','YYYY-MM-DD'),TO_DATE('2002-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2002Z',TO_DATE('2002-10-01','YYYY-MM-DD'),TO_DATE('2003-02-16','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2003L',TO_DATE('2003-02-17','YYYY-MM-DD'),TO_DATE('2003-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2003Z',TO_DATE('2003-10-01','YYYY-MM-DD'),TO_DATE('2004-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2004L',TO_DATE('2004-02-23','YYYY-MM-DD'),TO_DATE('2004-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2004Z',TO_DATE('2004-10-01','YYYY-MM-DD'),TO_DATE('2005-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2005L',TO_DATE('2005-02-21','YYYY-MM-DD'),TO_DATE('2005-09-29','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2005Z',TO_DATE('2005-09-30','YYYY-MM-DD'),TO_DATE('2006-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2006L',TO_DATE('2006-02-20','YYYY-MM-DD'),TO_DATE('2006-10-01','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2006Z',TO_DATE('2006-10-02','YYYY-MM-DD'),TO_DATE('2007-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2007L',TO_DATE('2007-02-21','YYYY-MM-DD'),TO_DATE('2007-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2007Z',TO_DATE('2007-10-01','YYYY-MM-DD'),TO_DATE('2008-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2008L',TO_DATE('2008-02-21','YYYY-MM-DD'),TO_DATE('2008-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2008Z',TO_DATE('2008-10-01','YYYY-MM-DD'),TO_DATE('2009-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2009L',TO_DATE('2009-02-23','YYYY-MM-DD'),TO_DATE('2009-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2009Z',TO_DATE('2009-10-01','YYYY-MM-DD'),TO_DATE('2010-02-21','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2010L',TO_DATE('2010-02-22','YYYY-MM-DD'),TO_DATE('2010-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2010Z',TO_DATE('2010-10-01','YYYY-MM-DD'),TO_DATE('2011-02-20','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2011L',TO_DATE('2011-02-21','YYYY-MM-DD'),TO_DATE('2011-09-29','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2011Z',TO_DATE('2011-09-30','YYYY-MM-DD'),TO_DATE('2012-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2012L',TO_DATE('2012-02-20','YYYY-MM-DD'),TO_DATE('2012-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2012Z',TO_DATE('2012-10-01','YYYY-MM-DD'),TO_DATE('2013-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2013L',TO_DATE('2013-02-20','YYYY-MM-DD'),TO_DATE('2013-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2013Z',TO_DATE('2013-10-01','YYYY-MM-DD'),TO_DATE('2014-02-23','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2014L',TO_DATE('2014-02-24','YYYY-MM-DD'),TO_DATE('2014-09-28','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2014Z',TO_DATE('2014-09-29','YYYY-MM-DD'),TO_DATE('2015-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2015L',TO_DATE('2015-02-23','YYYY-MM-DD'),TO_DATE('2015-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2015Z',TO_DATE('2015-10-01','YYYY-MM-DD'),TO_DATE('2016-02-22','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2016L',TO_DATE('2016-02-23','YYYY-MM-DD'),TO_DATE('2016-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2016Z',TO_DATE('2016-10-01','YYYY-MM-DD'),TO_DATE('2017-02-19','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2017L',TO_DATE('2017-02-20','YYYY-MM-DD'),TO_DATE('2017-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2017Z',TO_DATE('2017-10-01','YYYY-MM-DD'),TO_DATE('2018-02-18','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2018L',TO_DATE('2018-02-19','YYYY-MM-DD'),TO_DATE('2018-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2018Z',TO_DATE('2018-10-01','YYYY-MM-DD'),TO_DATE('2019-02-17','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2019L',TO_DATE('2019-02-18','YYYY-MM-DD'),TO_DATE('2019-09-30','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2019Z',TO_DATE('2019-10-01','YYYY-MM-DD'),TO_DATE('2020-02-16','YYYY-MM-DD'));
INSERT INTO v2u_semesters (code, start_date, end_date) VALUES ('2020L',TO_DATE('2020-02-17','YYYY-MM-DD'),TO_DATE('2020-09-30','YYYY-MM-DD'));

-- vim: set ft=sql ts=4 sw=4 et:
