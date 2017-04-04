Karta Osiągnięć (ko)
--------------------

The abbreviation ``ko`` is commonly used for "Karta Osiągnięć" (Achievement
Sheet - a report sheet with grades of particular student). On this sheet,
notes gathered by the student during given semester are listed. It also
contains some extra information, like university and faculty name, studies mode
and tier, field of studies, specialty etc. The layout of a typical page of
``ko`` is the following

.. code::

                        WYDZIAŁ KOSMETYKI I FRYZJERSTWA
                                        UNIWERSYTETU DZIELNEGO WOJAKA SZWEJKA

                                      Studia stacjonarne magisterskie drugiego stopnia
                         Karta okresowych osiągnięć studenta

  123456 - Wacław Kowalski
   Semestr akademicki: 2014L          Kierunek: Paznokcie i włosy
   Semestr studiów: 2                 Specjalność: Malowanie paznokciów


   Nr katalogowy       Nazwa przedmiotu         Wymiar godzin     Forma         PKT      Prowadzący    Ocena   Data
                                                 W   C   L        zalicz:
   FO.AA1234           Malowanie paznokciów      0   1   0        Egz.          2        Kaśka Pelaśka   4,5  17.09.2014
                       u stóp
   FO.BB5679           ....................

   ......................................................................................................................

   Wygenerowano z użyciem ....                                                                                        1/2


PDF version of full ``ko`` report is a multi-sheet document, where each sheet
spans along one or more pages. On page we have a header (university and faculty
info), a preamble (studies mode and tier/field of study/specialty and student
info), an optional table with grades and footer. The preamble is repeated on
every page of the sheet.

The parsing result of ``ko`` includes the following basic tables

- ``reports`` - with a record for every parsed file,
- ``sheets`` - with a record for every sheet in a file,
- ``pages`` - with a record for every page in a file,
- ``preambles`` - with a record for every preamble in a file,
- ``headers`` - with a record for every (distinct) header,
- ``footers`` - with a record for every (disctinct) footer,
- ``tbodies`` - table bodies (one table/sheet consists of one or more table bodies),
- ``trs`` - table rows.

If the result is saved as sqlite3_ database, a table view named

- ``joined``

is also created for convenient representation and exporting sheet contents. An
``sqlite3`` database will also contain additional junction tables, which are
used to implement relation between tables

- ``report_sheets``,
- ``sheet_pages``,
- ``page_preamble``,
- ``page_header``,
- ``page_footer``,
- ``page_tbody``,
- ``tbody_trs``.

Our command-line tool is able to read these PDF reports and output the parsing
result to csv file or (better) to sqlite3_ database file:

.. code:: bash

    PYTHONPATH=lib bin/veetou ko -O db -o path/to/ko-report.db path/to/ko-report.pdf

where ``ko-report.db`` is the resultant (output) database file and
``ko-report.pdf`` is an input file to be parsed. The resultant file
``ko-report.db`` may be further handled with ``sqlite3`` command-line tool, or
by GUI, such as SQLiteStudio_


.. _SQLiteStudio: https://sqlitestudio.pl/
.. _sqlite: https://www.sqlite.org/
.. _sqlite3: https://www.sqlite.org/

