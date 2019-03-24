Veetou package for Oracle DB
````````````````````````````

Compound kinds
^^^^^^^^^^^^^^

+-----------------------+----------------------------------------------------------------+
| Compound kind         | Description                                                    |
+=======================+================================================================+
| Table (regular)       | Regular DB table with data.                                    |
+-----------------------+----------------------------------------------------------------+
| Table (junction)      | Establishes relations between two or more other tables.        |
+-----------------------+----------------------------------------------------------------+
| View                  | Regular view.                                                  |
+-----------------------+----------------------------------------------------------------+
| Type                  | A regular PL/SQL type. May be an object type.                  |
+-----------------------+----------------------------------------------------------------+
| Type (base)           | A base type for a regular object type.                         |
+-----------------------+----------------------------------------------------------------+
| Type (junction)       | An object type used to define a junction table.                |
+-----------------------+----------------------------------------------------------------+
| Type (junction base)  | A base type for junction object.                               |
+-----------------------+----------------------------------------------------------------+
| Type (view)           | An object type used to define a view.                          |
+-----------------------+----------------------------------------------------------------+
| Type (view base)      | A base type for view object.                                   |
+-----------------------+----------------------------------------------------------------+
| Package               | A PL/SQL package with functions, procedures, etc.              |
+-----------------------+----------------------------------------------------------------+

Naming conventions for different compounds
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Naming conventions by compound kind

+-----------------------+--------+-----------+-------------+-----------------------------+
| Compound kind         | Case   |  Prefix   | Suffix      |         Example             |
+=======================+========+===========+=============+=============================+
| Table (regular)       | lower  | ``v2u_``  |             | ``v2u_classes_map``         |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Table (junction)      | lower  | ``v2u_``  | ``_j``.     | ``v2u_ko_classes_map_j``    |
+-----------------------+--------+-----------+-------------+-----------------------------+
| View                  | lower  | ``v2u_``  | ``_v``      | ``v2u_ko_classes_map_v``    |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (regular)        | mixed  | ``V2u_``  | ``_t``.     | ``V2u_Classes_Map_t``       |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (regular base)   | mixed  | ``V2u_``  | ``_B_t``.   | ``V2u_Classes_Map_B_t``     |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (junction)       | mixed  | ``V2u_``  | ``_J_t``.   | ``V2u_Ko_Classes_Map_J_t``  |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (junction base)  | mixed  | ``V2u_``  | ``_I_t``.   | ``V2u_Ko_Classes_Map_I_t``  |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (view)           | mixed  | ``V2u_``  | ``_V_t``.   | ``V2u_Ko_Classes_Map_V_t``  |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Type (view base)      | mixed  | ``V2u_``  | ``_U_t``.   | ``V2u_Ko_Classes_Map_U_t``  |
+-----------------------+--------+-----------+-------------+-----------------------------+
| Package               | mixed  | ``V2U_``  |             | ``V2U_Util``                |
+-----------------------+--------+-----------+-------------+-----------------------------+

Although SQL is case-insensitive, we still follow the above case-sensitivity
rules in our SQL scripts. This helps guessing the compound kind from its name.


Veetou DB modules
^^^^^^^^^^^^^^^^^

The database objects of veetou are organized into "modules". Think about a
module as of a set of related types, tables and views.

+------+---------------------+-----------------------------------------------------------+
| ID   | Module name         | Description                                               |
+======+=====================+===========================================================+
|      | Basis               | A set of base tables not specifically tied to any of the  |
|      |                     | other modules.                                            |
+------+---------------------+-----------------------------------------------------------+
| KO   | Karty Osiągnięć     | A set of tables with data obtained from so-called "Karty  |
|      |                     | Osiągnięć" (a kind of mass-report PDF files exported from |
|      |                     | the source system).                                       |
+------+---------------------+-----------------------------------------------------------+
| DZ   | USOS DZ             | A set of USOS destination tables. Most of these tables    |
|      |                     | bear names starting with ``dz_`` prefix, so the module    |
|      |                     | ID is chosen to be ``DZ`` as well.
+------+---------------------+-----------------------------------------------------------+
| UU   | USOS Update         | A set of tables produced by our SQL scripts. These tables |
|      |                     | are designed to resemble DZ tables. UU tables store       |
|      |                     | initially processed data merged from multiple sources     |
|      |                     | (DZ tables, KO tables, etc.). The content of UU tables    |
|      |                     | may be used to update DZ tables quite easily. The UU      |
|      |                     | tables also provide extra columns for debugging.          |
+------+---------------------+-----------------------------------------------------------+
| UD   | Update Diff         | A set of views created to visualize changes between UU    |
|      |                     | tables and DZ tables. The differences can be analyzed     |
|      |                     | without actually applying any changes to DZ.              |
+------+---------------------+-----------------------------------------------------------+
| XR   | Extra Rows          | A set of tables, each of which provides extra rows        |
|      |                     | to its corresponding USOS table. For example, a table     |
|      |                     | named ``v2u_xr_punkty_przedmiotow`` provides rows         |
|      |                     | that are currently not in ``v2u_dz_punkty_przedmiotu``    |
|      |                     | but, supposedly, will be inserted there at some point.    |
+------+---------------------+-----------------------------------------------------------+
| UV   | Union View          | A set of views, each of which provides access to UNION    |
|      |                     | of a table and its corresponding XR table. For example    |
|      |                     | a view named ``v2u_uv_punkty_przedmiotow`` is an UNION    |
|      |                     | of ``v2u_dz_punkty_przedmiotow`` and                      |
|      |                     | ``v2u_xr_punkty_przedmiotow``.                            |
+------+---------------------+-----------------------------------------------------------+

Tables, views and types belonging to a given module (except the basis module)
get additional prefix to their names (tables and views from a module have same
prefix).

+------+---------------------+-----------------------------------------------------------+
| ID   | Prefix              | Examples                                                  |
+======+=======+=============+===========================================================+
|      | table | ``v2u_ko_`` | ``v2u_ko_classes_map_j``, ``v2u_ko_classes_map_v``        |
| KO   +-------+-------------+-----------------------------------------------------------+
|      | type  | ``V2u_Ko_`` | ``V2u_Ko_Classes_Map_J_t``                                |
+------+-------+-------------+-----------------------------------------------------------+
|      | table | ``v2u_dz_`` | ``v2u_dz_programy``                                       |
| DZ   +-------+-------------+-----------------------------------------------------------+
|      | type  | ``V2u_Dz_`` | ``V2u_Dz_Programy_t``                                     |
+------+-------+-------------+-----------------------------------------------------------+
|      | table | ``v2u_uu_`` | ``v2u_uu_programy``                                       |
| UU   +-------+-------------+-----------------------------------------------------------+
|      | type  | ``V2u_Uu_`` | ``V2u_Uu_Programy_t``                                     |
+------+-------+-------------+-----------------------------------------------------------+
|      | table | ``v2u_uu_`` | ``v2u_uu_programy``                                       |
| UU   +-------+-------------+-----------------------------------------------------------+
|      | type  | ``V2u_Uu_`` | ``V2u_Uu_Programy_t``                                     |
+------+-------+-------------+-----------------------------------------------------------+
|      | table | ``v2u_xr_`` | ``v2u_xr_punkty_przedmiotow``                             |
| XR   +-------+-------------+-----------------------------------------------------------+
|      | type  | ``V2u_Dz_`` | ``V2u_Dz_Punkty_Przedmiotu_t``                            |
+------+-------+-------------+-----------------------------------------------------------+

.. <!--- vim: set spell expandtab tabstop=2 shiftwidth=2 syntax=rst: -->
