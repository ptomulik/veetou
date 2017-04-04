-- Students on programs (according to ko)
CREATE VIEW kosp AS
SELECT DISTINCT
  joined.preamble_student_index AS student_index,
  joined.preamble_student_name AS student_name,
  joined.header_faculty AS faculty,
  joined.preamble_studies_modetier AS studies_modetier,
  joined.preamble_studies_field AS studies_field,
  joined.preamble_studies_specialty AS studies_specialty,
  ko2prog.studies_program_code AS studies_program_code
FROM joined
LEFT JOIN ko2prog ON (
  joined.header_faculty = ko2prog.faculty AND
  joined.preamble_studies_modetier = ko2prog.studies_modetier AND
  joined.preamble_studies_field = ko2prog.studies_field AND
  joined.preamble_studies_specialty = ko2prog.studies_specialty
)
ORDER BY student_index, studies_program_code;

-- Students on programs (according to ko + usos)
CREATE VIEW kousossp AS
SELECT
  kosp.student_index AS ko_student_index,
  kosp.student_name AS ko_student_name,
  kosp.faculty AS ko_faculty,
  kosp.studies_modetier AS ko_studies_modetier,
  kosp.studies_field AS ko_studies_field,
  kosp.studies_specialty AS ko_studies_specialty,
  kosp.studies_program_code AS ko_studies_program_code,
  usossp.person_id AS usos_person_id,
  usossp.last_name AS usos_last_name,
  usossp.first_name AS usos_first_name,
  usossp.second_name AS usos_second_name,
  usossp.student_index AS usos_student_index,
  usossp.studies_program_code AS usos_studies_program_code,
  usossp.progs_id AS usos_progs_id,
  usossp.admission_date AS usos_admission_date,
  usossp.max_cdyd AS usos_max_cdyd,
  usossp.max_stage AS usos_max_stage,
  usossp.discontinuation_date AS usos_discontinuation_date,
  usossp.dissertation_date AS usos_dissertation_date,
  usossp.studies_tier AS usos_studies_tier,
  usossp.studies_mode AS usos_studies_mode,
  usossp.studies_program_description AS usos_studies_program_description
FROM kosp
LEFT JOIN usossp ON (
  kosp.student_index = usossp.student_index AND
  kosp.studies_program_code = usossp.studies_program_code
);

CREATE VIEW kospcounts AS
SELECT
  student_index,
  COUNT(DISTINCT studies_program_code) AS student_programs_count
FROM kosp
GROUP BY student_index;


CREATE VIEW kospwithcounts AS
SELECT
  kosp.*,
  kospcounts.student_programs_count
FROM kosp
LEFT JOIN kospcounts
  ON kosp.student_index = kospcounts.student_index;


CREATE VIEW kousosspcounts AS
SELECT
  ko_student_index AS student_index,
  COUNT(DISTINCT usos_progs_id) AS distinct_progs_id_count
FROM kousossp
GROUP BY ko_student_index;

CREATE VIEW kousosspwithcounts AS
SELECT
  kousossp.ko_student_index,
  kousossp.ko_student_name,
  kousossp.ko_faculty,
  kousossp.ko_studies_modetier,
  kousossp.ko_studies_field,
  kousossp.ko_studies_specialty,
  kousossp.ko_studies_program_code,
  kousossp.usos_person_id,
  kousossp.usos_last_name,
  kousossp.usos_first_name,
  kousossp.usos_second_name,
  kousossp.usos_student_index,
  kousossp.usos_studies_program_code,
  kousossp.usos_progs_id,
  kousossp.usos_admission_date,
  kousossp.usos_max_cdyd,
  kousossp.usos_max_stage,
  kousossp.usos_discontinuation_date,
  kousossp.usos_dissertation_date,
  kousossp.usos_studies_tier,
  kousossp.usos_studies_mode,
  kousossp.usos_studies_program_description,
  kousosspcounts.distinct_progs_id_count
FROM kousossp
LEFT JOIN kousosspcounts
  ON kousossp.ko_student_index = kousosspcounts.student_index;

-- Grades with students on programs (according to ko)
CREATE VIEW kogsp AS
SELECT
  joined.tr_subj_code AS subj_code,
  joined.tr_subj_name AS subj_name,
  joined.tr_subj_hours_w AS subj_hours_w,
  joined.tr_subj_hours_c AS subj_hours_c,
  joined.tr_subj_hours_l AS subj_hours_l,
  joined.tr_subj_hours_p AS subj_hours_p,
  joined.tr_subj_hours_s AS subj_hours_s,
  joined.tr_subj_credit_kind AS subj_credit_kind,
  joined.tr_subj_ects AS subj_ects,
  joined.tr_subj_tutor AS subj_tutor,
  joined.tr_subj_grade AS subj_grade,
  joined.tr_subj_grade_date AS subj_grade_date,
  --joined.tbody_remark,
  joined.page_page_number AS page_number,
  --joined.page_parser_page_number,
  --joined.sheet_pages_parsed,
  --joined.sheet_first_page,
  joined.sheet_ects_mandatory AS ects_mandatory,
  joined.sheet_ects_other AS ects_other,
  joined.sheet_ects_total AS ects_total,
  joined.sheet_ects_attained AS ects_attained,
  joined.report_source AS report_source,
  joined.report_datetime AS report_datetime,
  --joined.report_first_page,
  --joined.report_sheets_parsed,
  --joined.report_pages_parsed,
  joined.preamble_studies_modetier AS studies_modetier,
  joined.preamble_title AS title,
  joined.preamble_student_index AS student_index,
  joined.preamble_first_name AS first_name,
  joined.preamble_last_name AS last_name,
  joined.preamble_student_name AS student_name,
  joined.preamble_semester_code AS semester_code,
  joined.preamble_studies_field AS studies_field,
  joined.preamble_semester_number AS semester_number,
  joined.preamble_studies_specialty AS studies_specialty,
  joined.header_university AS university,
  joined.header_faculty AS faculty,
  joined.footer_pagination AS footer_pagination,
  joined.footer_sheet_page_number AS sheet_page_number,
  joined.footer_sheet_pages_total AS sheet_pages_total,
  joined.footer_generator_name AS generator_name,
  joined.footer_generator_home AS generator_home,
  ko2prog.studies_program_code AS studies_program_code
FROM joined
LEFT JOIN ko2prog ON (
  joined.header_faculty = ko2prog.faculty AND
  joined.preamble_studies_modetier = ko2prog.studies_modetier AND
  joined.preamble_studies_field = ko2prog.studies_field AND
  joined.preamble_studies_specialty = ko2prog.studies_specialty
);

-- Grades + students on programs (according to ko + usos)
CREATE VIEW kogusossp AS
SELECT
  kogsp.subj_code AS ko_subj_code,
  kogsp.subj_name AS ko_subj_name,
  kogsp.subj_hours_w AS ko_subj_hours_w,
  kogsp.subj_hours_c AS ko_subj_hours_c,
  kogsp.subj_hours_l AS ko_subj_hours_l,
  kogsp.subj_hours_p AS ko_subj_hours_p,
  kogsp.subj_hours_s AS ko_subj_hours_s,
  kogsp.subj_credit_kind AS ko_subj_credit_kind,
  kogsp.subj_ects AS ko_subj_ects,
  kogsp.subj_tutor AS ko_subj_tutor,
  kogsp.subj_grade AS ko_subj_grade,
  kogsp.subj_grade_date AS ko_subj_grade_date,
    --joined.tbody_remark,
  kogsp.page_number AS ko_page_number,
    --joined.page_parser_page_number,
    --joined.sheet_pages_parsed,
    --joined.sheet_first_page,
  kogsp.ects_mandatory AS ko_ects_mandatory,
  kogsp.ects_other AS ko_ects_other,
  kogsp.ects_total AS ko_ects_total,
  kogsp.ects_attained AS ko_ects_attained,
  kogsp.report_source AS ko_report_source,
  kogsp.report_datetime AS ko_report_datetime,
    --joined.report_first_page,
    --joined.report_sheets_parsed,
    --joined.report_pages_parsed,
  kogsp.studies_modetier AS ko_studies_modetier,
  kogsp.title AS ko_title,
  kogsp.student_index AS ko_student_index,
  kogsp.first_name AS ko_first_name,
  kogsp.last_name AS ko_last_name,
  kogsp.student_name AS ko_student_name,
  kogsp.semester_code AS ko_semester_code,
  kogsp.studies_field AS ko_studies_field,
  kogsp.semester_number AS ko_semester_number,
  kogsp.studies_specialty AS ko_studies_specialty,
  kogsp.university AS ko_university,
  kogsp.faculty AS ko_faculty,
  kogsp.footer_pagination AS ko_footer_pagination,
  kogsp.sheet_page_number AS ko_sheet_page_number,
  kogsp.sheet_pages_total AS ko_sheet_pages_total,
  kogsp.generator_name AS ko_generator_name,
  kogsp.generator_home AS ko_generator_home,
  kogsp.studies_program_code AS ko_studies_program_code,
  usossp.person_id AS usos_person_id,
  usossp.last_name AS usos_last_name,
  usossp.first_name AS usos_first_name,
  usossp.second_name AS usos_second_name,
  usossp.student_index AS usos_student_index,
  usossp.studies_program_code AS usos_studies_program_code,
  usossp.progs_id AS usos_progs_id,
  usossp.admission_date AS usos_admission_date,
  usossp.max_cdyd AS usos_max_cdyd,
  usossp.max_stage AS usos_max_stage,
  usossp.discontinuation_date AS usos_discontinuation_date,
  usossp.dissertation_date AS usos_dissertation_date,
  usossp.studies_tier AS usos_studies_tier,
  usossp.studies_mode AS usos_studies_mode,
  usossp.studies_program_description AS usos_studies_program_description
FROM kogsp
LEFT JOIN usossp ON (
  kogsp.student_index = usossp.student_index AND
  kogsp.studies_program_code = usossp.studies_program_code
);

CREATE VIEW kogusosspcounts AS
SELECT
  ko_student_index AS student_index,
  ko_subj_code AS subj_code,
  ko_subj_grade_date AS subj_grade_date,
  COUNT(DISTINCT usos_progs_id) AS distinct_progs_id_count
FROM kogusossp
GROUP BY ko_student_index, ko_subj_code, ko_subj_grade_date;

CREATE VIEW kogusosspwithcounts AS
SELECT
  kogusossp.*,
  kogusosspcounts.distinct_progs_id_count
FROM kogusossp
LEFT JOIN kogusosspcounts ON (
  kogusossp.ko_student_index = kogusosspcounts.student_index AND
  kogusossp.ko_subj_code = kogusosspcounts.subj_code AND
  kogusossp.ko_subj_grade_date = kogusosspcounts.subj_grade_date
);


