# -*- coding: utf8 -*-
"""`veetou.pz.pzhreportparser_`

Provides the PzHReportParser class
"""

from . import pzhmodel_
from ..parser import Parser
from ..parser import RootParser
from ..parser import fullmatch

from ..parser.patterns_ import _rg_sheet_id
##from ..parser.patterns_ import _rg_subj_name
##from ..parser.patterns_ import _rg_subj_code
##from ..parser.patterns_ import _re_subj_grade
##
##from ..parser.patterns_ import _re_subj_grade
from ..parser.patterns_ import _rg_tr_ord
from ..parser.patterns_ import _rg_student_name
from ..parser.patterns_ import _rg_student_index
##from ..parser.patterns_ import _rg_tr_remarks
from ..parser.patterns_ import _re_subj_grade
from ..parser.patterns_ import _re_first_name
from ..parser.patterns_ import _re_name_piece

import sys
import re
import lxml.etree

__all__ = ( 'PzHReportParser', )

##_rg_faculty_short = r'(?P<faculty>(?:Gik|MEiL))'
##_re_html_title = r'%s: Protokoły Zaliczeń'

_rg_title = r'(?P<title>Protokół zaliczeń)'
_rg_title_line = r'(?P<title_line>%s {,3}\(%s\))' % (_rg_title, _rg_sheet_id)
_rg_subj_department = r'(?P<subj_department>(?:(?:Wydział|Instytut|Zakład|Katedra|Studium) {1,2}\S+(?: {1,2}\S+)*)|INNE)'
_rg_edited_date = r'(?P<edited_date>\d\d\.\d\d\.\d\d\d\d)'
_rg_edited_time = r'(?P<edited_time>\d\d:\d\d)'

_subject_infos = {
        'Semestr wydruku protokołu:'    : 'semester_code',
        'Numer protokołu:'              : 'sheet_number',
        'Typ protokołu:'                : 'sheet_type',
        'Stan protokołu:'               : 'sheet_state',
        'Przedmiot:'                    : 'subj_name',
        'Nr katalogowy:'                : 'subj_code',
        'Typ oceny:'                    : 'subj_grade_type',
        'Kierownik przedmiotu:'         : 'subj_tutor',
        'Data zwrócenia:'               : 'return_date',
        'Osoba zatwierdzająca:'         : 'approved_by',
        'Data modyfikacji:'             : 'modified_datetime',
        'Termin zwrotu:'                : 'return_deadline'
}

_td_patterns = {
        'Nr'                            : _rg_tr_ord,
        'Student'                       : _rg_student_name,
        'Nr albumu'                     : _rg_student_index,
        'Ocena z przedmiotu'            : r'(?P<subj_grade>%s)' % _re_subj_grade,
        'Ocena z projektu'              : r'(?P<subj_grade_project>%s)' % _re_subj_grade,
        'Ocena z wykładu'               : r'(?P<subj_grade_lecture>%s)' % _re_subj_grade,
        'Ocena z ćwiczeń'               : r'(?P<subj_grade_class>%s)' % _re_subj_grade,
        'Ocena końcowa'                 : r'(?P<subj_grade_final>%s)' % _re_subj_grade,
        'Ocena P'                       : r'(?P<subj_grade_p>%s)' % _re_subj_grade,
        'Ocena N'                       : r'(?P<subj_grade_n>%s)' % _re_subj_grade,
        'Wprowadzający'                 : r'(?P<edited_by>%s(?: %s)?)' % (_re_name_piece, _re_first_name),
        'Data modyfikacji'              : r'(?P<edited_datetime>%s, ?%s)' % (_rg_edited_date, _rg_edited_time)
}

def get_unique_element(base, xpath):
    children = base.xpath(xpath)
    try:
        base.getroottree
    except AttributeError:
        fullpath = xpath
    else:
        fullpath = '/'.join((base.getroottree().getpath(base),xpath))
    if not children:
        dsc = 'could not locate elements with xpath=%s' % repr(fullpath)
        sys.stderr.write("error: %s\n" % dsc)
        return None
    elif len(children) != 1:
        dsc = 'multiple (%d) elements with xpath=%s' % (len(children), repr(fullpath))
        sys.stderr.write("error: %s\n" % dsc)
        return None
    return children[0]


class PzHReportParser(RootParser):

    __slots__ = ('_preamble_parser', '_table_parser', '_summary_parser')

    def __init__(self, disable_datamodel = False, squashing = False):
        self._preamble_parser = PzHPreambleParser()
        self._table_parser = PzHTableParser()
        self._summary_parser = PzHSummaryParser()
        children = (    self._preamble_parser,
                        self._table_parser,
                        self._summary_parser    )
        super().__init__(children, self.create_datamodel(), disable_datamodel, squashing)

    def create_datamodel(self, **kw):
        return pzhmodel_.PzHDataModel(**kw)

    @property
    def preamble_parser(self):
        return self._preamble_parser

    @property
    def table_parser(self):
        return self._table_parser

    @property
    def summary_parser(self):
        return self._summary_parser

    @property
    def table(self):
        return 'reports'

    @property
    def endpoint(self):
        return 'report'

    @property
    def content_xpath(self):
        return "/html/body//div[contains(@class,'vdo-content')]/div[contains(@class,'content')]"

    @property
    def table_xpath(self):
        subpath = "div[contains(@class,'inner-protocol')]/form[@id='entry_form']/table[1]"
        return '/'.join((self.content_xpath, subpath))

    def parse(self, input, **kw):
        parser = lxml.etree.HTMLParser()
        tree = lxml.etree.parse(input, parser)
        return super().parse(tree, **kw)

    def parse_with_children(self, tree, kw):
        content = get_unique_element(tree, self.root.content_xpath)
        table = get_unique_element(tree, self.root.table_xpath)
        if not self.parse_preamble(content, kw):
            return False
        if not self.parse_table(table, kw):
            return False
        if not self.parse_summary(tree, kw):
            return False
        return True

    def parse_preamble(self, tree, kw):
        return self.preamble_parser.parse(tree)

    def parse_table(self, tree, kw):
        return self.table_parser.parse(tree)

    def parse_summary(self, tree, kw):
        return True

class PzHPreambleParser(Parser):

    __slots__ = ()

    @property
    def table(self):
        return 'preambles'

    @property
    def endpoint(self):
        return 'preamble'

    def refine_preamble(self, data):
        def refine(key, fcn):
            if isinstance(data.get(key), str):
                data[key] = fcn(data[key])
        refine('semester_code', lambda s : s.replace(' ', ''))

    def parse_title(self, content, kw):
        title = get_unique_element(content, "div[contains(@class,'title')]")
        if title is None:
            return False
        text = title.text
        if not fullmatch(_rg_title_line, text, strip=True, groupdict=kw):
            dsc = 'syntax error in title: %s' % repr(text)
            sys.stderr.write("error: %s\n" % dsc)
            return False
        return True

    def parse_subject_info(self, content, kw):
        subject_info = get_unique_element(content, "div[contains(@class,'subject-info')]")
        if subject_info is None:
            return False
        for div in subject_info.xpath("div[span/@class='value']"):
            text = div.text.strip()
            if text:
                try:
                    key = _subject_infos[text]
                except KeyError:
                    dsc = 'syntax error in preamble: %s' % repr(text)
                    sys.stderr.write("error: %s\n" % dsc)
                    return False
            else:
                key = None
            span = get_unique_element(div, "span[contains(@class,'value')]")
            if key:
                if span is None: # this actually should never happen
                    dsc = 'could not find value for %s' % repr(text)
                    sys.stderr.write("error: %s\n" % dsc)
                    return False
                value = span.text.strip()
                kw[key] = value
            else:
                if span is not None: # this actually should be always true
                    value = span.text.strip()
                    if not fullmatch(_rg_subj_department, value, groupdict = kw):
                        dsc = 'syntax error in preamble: %s' % repr(value)
                        sys.stderr.write("error: %s\n" % dsc)
                        return False
        return True


    def parse_before_children(self, content, kw):
        if content is None:
            return False
        if not self.parse_title(content, kw):
            return False
        if not self.parse_subject_info(content, kw):
            return False
        self.refine_preamble(kw)
        return True


class PzHTableParser(Parser):

    __slots__ = ('_tr_parser', '_td_patterns')

    def __init__(self, **kw):
        self._tr_parser = PzHTrParser()
        children = ( self._tr_parser, )
        super().__init__(children, **kw)
        self._td_patterns = ()

    @property
    def tr_parser(self):
        return self._tr_parser

    @property
    def td_patterns(self):
        return self._td_patterns

    def parse_before_children(self, table, kw):
        ##xpath = self.root.table_xpath
        ##table = get_unique_element(tree, xpath)
        if table is None:
            return False
        return self.parse_thead(table, kw)

    def parse_with_children(self, table, kw):
        ##xpath = self.root.table_xpath
        ##table = get_unique_element(tree, xpath)
        return self.parse_tbody(table, kw)

    def parse_thead(self, table, kw):
        self._td_patterns = []
        tr = get_unique_element(table, 'thead[1]/tr[1]')
        patterns = []
        for th in tr.xpath('th'):
            key = re.sub(r'\s+', ' ', " ".join(th.itertext()).strip())
            try:
                p = _td_patterns[key]
            except KeyError:
                dsc = "unknown column heading: %s" % repr(key)
                sys.stderr.write("error: %s\n" % dsc)
                return False
            else:
                patterns.append(p)
        self._td_patterns = tuple(patterns)
        return True

    def parse_tbody(self, table, kw):
        for tr in table.xpath('tbody/tr'):
            if not self.parse_tr(tr, kw):
                return False
        return True

    def parse_tr(self, tr, kw):
        return self.tr_parser.parse(tr)

class PzHTrParser(Parser):

    __slots__ = ()

    @property
    def table(self):
        return 'trs'

    @property
    def endpoint(self):
        return 'tr'

    def parse_before_children(self, tr, kw):
        return True

    def parse_with_children(self, tr, kw):
        i = 0
        for td in tr.xpath('td'):
            text = re.sub(r'\s+', ' ', " ".join(td.itertext()).strip())
            if not text:
                inp = get_unique_element(td, "input[@type='text']")
                if inp is None:
                    return False
                text = inp.get('value')
            pattern = self.parent.td_patterns[i]
            if not fullmatch(pattern, text, groupdict = kw):
                dsc = "syntax error in table column no. %d: %s" % (1+i, repr(text))
                sys.stderr.write("error: %s\n" % dsc)
                return False
            i += 1
        return True

class PzHSummaryParser(Parser):

    __slots__ = ()

    @property
    def table(self):
        return 'summaries'

    @property
    def endpoint(self):
        return 'summary'

# Local Variables:
# # tab-width:4
# # indent-tabs-mode:nil
# # End:
# vim: set syntax=python expandtab tabstop=4 shiftwidth=4:
