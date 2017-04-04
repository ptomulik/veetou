#!/usr/bin/env python3
# -*- coding: utf8 -*-


import unittest
import veetou.model as model

class Test__Model(unittest.TestCase):

    def test__array__symbols__1(self):
        self.assertIs(model.array_.Array, model.Array)

    def test__datamodel__symbols__1(self):
        self.assertIs(model.datamodel_.DataModel, model.DataModel)

    def test__datatype__symbols__1(self):
        self.assertIs(model.datatype_.DataType, model.DataType)

    def test__dict__symbols__1(self):
        self.assertIs(model.dict_.Dict, model.Dict)

    def test__endpoint__symbols__1(self):
        self.assertIs(model.endpoint_.Endpoint, model.Endpoint)
        self.assertIs(model.endpoint_.EndpointDict, model.EndpointDict)
        self.assertIs(model.endpoint_.EndpointList, model.EndpointList)

    def test__entity__symbols__1(self):
        self.assertIs(model.entity_.Entity, model.Entity)

    def test__functions__symbols__1(self):
        self.assertIs(model.functions_.arrayclass, model.arrayclass)
        self.assertIs(model.functions_.arraygen, model.arraygen)
        self.assertIs(model.functions_.checkinstance, model.checkinstance)
        self.assertIs(model.functions_.checksubclass, model.checksubclass)
        self.assertIs(model.functions_.columniter, model.columniter)
        self.assertIs(model.functions_.datatype, model.datatype)
        self.assertIs(model.functions_.declare, model.declare)
        self.assertIs(model.functions_.entityclass, model.entityclass)
        self.assertIs(model.functions_.fielditer, model.fielditer)
        self.assertIs(model.functions_.modelname, model.modelname)
        self.assertIs(model.functions_.modelrefstr, model.modelrefstr)
        self.assertIs(model.functions_.recordclass, model.recordclass)
        self.assertIs(model.functions_.recordgen, model.recordgen)
        self.assertIs(model.functions_.safedelattr, model.safedelattr)
        self.assertIs(model.functions_.schemaname, model.schemaname)
        self.assertIs(model.functions_.setdelattr, model.setdelattr)
        self.assertIs(model.functions_.snakecase, model.snakecase)
        self.assertIs(model.functions_.tableclass, model.tableclass)
        self.assertIs(model.functions_.tablename, model.tablename)
        self.assertIs(model.functions_.tupleclass, model.tupleclass)
        self.assertIs(model.functions_.tuplegen, model.tuplegen)

    def test__fieldmapper__symbols__1(self):
        self.assertIs(model.fieldmapper_.FieldMapper, model.FieldMapper)

    def test__join__symbols__1(self):
        self.assertIs(model.join_.INNER_JOIN, model.INNER_JOIN)
        self.assertIs(model.join_.Join, model.Join)
        self.assertIs(model.join_.JoinTypeDict, model.JoinTypeDict)
        self.assertIs(model.join_.LEFT_JOIN, model.LEFT_JOIN)
        self.assertIs(model.join_.OUTER_JOIN, model.OUTER_JOIN)
        self.assertIs(model.join_.RIGHT_JOIN, model.RIGHT_JOIN)

    def test__junction__symbols__1(self):
        self.assertIs(model.junction_.Junction, model.Junction)

    def test__keystuple__symbols__1(self):
        self.assertIs(model.keystuple_.KeysTuple, model.KeysTuple)

    def test__link__symbols__1(self):
        self.assertIs(model.link_.Link, model.Link)
        self.assertIs(model.link_.SOURCE, model.SOURCE)
        self.assertIs(model.link_.TARGET, model.TARGET)

    def test__linkresolver__symbols__1(self):
        self.assertIs(model.linkresolver_.LinkResolver, model.LinkResolver)
        self.assertIs(model.linkresolver_.SourceTableBasedLinkResolver, model.SourceTableBasedLinkResolver)
        self.assertIs(model.linkresolver_.SourceColumnBasedLinkResolver, model.SourceColumnBasedLinkResolver)
        self.assertIs(model.linkresolver_.ConditionBasedLinkResolver, model.ConditionBasedLinkResolver)

    def test__list__symbols__1(self):
        self.assertIs(model.list_.List, model.List)

    def test__mapset__symbols__1(self):
        self.assertIs(model.mapset_.Mapset, model.Mapset)

    def test__namedarray__symbols__1(self):
        self.assertIs(model.namedarray_.NamedArray, model.NamedArray)

    def test__namedtuple__symbols__1(self):
        self.assertIs(model.namedtuple_.NamedTuple, model.NamedTuple)

    def test__object__symbols__1(self):
        self.assertIs(model.object_.Object, model.Object)

    def test__pair__symbols__1(self):
        self.assertIs(model.pair_.Pair, model.Pair)
        self.assertIs(model.pair_.PairList, model.PairList)

    def test__record__symbols__1(self):
        self.assertIs(model.record_.Record, model.Record)
        self.assertIs(model.record_.RecordFieldIterator, model.RecordFieldIterator)
        self.assertIs(model.record_.RecordFieldProxy, model.RecordFieldProxy)
        self.assertIs(model.record_.RecordSequence, model.RecordSequence)
        self.assertIs(model.record_.RecordSequenceFieldIterator, model.RecordSequenceFieldIterator)

    def test__ref__symbols__1(self):
        self.assertIs(model.ref_.Ref, model.Ref)

    def test__reflist__symbols__1(self):
        self.assertIs(model.reflist_.RefList, model.RefList)

    def test__relation__symbols__1(self):
        self.assertIs(model.relation_.LEFT, model.LEFT)
        self.assertIs(model.relation_.RIGHT, model.RIGHT)
        self.assertIs(model.relation_.Relation, model.Relation)
        self.assertIs(model.relation_.RelationDict, model.RelationDict)

    def test__set__symbols__1(self):
        self.assertIs(model.set_.Set, model.Set)

    def test__table__symbols__1(self):
        self.assertIs(model.table_.Table, model.Table)
        self.assertIs(model.table_.TableColumnDescriptor, model.TableColumnDescriptor)
        self.assertIs(model.table_.TableColumnIterator, model.TableColumnIterator)
        self.assertIs(model.table_.TableDict, model.TableDict)
        self.assertIs(model.table_.TableList, model.TableList)
        self.assertIs(model.table_.TableSequenceColumnIterator, model.TableSequenceColumnIterator)

    def test__tuple__symbols__1(self):
        self.assertIs(model.tuple_.Tuple, model.Tuple)

    def test__type__symbols__1(self):
        self.assertIs(model.type_.Type, model.Type)

if __name__ == '__main__':
    unittest.main()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
