# -*- coding: utf8 -*-
"""`veetou.model.junction_`

Provides the Junction class
"""

from . import object_
from . import functions_
from . import pair_
from . import relation_
import collections.abc
import itertools

__all__ = ('Junction', )

class Junction(relation_.Relation, collections.abc.MutableSequence):
    """Relates rows of two tables via their primary keys (many to many relation)."""

    __slots__ = ('_list', '_fkmaps')

    def __init__(self, tables, endnames, pairs = (), register = True):
        super().__init__(tables, endnames, register)
        self._list = pair_.PairList()
        self._fkmaps = (dict(), dict())
        self[:] = pairs

    def __getitem__(self,i):
        return self._list[i]

    def __setitem__(self,i,pairs):
        if isinstance(i,slice):
            self._setitem_by_slice(i,pairs)
        else:
            self._setitem_by_index(i,pairs)

    def __delitem__(self,i):
        if isinstance(i, slice):
            self._delitem_by_slice(i)
        else:
            self._delitem_by_index(i)

    def __len__(self):
        return len(self._list)

    def insert(self,i,pair):
        self._insert_to_fkmaps(i, pair)
        self._list.insert(i, pair)

    def indices_for(self, side, key):
        relation_.checkside(side)
        return self._fkmaps[side].get(key, [])

    def relations_for(self, side, key):
        return map(lambda i : self._list[i], self.indices_for(side, key))

    def opposite_keys(self, side, key):
        opposite = Junction.opposite_side(side)
        return map(lambda rel : rel[opposite], self.relations_for(side, key))

    def _setitem_by_slice(self, i, pairs):
        old = self._list[i]
        self._list[i] = pairs
        self._setitem_by_slice_in_fkmaps(i, old)

    def _setitem_by_index(self, i, pair):
        ii = range(len(self))[i] if i < 0 else i # handle negative numbers
        old = self._list[i]
        self._list[i] = pair
        self._setitem_by_index_in_fkmaps(ii, old)

    def _delitem_by_slice(self, i):
        cnt = 0
        for ii in range(len(self))[i]:
            assert ii-cnt >= 0
            self._delitem_by_index(ii-cnt)
            cnt += 1

    def _delitem_by_index(self, i):
        self._delitem_by_index_in_fkmaps(i)
        del self._list[i]

    def _setitem_by_slice_in_fkmaps(self, i, old):
        cnt = 0
        for j in range(len(self))[i]:
            if cnt < len(old):
                self._setitem_by_index_in_fkmaps(j, old[cnt])
                cnt += 1
            else:
                self._setitem_by_index_in_fkmaps(j)

    def _setitem_by_index_in_fkmaps(self, i, old = None):
        pair = self._list[i]
        for pi in (relation_.LEFT, relation_.RIGHT):
            key = pair[pi]
            fkmap = self._fkmaps[pi]
            j = 0
            if key not in fkmap:
                fkmap[key] = []
            lst = fkmap[key]
            while j < len(lst) and lst[j] < i:
                j += 1
            if old is not None and old[pi] != key:
                lst.insert(j,i)
                key = old[pi]
                lst = fkmap[key]
                j = 0
                while j < len(lst) and lst[j] < i:
                    j += 1
                del lst[j]
                if not lst:
                    del fkmap[key]
            else:
                if j == len(lst):
                    lst.append(i)
                else:
                    lst[j] = i

    def _insert_to_fkmaps(self, i, pair):
        i = range(len(self))[i] if i < 0 else i # handle negative numbers
        for pi in (relation_.LEFT, relation_.RIGHT):
            # all the trailing items were moved by one position, so we update
            # the _fkmaps accordingly
            keys = set([ x[pi] for x in itertools.islice(self._list, i, len(self)) ])
            fkmap = self._fkmaps[pi]
            for key in keys:
                lst = fkmap[key]
                lst[:] = [ x+1 if x>=i else x for x in lst ]
            # now, we can add mapping for the new pair
            key = pair[pi]
            j = 0
            if not key in fkmap:
                fkmap[key] = []
            lst = fkmap[key]
            while j < len(lst) and lst[j] < i:
                j += 1
            lst.insert(j, i)

    def _delitem_by_index_in_fkmaps(self, i):
        old = self._list[i]
        i = range(len(self))[i] if i < 0 else i # handle negative numbers
        for pi in (relation_.LEFT, relation_.RIGHT):
            # all the trailing items were moved by one position, so we update
            # the _fkmaps accordingly
            keys = set([ x[pi] for x in itertools.islice(self._list, i+1, len(self)) ])
            fkmap = self._fkmaps[pi]
            for key in keys:
                lst = fkmap[key]
                lst[:] = [ x-1 if x>i else x for x in lst ]
            # now, we can delete mapping for the old pair
            key = old[pi]
            lst = fkmap[key]
            if len(lst) > 1:
                lst[:] = [x for x in lst if x != i]
            else:
                assert lst[0] == i
                del fkmap[key]

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
