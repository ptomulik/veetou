VeeToU
------
Conversion scripts

.. image:: https://travis-ci.org/ptomulik/veetou.png?branch=master
    :target: https://travis-ci.org/ptomulik/veetou

.. image:: https://coveralls.io/repos/github/ptomulik/veetou/badge.svg
    :target: https://coveralls.io/github/ptomulik/veetou

Dependencies
````````````

.. code:: bash

    sudo apt-get install python3 poppler-utils

Requires Python >= 3.4

Examples
````````

Get some help

.. code:: bash

    PYTHONPATH=lib bin/veetou --help


Decode "Karta Osiągnięć"

.. code:: bash

    PYTHONPATH=lib bin/veetou ko path/to/ko-report.pdf

Decode "Protokół Zaliczeń"

.. code:: bash

    PYTHONPATH=lib bin/veetou pz path/to/pz-report.pdf

Write result to sqlite3 database

.. code:: bash

    PYTHONPATH=lib bin/veetou pz path/to/pz-report.pdf -O db -o path/to/output.db

More recipes
````````````

Export previously saved sqlite3 database as csv

.. code:: bash

    sqlite3 path/to/output.db <<!
    .mode csv
    .headers on
    .separator ';'
    .output path/to/output.csv
    select * from joined;
    !

Parse a report and add extra tables from csv files, then write result to a
database file:

.. code:: bash

  # First prepare headers a little bit...
  sed -f share/veetou/fieldmaps/usos/sp.sed -i path/to/usos/sp.csv
  # Parse report and read extra tables from csv files...
  PYTHONPATH=lib bin/veetou ko --squash -O db \
                    --table usossp=path/to/usos/sp.csv \
                    --table ko2prog=path/to/ko/ko2prog.csv \
                    -o path/to/output.db \
                    path/to/ko-report.pdf

Running unit tests
``````````````````
.. code:: bash

    ./runtests.py
