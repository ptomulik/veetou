CREATE VIEW ko_refined AS
SELECT
  ko_full.ko_tr_subj_code AS subj_code,
  ko_full.ko_tr_subj_name AS subj_name,
  ko_full.ko_preamble_student_index AS student_index,
  ko_full.ko_preamble_first_name AS first_name,
  ko_full.ko_preamble_last_name AS last_name,
  ko_full.ko_preamble_student_name AS student_name,
  ko_full.ko_tr_subj_grade AS subj_grade,
  ko_full.ko_tr_subj_grade_date AS subj_grade_date,
  ko_full.ko_header_university AS university,
  ko_full.ko_header_faculty AS faculty,
  ko_full.ko_preamble_studies_modetier AS studies_modetier,
  ko_full.ko_preamble_studies_field AS studies_field,
  ko_full.ko_preamble_studies_specialty AS studies_specialty,
  ko_full.ko_preamble_semester_code AS semester_code,
  ko_full.ko_preamble_semester_number AS semester_number,
  ko_full.ko_tr_subj_tutor AS subj_tutor,
  ko_full.ko_tr_subj_hours_w AS subj_hours_w,
  ko_full.ko_tr_subj_hours_c AS subj_hours_c,
  ko_full.ko_tr_subj_hours_l AS subj_hours_l,
  ko_full.ko_tr_subj_hours_p AS subj_hours_p,
  ko_full.ko_tr_subj_hours_s AS subj_hours_s,
  ko_full.ko_tr_subj_credit_kind AS subj_credit_kind,
  ko_full.ko_tr_subj_ects AS subj_ects,
  ko_full.ko_sheet_ects_mandatory AS ects_mandatory,
  ko_full.ko_sheet_ects_other AS ects_other,
  ko_full.ko_sheet_ects_total AS ects_total,
  ko_full.ko_sheet_ects_attained AS ects_attained,
  ko_full.ko_preamble_title AS title,
  ko_full.ko_report_source AS report_source,
  ko_full.ko_report_datetime AS report_open_datetime,
  ko_full.ko_report_sheets_parsed AS report_sheets_parsed,
  ko_full.ko_report_pages_parsed AS report_pages_parsed,
  ko_full.ko_page_page_number AS page_number,
  ko_full.ko_sheet_first_page AS sheet_first_page,
  ko_full.ko_sheet_pages_parsed AS sheet_pages_parsed
FROM ko_full;

-- All studens found in ko reports
CREATE VIEW ko_students AS
SELECT
  student_index,
  student_name,
  first_name,
  last_name,
  COUNT(*) AS records_count
FROM ko_refined
GROUP BY student_index
ORDER BY student_index;

-- How many different specialties are related to given student
-- By "specialty" we mean here a combination of the following fields:
--    - faculty,
--    - studies_modetier (mode||tier),
--    - studies_field,
--    - studies_specialty
CREATE VIEW ko_specialties_per_student AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  COUNT(DISTINCT
    ko_refined.faculty || ';' ||
    ko_refined.studies_modetier || ';' ||
    ko_refined.studies_field || ';' ||
    ko_refined.studies_specialty
  ) AS studies_specialties_count,
  GROUP_CONCAT(DISTINCT
    ko_studies_program_codes.studies_modetier_code ||'-'||
    usos_dict_studies_specialties.studies_specialty_code
  ) AS studies_specialty_codes,
  COUNT(DISTINCT
    ko_studies_program_codes.studies_modetier_code ||'-'||
    usos_dict_studies_specialties.studies_specialty_code
  ) AS studies_specialtiy_codes_count
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty
)
LEFT JOIN usos_dict_studies_specialties ON (
  (ko_refined.studies_specialty = usos_dict_studies_specialties.description_pl COLLATE NOCASE OR
   ko_refined.studies_specialty = usos_dict_studies_specialties.description_en COLLATE NOCASE) AND
  ko_studies_program_codes.studies_field_code = usos_dict_studies_specialties.studies_field_code
)
GROUP BY student_index
ORDER BY student_index;

-- How many different programs are related to given student
-- By "program" we mean here a combination of the following fields:
--    - faculty,
--    - studies_modetier (mode||tier),
--    - studies_field,
CREATE VIEW ko_programs_per_student AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  COUNT(DISTINCT
    ko_refined.faculty || ';' ||
    ko_refined.studies_modetier || ';' ||
    ko_refined.studies_field
  ) AS studies_programs_count,
  GROUP_CONCAT(DISTINCT
    ko_studies_program_codes.studies_program_code
  ) AS studies_program_codes,
  COUNT(DISTINCT
    ko_studies_program_codes.studies_program_code
  ) AS studies_program_codes_count
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty
)
GROUP BY student_index
ORDER BY student_index;

CREATE VIEW ko_program_codes_per_student_specialty AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  ko_refined.faculty AS faculty,
  ko_refined.studies_modetier AS studies_modetier,
  ko_refined.studies_field AS studies_field,
  ko_refined.studies_specialty AS studies_specialty,
  GROUP_CONCAT(DISTINCT
    ko_studies_program_codes.studies_program_code
  ) AS studies_program_codes,
  COUNT(DISTINCT
    ko_studies_program_codes.studies_program_code
  ) AS studies_program_codes_count
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty
)
GROUP BY
  student_index,
  ko_refined.faculty,
  ko_refined.studies_modetier,
  ko_refined.studies_field,
  ko_refined.studies_specialty
ORDER BY
  student_index,
  ko_refined.faculty,
  ko_refined.studies_modetier,
  ko_refined.studies_field,
  ko_refined.studies_specialty;

CREATE VIEW ko_semesters_per_student_specialty AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  ko_refined.faculty AS faculty,
  ko_refined.studies_modetier AS studies_modetier,
  ko_refined.studies_field AS studies_field,
  ko_refined.studies_specialty AS studies_specialty,
  ko_specialties_per_student.studies_specialties_count AS studies_specialties_count,
  GROUP_CONCAT(DISTINCT
    ko_refined.semester_code
  ) AS semester_codes,
  GROUP_CONCAT(DISTINCT
    ko_refined.semester_number
  ) AS semester_numbers,
  COUNT(DISTINCT
    ko_refined.semester_code
  ) AS semester_codes_count
FROM ( SELECT * FROM ko_refined ORDER BY ko_refined.semester_code ) ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty
)
LEFT JOIN ko_specialties_per_student ON (
  ko_refined.student_index = ko_specialties_per_student.student_index
)
GROUP BY
  ko_refined.student_index,
  ko_refined.faculty,
  ko_refined.studies_modetier,
  ko_refined.studies_field,
  ko_refined.studies_specialty
ORDER BY
  ko_refined.student_index,
  ko_refined.faculty,
  ko_refined.studies_modetier,
  ko_refined.studies_field,
  ko_refined.studies_specialty;

-- Students with related specialties
CREATE VIEW ko_student_specialties AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  ko_refined.faculty AS faculty,
  ko_refined.studies_modetier AS studies_modetier,
  ko_refined.studies_field AS studies_field,
  ko_refined.studies_specialty AS studies_specialty,
  ko_specialties_per_student.studies_specialties_count AS studies_specialties_count
FROM ko_refined
LEFT JOIN ko_specialties_per_student ON
  ko_refined.student_index = ko_specialties_per_student.student_index
GROUP BY ko_refined.student_index, studies_modetier, studies_field, studies_specialty
ORDER BY ko_refined.student_index, studies_modetier, studies_field, studies_specialty;

-- Students with related programs
CREATE VIEW ko_student_programs AS
SELECT
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  ko_refined.faculty AS faculty,
  ko_refined.studies_modetier AS studies_modetier,
  ko_refined.studies_field AS studies_field,
  ko_programs_per_student.studies_programs_count AS studies_programs_count
FROM ko_refined
LEFT JOIN ko_programs_per_student ON
  ko_refined.student_index = ko_programs_per_student.student_index
GROUP BY ko_refined.student_index, studies_modetier, studies_field
ORDER BY ko_refined.student_index, studies_modetier, studies_field;



------ Number of distinct study programs for each student
----CREATE VIEW ko_programs_per_student AS
----SELECT
----  joined.preamble_student_index AS student_index,
----  joined.preamble_student_name AS student_name,
----  GROUP_CONCAT(DISTINCT ko_studies_program_codes.studies_program_code) AS studies_program_codes,
----  COUNT(DISTINCT ko_studies_program_codes.studies_program_code) AS studies_programs_count,
----FROM joined
----LEFT JOIN ko_studies_program_codes ON (
----  joined.header_faculty = ko_studies_program_codes.faculty AND
----  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
----  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
----  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
----)
----GROUP BY student_index
----ORDER BY student_index;
----
------ Distinct semesters for each student on a given program
----CREATE VIEW ko_semesters_per_student_program AS
----SELECT
----  joined.preamble_student_index AS student_index,
----  joined.preamble_student_name AS student_name,
----  ko_studies_program_codes.studies_program_code AS studies_program_code,
----  GROUP_CONCAT(DISTINCT joined.preamble_semester_code) AS semester_codes,
----  COUNT(DISTINCT joined.preamble_semester_code) AS semesters_count
----FROM joined
----LEFT JOIN ko_studies_program_codes ON (
----  joined.header_faculty = ko_studies_program_codes.faculty AND
----  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
----  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
----  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
----)
----GROUP BY student_index, studies_program_code
----ORDER BY student_index, studies_program_code;
----
------ Distinct programs for every student on a given semester
----CREATE VIEW ko_programs_per_student_semester AS
----SELECT
----  joined.preamble_student_index AS student_index,
----  joined.preamble_student_name AS student_name,
----  joined.preamble_semester_code AS semester_code,
----  GROUP_CONCAT(DISTINCT ko_studies_program_codes.studies_program_code) AS studies_program_codes,
----  COUNT(DISTINCT ko_studies_program_codes.studies_program_code) AS studies_programs_count
----FROM joined
----LEFT JOIN ko_studies_program_codes ON (
----  joined.header_faculty = ko_studies_program_codes.faculty AND
----  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
----  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
----  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
----)
----GROUP BY student_index, semester_code
----ORDER BY student_index, semester_code;
----
------ Students on programs (according to ko)
----CREATE VIEW ko_students_programs AS
----SELECT DISTINCT
----  joined.preamble_student_index AS student_index,
----  joined.preamble_student_name AS student_name,
----  joined.header_faculty AS faculty,
----  joined.preamble_studies_modetier AS studies_modetier,
----  joined.preamble_studies_field AS studies_field,
----  joined.preamble_studies_specialty AS studies_specialty,
----  ko_studies_program_codes.studies_program_code AS studies_program_code,
----  ko_programs_per_student.studies_programs_count AS distinct_studies_programs_count
----FROM joined
----LEFT JOIN ko_studies_program_codes ON (
----  joined.header_faculty = ko_studies_program_codes.faculty AND
----  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
----  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
----  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
----) LEFT JOIN ko_programs_per_student ON (
----  joined.preamble_student_index = ko_programs_per_student.student_index
----)
----ORDER BY student_index, studies_program_code;
--
---- Students on programs (according to ko)
--CREATE VIEW kosp AS
--SELECT DISTINCT
--  joined.preamble_student_index AS student_index,
--  joined.preamble_student_name AS student_name,
--  joined.header_faculty AS faculty,
--  joined.preamble_studies_modetier AS studies_modetier,
--  joined.preamble_studies_field AS studies_field,
--  joined.preamble_studies_specialty AS studies_specialty,
--  ko_studies_program_codes.studies_program_code AS studies_program_code
--FROM joined
--LEFT JOIN ko_studies_program_codes ON (
--  joined.header_faculty = ko_studies_program_codes.faculty AND
--  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
--  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
--  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
--)
--ORDER BY student_index, studies_program_code;
--
---- Students on programs (according to ko + usos)
--CREATE VIEW kousossp AS
--SELECT
--  kosp.student_index AS ko_student_index,
--  kosp.student_name AS ko_student_name,
--  kosp.faculty AS ko_faculty,
--  kosp.studies_modetier AS ko_studies_modetier,
--  kosp.studies_field AS ko_studies_field,
--  kosp.studies_specialty AS ko_studies_specialty,
--  kosp.studies_program_code AS ko_studies_program_code,
--  usos_allstudents.person_id AS usos_person_id,
--  usos_allstudents.last_name AS usos_last_name,
--  usos_allstudents.first_name AS usos_first_name,
--  usos_allstudents.second_name AS usos_second_name,
--  usos_allstudents.student_index AS usos_student_index,
--  usos_allstudents.studies_program_code AS usos_studies_program_code,
--  usos_allstudents.progs_id AS usos_progs_id,
--  usos_allstudents.admission_date AS usos_admission_date,
--  usos_allstudents.max_cdyd AS usos_max_cdyd,
--  usos_allstudents.max_stage AS usos_max_stage,
--  usos_allstudents.discontinuation_date AS usos_discontinuation_date,
--  usos_allstudents.dissertation_date AS usos_dissertation_date,
--  usos_allstudents.studies_tier AS usos_studies_tier,
--  usos_allstudents.studies_mode AS usos_studies_mode,
--  usos_allstudents.studies_program_description AS usos_studies_program_description
--FROM kosp
--LEFT JOIN usos_allstudents ON (
--  kosp.student_index = usos_allstudents.student_index AND
--  kosp.studies_program_code = usos_allstudents.studies_program_code
--);
--
--CREATE VIEW kospcounts AS
--SELECT
--  student_index,
--  COUNT(DISTINCT studies_program_code) AS student_programs_count
--FROM kosp
--GROUP BY student_index;
--
--
--CREATE VIEW kospwithcounts AS
--SELECT
--  kosp.*,
--  kospcounts.student_programs_count
--FROM kosp
--LEFT JOIN kospcounts
--  ON kosp.student_index = kospcounts.student_index;
--
--
--CREATE VIEW kousosspcounts AS
--SELECT
--  ko_student_index AS student_index,
--  COUNT(DISTINCT usos_progs_id) AS distinct_progs_id_count
--FROM kousossp
--GROUP BY ko_student_index;
--
--CREATE VIEW kousosspwithcounts AS
--SELECT
--  kousossp.ko_student_index,
--  kousossp.ko_student_name,
--  kousossp.ko_faculty,
--  kousossp.ko_studies_modetier,
--  kousossp.ko_studies_field,
--  kousossp.ko_studies_specialty,
--  kousossp.ko_studies_program_code,
--  kousossp.usos_person_id,
--  kousossp.usos_last_name,
--  kousossp.usos_first_name,
--  kousossp.usos_second_name,
--  kousossp.usos_student_index,
--  kousossp.usos_studies_program_code,
--  kousossp.usos_progs_id,
--  kousossp.usos_admission_date,
--  kousossp.usos_max_cdyd,
--  kousossp.usos_max_stage,
--  kousossp.usos_discontinuation_date,
--  kousossp.usos_dissertation_date,
--  kousossp.usos_studies_tier,
--  kousossp.usos_studies_mode,
--  kousossp.usos_studies_program_description,
--  kousosspcounts.distinct_progs_id_count
--FROM kousossp
--LEFT JOIN kousosspcounts
--  ON kousossp.ko_student_index = kousosspcounts.student_index;
--
---- Grades with students on programs (according to ko)
--CREATE VIEW kogsp AS
--SELECT
--  joined.tr_subj_code AS subj_code,
--  joined.tr_subj_name AS subj_name,
--  joined.tr_subj_hours_w AS subj_hours_w,
--  joined.tr_subj_hours_c AS subj_hours_c,
--  joined.tr_subj_hours_l AS subj_hours_l,
--  joined.tr_subj_hours_p AS subj_hours_p,
--  joined.tr_subj_hours_s AS subj_hours_s,
--  joined.tr_subj_credit_kind AS subj_credit_kind,
--  joined.tr_subj_ects AS subj_ects,
--  joined.tr_subj_tutor AS subj_tutor,
--  joined.tr_subj_grade AS subj_grade,
--  joined.tr_subj_grade_date AS subj_grade_date,
--  --joined.tbody_remark,
--  joined.page_page_number AS page_number,
--  --joined.page_parser_page_number,
--  --joined.sheet_pages_parsed,
--  --joined.sheet_first_page,
--  joined.sheet_ects_mandatory AS ects_mandatory,
--  joined.sheet_ects_other AS ects_other,
--  joined.sheet_ects_total AS ects_total,
--  joined.sheet_ects_attained AS ects_attained,
--  joined.report_source AS report_source,
--  joined.report_datetime AS report_datetime,
--  --joined.report_first_page,
--  --joined.report_sheets_parsed,
--  --joined.report_pages_parsed,
--  joined.preamble_studies_modetier AS studies_modetier,
--  joined.preamble_title AS title,
--  joined.preamble_student_index AS student_index,
--  joined.preamble_first_name AS first_name,
--  joined.preamble_last_name AS last_name,
--  joined.preamble_student_name AS student_name,
--  joined.preamble_semester_code AS semester_code,
--  joined.preamble_studies_field AS studies_field,
--  joined.preamble_semester_number AS semester_number,
--  joined.preamble_studies_specialty AS studies_specialty,
--  joined.header_university AS university,
--  joined.header_faculty AS faculty,
--  joined.footer_pagination AS footer_pagination,
--  joined.footer_sheet_page_number AS sheet_page_number,
--  joined.footer_sheet_pages_total AS sheet_pages_total,
--  joined.footer_generator_name AS generator_name,
--  joined.footer_generator_home AS generator_home,
--  ko_studies_program_codes.studies_program_code AS studies_program_code
--FROM joined
--LEFT JOIN ko_studies_program_codes ON (
--  joined.header_faculty = ko_studies_program_codes.faculty AND
--  joined.preamble_studies_modetier = ko_studies_program_codes.studies_modetier AND
--  joined.preamble_studies_field = ko_studies_program_codes.studies_field AND
--  joined.preamble_studies_specialty = ko_studies_program_codes.studies_specialty
--);
--
---- Grades + students on programs (according to ko + usos)
--CREATE VIEW kogusossp AS
--SELECT
--  kogsp.subj_code AS ko_subj_code,
--  kogsp.subj_name AS ko_subj_name,
--  kogsp.subj_hours_w AS ko_subj_hours_w,
--  kogsp.subj_hours_c AS ko_subj_hours_c,
--  kogsp.subj_hours_l AS ko_subj_hours_l,
--  kogsp.subj_hours_p AS ko_subj_hours_p,
--  kogsp.subj_hours_s AS ko_subj_hours_s,
--  kogsp.subj_credit_kind AS ko_subj_credit_kind,
--  kogsp.subj_ects AS ko_subj_ects,
--  kogsp.subj_tutor AS ko_subj_tutor,
--  kogsp.subj_grade AS ko_subj_grade,
--  kogsp.subj_grade_date AS ko_subj_grade_date,
--    --joined.tbody_remark,
--  kogsp.page_number AS ko_page_number,
--    --joined.page_parser_page_number,
--    --joined.sheet_pages_parsed,
--    --joined.sheet_first_page,
--  kogsp.ects_mandatory AS ko_ects_mandatory,
--  kogsp.ects_other AS ko_ects_other,
--  kogsp.ects_total AS ko_ects_total,
--  kogsp.ects_attained AS ko_ects_attained,
--  kogsp.report_source AS ko_report_source,
--  kogsp.report_datetime AS ko_report_datetime,
--    --joined.report_first_page,
--    --joined.report_sheets_parsed,
--    --joined.report_pages_parsed,
--  kogsp.studies_modetier AS ko_studies_modetier,
--  kogsp.title AS ko_title,
--  kogsp.student_index AS ko_student_index,
--  kogsp.first_name AS ko_first_name,
--  kogsp.last_name AS ko_last_name,
--  kogsp.student_name AS ko_student_name,
--  kogsp.semester_code AS ko_semester_code,
--  kogsp.studies_field AS ko_studies_field,
--  kogsp.semester_number AS ko_semester_number,
--  kogsp.studies_specialty AS ko_studies_specialty,
--  kogsp.university AS ko_university,
--  kogsp.faculty AS ko_faculty,
--  kogsp.footer_pagination AS ko_footer_pagination,
--  kogsp.sheet_page_number AS ko_sheet_page_number,
--  kogsp.sheet_pages_total AS ko_sheet_pages_total,
--  kogsp.generator_name AS ko_generator_name,
--  kogsp.generator_home AS ko_generator_home,
--  kogsp.studies_program_code AS ko_studies_program_code,
--  usos_allstudents.person_id AS usos_person_id,
--  usos_allstudents.last_name AS usos_last_name,
--  usos_allstudents.first_name AS usos_first_name,
--  usos_allstudents.second_name AS usos_second_name,
--  usos_allstudents.student_index AS usos_student_index,
--  usos_allstudents.studies_program_code AS usos_studies_program_code,
--  usos_allstudents.progs_id AS usos_progs_id,
--  usos_allstudents.admission_date AS usos_admission_date,
--  usos_allstudents.max_cdyd AS usos_max_cdyd,
--  usos_allstudents.max_stage AS usos_max_stage,
--  usos_allstudents.discontinuation_date AS usos_discontinuation_date,
--  usos_allstudents.dissertation_date AS usos_dissertation_date,
--  usos_allstudents.studies_tier AS usos_studies_tier,
--  usos_allstudents.studies_mode AS usos_studies_mode,
--  usos_allstudents.studies_program_description AS usos_studies_program_description
--FROM kogsp
--LEFT JOIN usos_allstudents ON (
--  kogsp.student_index = usos_allstudents.student_index AND
--  kogsp.studies_program_code = usos_allstudents.studies_program_code
--);
--
--CREATE VIEW kogusosspcounts AS
--SELECT
--  ko_student_index AS student_index,
--  ko_subj_code AS subj_code,
--  ko_subj_grade_date AS subj_grade_date,
--  COUNT(DISTINCT usos_progs_id) AS distinct_progs_id_count
--FROM kogusossp
--GROUP BY ko_student_index, ko_subj_code, ko_subj_grade_date;
--
--CREATE VIEW kogusosspwithcounts AS
--SELECT
--  kogusossp.*,
--  kogusosspcounts.distinct_progs_id_count
--FROM kogusossp
--LEFT JOIN kogusosspcounts ON (
--  kogusossp.ko_student_index = kogusosspcounts.student_index AND
--  kogusossp.ko_subj_code = kogusosspcounts.subj_code AND
--  kogusossp.ko_subj_grade_date = kogusosspcounts.subj_grade_date
--);


