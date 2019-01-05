# -*- coding: utf8 -*-
"""`veetou.parser.parser_`

Provides the Parser class
"""

from ..common import checkinstance
from ..model import entityclass
from ..model import tablename
from ..model import DataModel
from ..model import Endpoint
from ..model import Array

import abc

__all__ = ('Parser', 'RootParser')

class Parser(object, metaclass=abc.ABCMeta):

    __slots__ = ('_parent', '_children', '_squashing')

    def __init__(self, children = (), parent = None):
        super().__init__()
        if parent is not None:
            self.parent = parent
        self._children = tuple(children)
        for child in children:
            child.parent = self

    @property
    def prefix(self):
        return self.parent.prefix

    @property
    def parent(self):
        return self._parent

    @parent.setter
    def parent(self, value):
        self._parent = checkinstance(value, Parser)

    @property
    def root(self):
        return self.parent.root

    @property
    def children(self):
        return self._children

    @property
    def datamodel(self):
        return self.parent.datamodel

    @property
    def datamodel_disabled(self):
        return self.parent.datamodel_disabled

    @property
    def squashing(self):
        try:
            return self._squashing
        except AttributeError:
            return self.parent.squashing

    @squashing.setter
    def squashing(self, flag):
        self._squashing = bool(flag)

    @property
    def errors(self):
        return self.root.errors

    @property
    def table(self):
        return None

    @property
    def endpoint(self):
        return self.parent.endpoint

    @property
    def junctions(self):
        return (self.parent.endpoint,)

    def append_record(self, data, table, junctions=()):
        if self.datamodel_disabled:
            return (None, None)
        if isinstance(table, str):
            table = self.datamodel.tables[table]
        entity = entityclass(table)
        dict4us = { k : data[k] for k in data if k in entity.keys() }
        if self.squashing:
            (key, appended) = table.find_or_append(entity(**dict4us))
        else:
            key = table.append(entity(**dict4us))
            appended = True
        for rel in junctions:
            if isinstance(rel, Endpoint):
                endpoint = rel
            else:
                endpoint = table.relations[rel]
            opposite = endpoint.opposite_table
            opposite_key = opposite.last_append_id
            pair = endpoint.pair(key, opposite_key)
            if not self.squashing or not pair in endpoint.relation:
                endpoint.relation.append(pair)
        return (key, appended)

    def update_record(self, data, table, key, appended):
        if self.datamodel_disabled:
            return
        if isinstance(table, str):
            table = self.datamodel.tables[table]
        entity = entityclass(table)

        record = table.getrecord(key)

        # Extract from data fields that are of interest and try to update
        # existing record in table
        keys4us = tuple(k for k in record.keys() if k in data)
        vals4us = tuple(data[k] for k in keys4us)
        dict4us = dict(zip(keys4us, vals4us))

        # Operate on entities, as they implement validation and data conversion
        # on entry. So, the input data must pass through entity before it
        # reaches record. This also guarantees that the comparison, we perform
        # below, is done on the converted values (normalized, squashed
        # whitespaces, etc.).
        original = entity(record)
        updated = entity(original, **dict4us)

        if updated != original:
            if self.squashing and not appended:
                msg = "update_record(): can't modify existing record when " + \
                      "squashing is enabled (table: %s)" % tablename(table)
                raise RuntimeError(msg)
            record.update({k: updated[k] for k in keys4us})
            record.save()

    def parse_before_children(self, iterator, kw):
        """This method is supposed to be overriden in a subclass"""
        return True

    def parse_with_children(self, iterator, kw):
        """This method is supposed to be overriden in a subclass"""
        return True

    def parse_after_children(self, iterator, kw):
        """This method is supposed to be overriden in a subclass"""
        return True

    def parse(self, iterator, **kw):
        if not self.parse_before_children(iterator, kw):
            return False
        if self.table is not None:
            (key, appended) = self.append_record(kw, self.table, self.junctions)
        if not self.parse_with_children(iterator, kw):
            return False
        if not self.parse_after_children(iterator, kw):
            return False
        if self.table is not None:
            self.update_record(kw, self.table, key, appended)
        return True

    def __getattr__(self, name):
        if len(name) > 7 and name.endswith('_parser'):
            for child in self.children:
                try:
                    return getattr(child, name)
                except AttributeError:
                    pass
        raise AttributeError('%s object has no attribute %s' % (repr(self.__class__.__name__), name))

class RootParser(Parser):

    __slots__ = ('_errors', '_datamodel', '_datamodel_disabled', '_squashing')

    def __init__(self, children = (), datamodel = None, disable_data = False, squashing = False):
        super().__init__(children)
        self._errors = []
        self._datamodel_disabled = disable_data
        self._squashing = squashing
        if datamodel is None:
            self._datamodel = DataModel()
        else:
            self._datamodel = checkinstance(datamodel, DataModel)

    @property
    def prefix(self):
        return self.datamodel.prefix

    @property
    def parent(self):
        raise AttributeError()

    @property
    def errors(self):
        return self._errors

    @property
    def root(self):
        return self

    @property
    def datamodel(self):
        return self._datamodel

    @property
    def datamodel_disabled(self):
        return self._datamodel_disabled

    @property
    def squashing(self):
        return self._squashing

    @property
    def table(self):
        raise AttributeError()

    @property
    def endpoint(self):
        raise AttributeError()

    @property
    def junctions(self):
        return ()

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
