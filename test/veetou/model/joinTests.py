#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model.join_ as join_
import veetou.model.table_ as table_
import veetou.model.relation_ as relation_
import veetou.model.junction_ as junction_
import veetou.model.endpoint_ as endpoint_
import veetou.model.link_ as link_
import veetou.model.pair_ as pair_
import veetou.model.functions_ as functions_
import veetou.model.datatype_ as datatype_
import veetou.model.dict_ as dict_
import veetou.model.ref_ as ref_
import re

DataType = datatype_.DataType
Junction = junction_.Junction
Pair = pair_.Pair
declare = functions_.declare
tableclass = functions_.tableclass
entityclass = functions_.entityclass


Header = declare(DataType, 'Header',
        ( 'university', 'faculty', 'entity' ),
        ( str,          str,       str      ),
        plural = 'Headers'
)

Footer = declare(DataType, 'Footer',
        ( 'page_number', 'generator' ),
        ( int,            str        ),
        plural = 'Footers'
)

Page = declare(DataType, 'Page',
        ( 'page_number', ),
        ( int,           ),
        plural = 'Pages'
)

Report = declare(DataType, 'Report',
        ( 'title', 'town', 'date' ),
        ( str,     str,    str    ),
        plural = 'Reports'
)

Document = declare(DataType, 'Document',
        ( 'file', 'pages_total' ),
        ( str,        int ),
        plural = 'Documents'
)

class SampleDB(object):
    @classmethod
    def tabletuples(cls):
        return (    ('t_documents', Document),
                    ('t_reports', Report),
                    ('t_pages', Page),
                    ('t_headers', Header),
                    ('t_footers', Footer)   )

    @classmethod
    def relationtuples(cls):
        return (    ('r_document_reports',  ('t_documents', 't_reports'),   ('reports','document')  ),
                    ('r_report_pages',      ('t_reports', 't_pages'),       ('pages', 'report')     ),
                    ('r_page_header',       ('t_pages', 't_headers'),       ('header', 'page')      ),
                    ('r_page_footer',       ('t_pages', 't_footers'),       ('footer', 'page')      )   )

    def __init__(self):
        # initialize empty tables
        for (name, datatype) in self.tabletuples():
            setattr(self, name, (tableclass(datatype))())

        for (name, reltabs, relnames) in self.relationtuples():
            reltabs = (getattr(self, reltabs[0]), getattr(self, reltabs[1]))
            setattr(self, name, Junction(reltabs, relnames))
        # tables
        self._tables = table_.TableList([ getattr(self, t) for (t,_) in self.tabletuples() ])

    @property
    def tables(self):
        return self._tables

    def clone(self):
        db = type(self)()
        for (name, datatype) in db.tabletuples():
            setattr(db, name, (tableclass(datatype))(getattr(self, name)))

        for (name, reltabs, relnames) in db.relationtuples():
            reltabs = (getattr(db, reltabs[0]), getattr(db, reltabs[1]))
            setattr(db, name, Junction(reltabs, relnames, getattr(self, name)))
        # tables
        db._tables = table_.TableList([ getattr(db, t) for (t,_) in db.tabletuples() ])
        return db


db1 = SampleDB()
# Table contents
db1.t_documents[0] = entityclass(Document)(('doc1.pdf', '3'))
db1.t_documents[1] = entityclass(Document)(('doc2.pdf', '2'))
db1.t_documents[2] = entityclass(Document)(('empty.pdf', '0'))
#
db1.t_reports[0] = entityclass(Report)(('Monthly report Jan 2017', 'Warsaw', '2017-01-31'))
db1.t_reports[1] = entityclass(Report)(('Monthly report Feb 2017', 'Warsaw', '2017-02-28'))
db1.t_reports[2] = entityclass(Report)(('Monthly report Mar 2017', 'Radom', '2017-03-31'))
#
db1.t_pages[0] = entityclass(Page)(('1', ))
db1.t_pages[1] = entityclass(Page)(('2', ))
db1.t_pages[2] = entityclass(Page)(('3', ))
db1.t_pages[3] = entityclass(Page)(('1', ))
db1.t_pages[4] = entityclass(Page)(('2', ))
#
db1.t_headers[0] = entityclass(Header)(('PW', 'MEiL', 'ZTMiR'))
db1.t_headers[1] = entityclass(Header)(('UTH', 'WIM', 'Dziekanat'))
#
db1.t_footers[0] = entityclass(Footer)(('1', 'Generated with Veetou'))
db1.t_footers[1] = entityclass(Footer)(('2', 'Generated with Veetou'))
# Junctions
db1.r_document_reports.append(Pair(0,0))
db1.r_document_reports.append(Pair(0,1))
db1.r_document_reports.append(Pair(1,2))
#
db1.r_report_pages.append(Pair(0,0))
db1.r_report_pages.append(Pair(0,1))
db1.r_report_pages.append(Pair(1,2))
db1.r_report_pages.append(Pair(2,3))
db1.r_report_pages.append(Pair(2,4))
#
db1.r_page_header.append(Pair(0,0))
db1.r_page_header.append(Pair(1,0))
db1.r_page_header.append(Pair(2,0))
db1.r_page_header.append(Pair(3,1))
db1.r_page_header.append(Pair(4,1))
#
db1.r_page_footer.append(Pair(0,0))
db1.r_page_footer.append(Pair(1,1))
db1.r_page_footer.append(Pair(2,0))
db1.r_page_footer.append(Pair(3,0))
db1.r_page_footer.append(Pair(4,1))

class Test__Constants(unittest.TestCase):
    def test__constants_1(self):
        self.assertEqual(join_.INNER_JOIN, 0)
        self.assertEqual(join_.LEFT_JOIN,  1)
        self.assertEqual(join_.RIGHT_JOIN, 2)
        self.assertEqual(join_.OUTER_JOIN, 3)

class Test__JoinTypeDict(unittest.TestCase):
    def test__subclass_1(self):
        self.assertTrue(issubclass(join_.JoinTypeDict, dict_.Dict))

    def test__keywrap__1(self):
        docs = (tableclass(Document))()
        pages = (tableclass(Page))()
        dct = join_.JoinTypeDict()
        rel = junction_.Junction((docs,pages),('pages','doc'))
        self.assertIsInstance(dct.__keywrap__(rel), ref_.Ref)
        self.assertIs(dct.__keywrap__(rel).obj, rel)

    def test__keywrap__2(self):
        docs = (tableclass(Document))()
        pages = (tableclass(Page))()
        dct = join_.JoinTypeDict()
        rel = link_.Link((docs,pages), ('pages','doc'), column = 0)
        self.assertIsInstance(dct.__keywrap__(rel), ref_.Ref)
        self.assertIs(dct.__keywrap__(rel).obj, rel)

    def test__keywrap__3(self):
        dct = join_.JoinTypeDict()
        msg = re.escape(r'%s is not an instance of %s' % (repr('asdf'), repr(relation_.Relation)))
        with self.assertRaisesRegex(TypeError, msg):
            dct.__keywrap__('asdf')

    def test__keyunwrap__1(self):
        docs = (tableclass(Document))()
        pages = (tableclass(Page))()
        dct = join_.JoinTypeDict()
        rel = junction_.Junction((docs,pages),('pages','doc'))
        self.assertIs(dct.__keyunwrap__(ref_.Ref(rel)), rel)

    def test__wrap__1(self):
        dct = join_.JoinTypeDict()
        self.assertIs(dct.__wrap__(join_.INNER_JOIN), join_.INNER_JOIN)
        self.assertIs(dct.__wrap__(join_.LEFT_JOIN), join_.LEFT_JOIN)
        self.assertIs(dct.__wrap__(join_.RIGHT_JOIN), join_.RIGHT_JOIN)
        self.assertIs(dct.__wrap__(join_.OUTER_JOIN), join_.OUTER_JOIN)

    def test__wrap__2(self):
        dct = join_.JoinTypeDict()
        with self.assertRaisesRegex(ValueError, 'invalid join type %s' % repr('asdf')):
                dct.__wrap__('asdf')

class Test__Join(unittest.TestCase):
    def test__init_1(self):
        q = join_.Join()
        self.assertFalse(hasattr(q, '_root'))
        self.assertFalse(hasattr(q, '_tables'))
        self.assertEqual(q._default_jointype, join_.INNER_JOIN)

    def test__init_2(self):
        msg = r'%s is not an instance of %s' % (repr('asdf'), repr(table_.Table))
        with self.assertRaisesRegex(TypeError, msg):
            join_.Join('asdf')

    def test__init_3(self):
        db = SampleDB()
        q = join_.Join(db.t_documents)
        self.assertTrue(hasattr(q, '_root'))
        self.assertTrue(hasattr(q, '_tables'))
        self.assertEqual(q._default_jointype, join_.INNER_JOIN)
        self.assertIsInstance(q._tables, table_.TableList)
        self.assertEqual(len(q._tables), len(db.tables))
        self.assertIs(q._tables[0], db.t_documents)
        self.assertIs(q._tables[1], db.t_reports)
        self.assertIs(q._tables[2], db.t_pages)
        self.assertIs(q._tables[3], db.t_headers)
        self.assertIs(q._tables[4], db.t_footers)

    def test__init_4(self):
        db = SampleDB()
        q = join_.Join(db.t_documents, jointype = join_.LEFT_JOIN)
        self.assertTrue(hasattr(q, '_root'))
        self.assertTrue(hasattr(q, '_tables'))
        self.assertEqual(q._default_jointype, join_.LEFT_JOIN)
        self.assertIsInstance(q._tables, table_.TableList)
        self.assertEqual(len(q._tables), len(db.tables))
        self.assertIs(q._tables[0], db.t_documents)
        self.assertIs(q._tables[1], db.t_reports)
        self.assertIs(q._tables[2], db.t_pages)
        self.assertIs(q._tables[3], db.t_headers)
        self.assertIs(q._tables[4], db.t_footers)

    def test__init_5(self):
        db = SampleDB()
        with self.assertRaisesRegex(ValueError, 'invalid join type %s' % repr('asdf')):
                join_.Join(db.t_documents, jointype = 'asdf')

    def test__jointype_1(self):
        db = SampleDB()
        q = join_.Join(db.t_documents)
        self.assertEqual(q.default_jointype, join_.INNER_JOIN)

    def test__jointype_setter_1(self):
        db = SampleDB()
        q = join_.Join(db.t_documents)
        self.assertEqual(q.default_jointype, join_.INNER_JOIN)
        q.default_jointype = join_.LEFT_JOIN
        self.assertEqual(q.default_jointype, join_.LEFT_JOIN)
        q.default_jointype = join_.RIGHT_JOIN
        self.assertEqual(q.default_jointype, join_.RIGHT_JOIN)
        q.default_jointype = join_.OUTER_JOIN
        self.assertEqual(q.default_jointype, join_.OUTER_JOIN)
        q.default_jointype = join_.INNER_JOIN
        self.assertEqual(q.default_jointype, join_.INNER_JOIN)

    def test__jointype_setter_2(self):
        db = SampleDB()
        q = join_.Join(db.t_documents)
        with self.assertRaisesRegex(ValueError, r'invalid join type %s' % repr('asdf')):
            q.default_jointype = 'asdf'

    def test__rows_1(self):
        db = db1.clone()
        q = join_.Join(db.t_documents)
        e = [
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 1],
            [0, 1, 2, 0, 0],
            [1, 2, 3, 1, 0],
            [1, 2, 4, 1, 1]
        ]
        for i in range(len(e)):
            for j in range(len(e[i])):
                k = e[i][j]
                e[i][j] = db.tables[j].getrecord(k)

        r = q.rows()
        self.assertEqual(next(r), e[0])
        self.assertEqual(next(r), e[1])
        self.assertEqual(next(r), e[2])
        self.assertEqual(next(r), e[3])
        self.assertEqual(next(r), e[4])
        with self.assertRaises(StopIteration):
            next(r)

    def test__rows_2(self):
        University = declare(
            DataType, 'University',
            ('fullname', 'city'),
            plural = 'Universities'
        )
        UE = entityclass(University)

        db = db1.clone()
        db.t_universities = tableclass(University)()
        db.tables.insert(-1,db.t_universities)
        db.l_header_university = link_.Link(
                (db.t_headers, db.t_universities),
                ('university', 'header'),
                column = 'university')
        db.t_universities['UTH'] = UE(('Uniwersytet Techniczno-Humanistyczny w Radomiu', 'Radom'))
        db.t_universities['PW'] = UE(('Politechnika Warszawska', 'Warszawa'))
        db.t_universities['UJ'] = UE(('Uniwersytet Jagielloński', 'Kraków'))

        q = join_.Join(db.t_documents)
        e = [
            [0, 0, 0, 0, 'PW',  0],
            [0, 0, 1, 0, 'PW',  1],
            [0, 1, 2, 0, 'PW',  0],
            [1, 2, 3, 1, 'UTH', 0],
            [1, 2, 4, 1, 'UTH', 1]
        ]
        for i in range(len(e)):
            for j in range(len(e[i])):
                k = e[i][j]
                e[i][j] = db.tables[j].getrecord(k)

        r = q.rows()
        self.assertEqual(next(r), e[0])
        self.assertEqual(next(r), e[1])
        self.assertEqual(next(r), e[2])
        self.assertEqual(next(r), e[3])
        self.assertEqual(next(r), e[4])
        with self.assertRaises(StopIteration):
            next(r)

    def test__determine_path_1(self):
        db = db1.clone()
        q = join_.Join()
        q._determine_path(db.t_documents)
        self.assertEqual(len(q.tables), 5)
        self.assertIs(q.tables[0], db.t_documents)
        self.assertIs(q.tables[1], db.t_reports)
        self.assertIs(q.tables[2], db.t_pages)
        self.assertIs(q.tables[3], db.t_headers)
        self.assertIs(q.tables[4], db.t_footers)

    def test__determine_path_2(self):
        db = db1.clone()
        q = join_.Join()
        q._determine_path(db.t_reports)
        self.assertEqual(len(q.tables), 5)
        self.assertIs(q.tables[0], db.t_reports)
        self.assertIs(q.tables[1], db.t_documents)
        self.assertIs(q.tables[2], db.t_pages)
        self.assertIs(q.tables[3], db.t_headers)
        self.assertIs(q.tables[4], db.t_footers)

    def test__determine_path_3(self):
        db = db1.clone()
        q = join_.Join()
        q._determine_path(db.t_pages)
        self.assertEqual(len(q.tables), 5)
        self.assertIs(q.tables[0], db.t_pages)
        self.assertIs(q.tables[1], db.t_reports)
        self.assertIs(q.tables[2], db.t_documents)
        self.assertIs(q.tables[3], db.t_headers)
        self.assertIs(q.tables[4], db.t_footers)

    def test__determine_path_4(self):
        db = db1.clone()
        q = join_.Join()
        q._determine_path(db.t_headers)
        self.assertEqual(len(q.tables), 5)
        self.assertIs(q.tables[0], db.t_headers)
        self.assertIs(q.tables[1], db.t_pages)
        self.assertIs(q.tables[2], db.t_reports)
        self.assertIs(q.tables[3], db.t_documents)
        self.assertIs(q.tables[4], db.t_footers)


    def test__determine_path_5(self):
        db = db1.clone()
        q = join_.Join()
        q._determine_path(db.t_footers)
        self.assertEqual(len(q.tables), 5)
        self.assertIs(q.tables[0], db.t_footers)
        self.assertIs(q.tables[1], db.t_pages)
        self.assertIs(q.tables[2], db.t_reports)
        self.assertIs(q.tables[3], db.t_documents)
        self.assertIs(q.tables[4], db.t_headers)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
