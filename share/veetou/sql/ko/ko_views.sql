DROP VIEW IF EXISTS ko_refined;
CREATE VIEW ko_refined AS
SELECT
  ko_full.ko_tr_id AS tr_id,
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
FROM ko_full
;

DROP INDEX IF EXISTS ko_headers_idx1;
CREATE INDEX ko_headers_idx1
  ON ko_headers(faculty)
;

DROP INDEX IF EXISTS ko_preambles_idx1;
CREATE INDEX ko_preambles_idx1
  ON ko_preambles(student_index)
;

DROP INDEX IF EXISTS ko_preambles_idx2;
CREATE INDEX ko_preambles_idx2
  ON ko_preambles(studies_modetier)
;

DROP INDEX IF EXISTS ko_preambles_idx3;
CREATE INDEX ko_preambles_idx3
  ON ko_preambles(studies_field)
;

DROP INDEX IF EXISTS ko_preambles_idx4;
CREATE INDEX ko_preambles_idx4
  ON ko_preambles(studies_specialty)
;

DROP INDEX IF EXISTS ko_preambles_idx5;
CREATE INDEX ko_preambles_idx5
  ON ko_preambles(studies_modetier,studies_field,studies_specialty)
;

DROP INDEX IF EXISTS ko_trs_idx1;
CREATE INDEX ko_trs_idx1
  ON ko_trs(subj_code)
;

DROP INDEX IF EXISTS ko_trs_idx2;
CREATE INDEX ko_trs_idx2
  ON ko_trs(subj_grade_date)
;

DROP INDEX IF EXISTS ko_studies_program_codes_idx1;
CREATE INDEX ko_studies_program_codes_idx1
  ON ko_studies_program_codes(faculty,
                              studies_modetier,
                              studies_field,
                              studies_specialty)
;

DROP INDEX IF EXISTS ko_studies_program_codes_idx2;
CREATE INDEX ko_studies_program_codes_idx2
  ON ko_studies_program_codes(studies_field_code)
;

DROP INDEX IF EXISTS usos_dict_studies_specialties_idx1;
CREATE INDEX usos_dict_studies_specialties_idx1
  ON usos_dict_studies_specialties(studies_field_code)
;

DROP INDEX IF EXISTS usos_dict_studies_specialties_idx2;
CREATE INDEX usos_dict_studies_specialties_idx2
  ON usos_dict_studies_specialties(description_pl)
;

DROP INDEX IF EXISTS usos_dict_studies_specialties_idx3;
CREATE INDEX usos_dict_studies_specialties_idx3
  ON usos_dict_studies_specialties(description_en)
;

DROP INDEX IF EXISTS usos_allstudents_idx1;
CREATE INDEX usos_allstudents_idx1
  ON usos_allstudents(prgos_id)
;

DROP INDEX IF EXISTS usos_allstudents_idx2;
CREATE INDEX usos_allstudents_idx2
  ON usos_allstudents(student_index)
;

DROP INDEX IF EXISTS usos_allstudents_idx3;
CREATE INDEX usos_allstudents_idx3
  ON usos_allstudents(student_index,studies_program_code)
;

--CREATE INDEX faculty_usos_subj_codes_idx1
--  ON faculty_usos_subj_codes(subj_code)
--;


-- All studens found in ko reports
DROP VIEW IF EXISTS ko_students;
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
DROP VIEW IF EXISTS ko_specialties_per_student;
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
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
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
DROP VIEW IF EXISTS ko_programs_per_student;
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
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
GROUP BY student_index
ORDER BY student_index;

DROP VIEW IF EXISTS ko_program_codes_per_student_specialty;
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
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
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

DROP VIEW IF EXISTS ko_semesters_per_student_specialty;
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
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
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
DROP VIEW IF EXISTS ko_student_specialties;
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
DROP VIEW IF EXISTS ko_student_programs;
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

DROP VIEW IF EXISTS ko_programs_per_tr;
CREATE VIEW ko_programs_per_tr AS
SELECT
  ko_refined.tr_id AS tr_id,
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS student_name,
  ko_refined.subj_code AS subj_code,
  ko_refined.subj_name AS subj_name,
  ko_refined.subj_grade AS subj_grade,
  ko_refined.subj_grade_date AS subj_grade_date,
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
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
GROUP BY tr_id
ORDER BY tr_id;

DROP VIEW IF EXISTS usos_prgos_ids_per_ko_student_program;
CREATE VIEW usos_prgos_ids_per_ko_student_program AS
SELECT
  ko_refined.student_index AS ko_student_index,
  ko_refined.student_name AS ko_student_name,
  ko_refined.faculty AS ko_faculty,
  ko_refined.studies_modetier AS ko_studies_modetier,
  ko_refined.studies_field AS ko_studies_field,
  ko_refined.studies_specialty AS ko_studies_specialty,
  GROUP_CONCAT(DISTINCT ko_studies_program_codes.studies_program_code) AS ko_program_codes,
  COUNT(DISTINCT ko_studies_program_codes.studies_program_code) AS ko_program_codes_count,
  GROUP_CONCAT(DISTINCT usos_allstudents.prgos_id) AS usos_prgos_ids,
  COUNT(DISTINCT usos_allstudents.prgos_id) AS usos_prgos_ids_count
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
LEFT JOIN usos_allstudents ON (
  ko_refined.student_index = usos_allstudents.student_index AND
  ko_studies_program_codes.studies_program_code = usos_allstudents.studies_program_code
)
GROUP BY ko_student_index, ko_faculty, ko_studies_modetier, ko_studies_field, ko_studies_specialty
ORDER BY ko_student_index, ko_faculty, ko_studies_modetier, ko_studies_field, ko_studies_specialty
;

DROP VIEW IF EXISTS ko_students_usos_allstudents;
CREATE VIEW ko_students_usos_allstudents AS
SELECT
  ko_refined.student_index AS ko_student_index,
  ko_refined.student_name AS ko_student_name,
  ko_refined.university AS ko_university,
  ko_refined.faculty AS ko_faculty,
  ko_refined.studies_modetier AS ko_studies_modetier,
  ko_refined.studies_field AS ko_studies_field,
  ko_refined.studies_specialty AS ko_studies_specialty,
  ko_studies_program_codes.studies_program_code AS ko_studies_program_code,
  ko_refined.semester_code AS ko_semester_code,
  usos_cycles.cycle_start_date AS ko_semester_start_date,
  usos_cycles.cycle_end_date AS ko_semester_end_date,
  ko_refined.semester_number AS ko_semester_number,
  usos_allstudents.person_id AS usos_person_id,
  usos_allstudents.last_name AS usos_last_name,
  usos_allstudents.first_name AS usos_first_name,
  usos_allstudents.second_name AS usos_second_name,
  usos_allstudents.student_index AS usos_student_index,
  usos_allstudents.studies_program_code AS usos_studies_program_code,
  usos_allstudents.prgos_id AS usos_prgos_id,
  usos_allstudents.admission_date AS usos_admission_date,
  usos_allstudents.start_date AS usos_start_date,
  usos_allstudents.max_cdyd AS usos_max_cdyd,
  usos_allstudents.max_stage AS usos_max_stage,
  usos_allstudents.discontinuation_date AS usos_discontinuation_date,
  usos_allstudents.dissertation_date AS usos_dissertation_date,
  usos_allstudents.studies_tier AS usos_studies_tier,
  usos_allstudents.studies_mode AS usos_studies_mode,
  usos_allstudents.studies_program_description AS usos_studies_program_description,
  usos_prgos_ids_per_ko_student_program.ko_program_codes_count AS ko_program_codes_per_ko_student_program,
  usos_prgos_ids_per_ko_student_program.usos_prgos_ids_count AS usos_prgos_ids_per_ko_student_program,
  (ko_refined.semester_code <= usos_allstudents.max_cdyd)
      AS ko_semester_code_le_max_cdyd,
  (usos_cycles.cycle_start_date >= usos_allstudents.admission_date)
      AS ko_semester_start_date_ge_admission_date,
  (usos_cycles.cycle_start_date >= usos_allstudents.start_date)
      AS ko_semester_start_date_ge_start_date,
  (usos_cycles.cycle_end_date <= coalesce(usos_allstudents.discontinuation_date,
                                          usos_allstudents.dissertation_date))
      AS ko_semester_end_date_le_discontinuation_or_dissertation_date
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
LEFT JOIN usos_allstudents ON (
  ko_refined.student_index = usos_allstudents.student_index AND
  ko_studies_program_codes.studies_program_code = usos_studies_program_code
)
LEFT JOIN usos_prgos_ids_per_ko_student_program ON (
  ko_refined.student_index = usos_prgos_ids_per_ko_student_program.ko_student_index AND
  ko_refined.faculty = usos_prgos_ids_per_ko_student_program.ko_faculty AND
  ko_refined.studies_modetier = usos_prgos_ids_per_ko_student_program.ko_studies_modetier AND
  ko_refined.studies_field = usos_prgos_ids_per_ko_student_program.ko_studies_field AND
  (ko_refined.studies_specialty = usos_prgos_ids_per_ko_student_program.ko_studies_specialty OR
   ko_refined.studies_specialty IS NULL AND usos_prgos_ids_per_ko_student_program.ko_studies_specialty IS NULL)
)
LEFT JOIN usos_cycles ON
  ko_refined.semester_code = usos_cycles.cycle_code
WHERE usos_prgos_id IS NOT NULL OR usos_prgos_ids_per_ko_student_program = 0
GROUP BY ko_student_index, ko_faculty, ko_studies_modetier, ko_studies_field, ko_studies_specialty, ko_semester_code, usos_prgos_id
ORDER BY ko_student_index, ko_faculty, ko_studies_modetier, ko_studies_field, ko_studies_specialty, ko_semester_code, usos_prgos_id
;

DROP VIEW IF EXISTS usos_prgos_ids_per_ko_tr;
CREATE VIEW usos_prgos_ids_per_ko_tr AS
SELECT
  ko_refined.tr_id AS ko_tr_id,
  ko_refined.student_index AS student_index,
  ko_refined.student_name AS ko_student_name,
  ko_refined.subj_code AS ko_subj_code,
  ko_refined.subj_name AS ko_subj_name,
  ko_refined.subj_grade AS ko_subj_grade,
  ko_refined.subj_grade_date AS ko_subj_grade_date,
  ko_refined.semester_code AS ko_semester_code,
  ko_refined.faculty AS ko_faculty,
  ko_refined.studies_modetier AS ko_studies_modetier,
  ko_refined.studies_field AS ko_studies_field,
  ko_refined.studies_specialty AS ko_studies_specialty,
  ko_studies_program_codes.studies_program_code AS studies_program_code,
  GROUP_CONCAT(DISTINCT usos_allstudents.prgos_id) AS usos_prgos_ids,
  COUNT(DISTINCT usos_allstudents.prgos_id) AS usos_prgos_ids_count
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
LEFT JOIN usos_allstudents ON (
  ko_refined.student_index = usos_allstudents.student_index AND
  ko_studies_program_codes.studies_program_code = usos_allstudents.studies_program_code
)
GROUP BY ko_tr_id
ORDER BY ko_tr_id;

DROP VIEW IF EXISTS ko_tr_usos_allstudents;
CREATE VIEW ko_tr_usos_allstudents AS
SELECT
  ko_refined.tr_id AS ko_tr_id,
  ko_refined.subj_code AS ko_subj_code,
  faculty_usos_subj_codes.usos_subj_code AS usos_subj_code,
  ko_refined.subj_name AS ko_subj_name,
  ko_refined.student_index AS ko_student_index,
--  ko_refined.first_name AS ko_first_name,
--  ko_refined.last_name AS ko_last_name,
  ko_refined.student_name AS ko_student_name,
  ko_refined.subj_grade AS ko_subj_grade,
  ko_refined.subj_grade_date AS ko_subj_grade_date,
  ko_refined.university AS ko_university,
  ko_refined.faculty AS ko_faculty,
  ko_refined.studies_modetier AS ko_studies_modetier,
  ko_refined.studies_field AS ko_studies_field,
  ko_refined.studies_specialty AS ko_studies_specialty,
  ko_studies_program_codes.studies_program_code AS ko_studies_program_code,
  ko_refined.semester_code AS ko_semester_code,
  usos_cycles.cycle_start_date AS ko_semester_start_date,
  usos_cycles.cycle_end_date AS ko_semester_end_date,
  ko_refined.semester_number AS ko_semester_number,
  ko_refined.subj_tutor AS ko_subj_tutor,
  ko_refined.subj_hours_w AS ko_subj_hours_w,
  ko_refined.subj_hours_c AS ko_subj_hours_c,
  ko_refined.subj_hours_l AS ko_subj_hours_l,
  ko_refined.subj_hours_p AS ko_subj_hours_p,
  ko_refined.subj_hours_s AS ko_subj_hours_s,
  ko_refined.subj_credit_kind AS ko_subj_credit_kind,
  ko_refined.subj_ects AS ko_subj_ects,
  ko_refined.ects_mandatory AS ko_ects_mandatory,
  ko_refined.ects_other AS ko_ects_other,
  ko_refined.ects_total AS ko_ects_total,
  ko_refined.ects_attained AS ko_ects_attained,
  ko_refined.title AS ko_title,
  ko_refined.report_source AS ko_report_source,
  ko_refined.report_open_datetime AS ko_report_open_datetime,
  ko_refined.report_sheets_parsed AS ko_report_sheets_parsed,
  ko_refined.report_pages_parsed AS ko_report_pages_parsed,
  ko_refined.page_number AS ko_page_number,
  ko_refined.sheet_first_page AS ko_sheet_first_page,
  ko_refined.sheet_pages_parsed AS ko_sheet_pages_parsed,
  usos_allstudents.person_id AS usos_person_id,
  usos_allstudents.last_name AS usos_last_name,
  usos_allstudents.first_name AS usos_first_name,
  usos_allstudents.second_name AS usos_second_name,
  usos_allstudents.student_index AS usos_student_index,
  usos_allstudents.studies_program_code AS usos_studies_program_code,
  usos_allstudents.prgos_id AS usos_prgos_id,
  usos_allstudents.admission_date AS usos_admission_date,
  usos_allstudents.start_date AS usos_start_date,
  usos_allstudents.max_cdyd AS usos_max_cdyd,
  usos_allstudents.max_stage AS usos_max_stage,
  usos_allstudents.discontinuation_date AS usos_discontinuation_date,
  usos_allstudents.dissertation_date AS usos_dissertation_date,
  usos_allstudents.studies_tier AS usos_studies_tier,
  usos_allstudents.studies_mode AS usos_studies_mode,
  usos_allstudents.studies_program_description AS usos_studies_program_description,
  usos_prgos_ids_per_ko_tr.usos_prgos_ids_count AS usos_prgos_ids_per_ko_tr,
  (ko_refined.semester_code <= usos_allstudents.max_cdyd) AS ko_semester_code_le_max_cdyd,
  (usos_cycles.cycle_start_date >= usos_allstudents.admission_date) AS ko_semester_start_date_ge_admission_date,
  (usos_cycles.cycle_start_date >= usos_allstudents.start_date) AS ko_semester_start_date_ge_start_date,
  (usos_cycles.cycle_end_date <= coalesce(usos_allstudents.discontinuation_date, usos_allstudents.dissertation_date)) AS ko_semester_end_date_le_discontinuation_or_dissertation_date
FROM ko_refined
LEFT JOIN ko_studies_program_codes ON (
  ko_refined.faculty = ko_studies_program_codes.faculty AND
  ko_refined.studies_modetier = ko_studies_program_codes.studies_modetier AND
  ko_refined.studies_field = ko_studies_program_codes.studies_field AND
  (ko_refined.studies_specialty = ko_studies_program_codes.studies_specialty OR
   ko_refined.studies_specialty IS NULL AND ko_studies_program_codes.studies_specialty IS NULL)
)
LEFT JOIN faculty_usos_subj_codes ON (
  ko_refined.subj_code = faculty_usos_subj_codes.subj_code
)
LEFT JOIN usos_allstudents ON (
  ko_refined.student_index = usos_allstudents.student_index AND
  ko_studies_program_codes.studies_program_code = usos_allstudents.studies_program_code
)
LEFT JOIN usos_prgos_ids_per_ko_tr ON
  ko_refined.tr_id = usos_prgos_ids_per_ko_tr.ko_tr_id
LEFT JOIN usos_cycles ON
  ko_refined.semester_code = usos_cycles.cycle_code
WHERE usos_prgos_id IS NOT NULL OR usos_prgos_ids_per_ko_tr = 0
ORDER BY ko_tr_id, usos_prgos_id
;

DROP VIEW IF EXISTS ko_tr_usos_allstudents_matched;
CREATE VIEW ko_tr_usos_allstudents_matched AS
SELECT * FROM ko_tr_usos_allstudents
WHERE (usos_prgos_ids_per_ko_tr == 1) OR (
  usos_prgos_ids_per_ko_tr > 1 AND
  (ko_semester_start_date_ge_admission_date = 1 OR
   ko_semester_start_date_ge_start_date = 1) AND
  (ko_semester_end_date_le_discontinuation_or_dissertation_date = 1 OR
   ko_semester_end_date_le_discontinuation_or_dissertation_date IS NULL)
);


DROP VIEW IF EXISTS ko_tr_usos_allstudents_unmatched;
CREATE VIEW ko_tr_usos_allstudents_unmatched AS
SELECT * FROM ko_tr_usos_allstudents
WHERE ko_tr_id NOT IN (
  SELECT ko_tr_id FROM ko_tr_usos_allstudents_matched
);

DROP VIEW IF EXISTS ko_tr_usos_allstudents_matched_oceny_suplement_import;
CREATE VIEW ko_tr_usos_allstudents_matched_oceny_suplement_import AS
SELECT
  usos_student_index AS "Numer albumu",                     --  1;Numer albumu;VARCHAR2;30;T
  usos_first_name AS "Imię",                                --  2;Imię;VARCHAR2;40;T
  usos_last_name AS "Nazwisko",                             --  3;Nazwisko;VARCHAR2;40;T
  usos_studies_program_code AS "Kod programu",              --  4;Kod programu;VARCHAR2;20;N
  usos_admission_date AS  "Data przyjęcia lub wznowienia",  --  5;Data rozpoczęcia studiów;DATE; ;N
  usos_subj_code AS "Kod przedmiotu",                       --  6;Kod przedmiotu;VARCHAR2;20;N
  ko_semester_code AS "Kod cyklu dydaktycznego",            --  7;Kod cyklu dydaktycznego;VARCHAR2;20;T
  ko_subj_grade AS "Ocena",                                 --  8;Ocena;VARCHAR2;100;T
  ko_subj_code AS "Kod przedmiotu obcego - wydział",        --  9;Kod przedmiotu obcego - wydział;VARCHAR2;20;N
  ko_subj_name AS "Nazwa przedmiotu obcego PL",             -- 10;Nazwa przedmiotu obcego PL;VARCHAR2;200;N
  '' AS "Nazwa przedmiotu obcego ANG",                      -- 11;Nazwa przedmiotu obcego ANG;VARCHAR2;200;N
  '' AS "Język przedmiotu obcego",                          -- 12;Język przedmiotu obcego;VARCHAR2;3;N
  ko_subj_ects AS "Punkty ECTS",                            -- 13;Punkty ECTS;NUMBER;13,2;T
  ko_subj_hours_w AS "Liczba godzin wykład",                -- 14;Liczba godzin wykład;NUMBER;10;N
  ko_subj_hours_c AS "Liczba godzin ćwiczenia",             -- 15;Liczba godzin ćwiczenia;NUMBER;10;N
  ko_subj_hours_l AS "Liczba godzin laboratorium",          -- 16;Liczba godzin laboratorium;NUMBER;10;N
  ko_subj_hours_p AS "Liczba godzin projekt",               -- 17;Liczba godzin projekt;NUMBER;10;N
  ko_subj_hours_s AS "Liczba godzin seminarium dyplomowe",  -- 18;Liczba godzin seminarium dyplomowe;NUMBER;10;N
  '' AS "Ocena wykład",                                     -- 19;Ocena wykład;VARCHAR2;100;N
  '' AS "Ocena ćwiczenia",                                  -- 20;Ocena ćwiczenia;VARCHAR2;100;N
  '' AS "Ocena laboratorium",                               -- 21;Ocena laboratorium;VARCHAR2;100;N
  '' AS "Ocena projekt",                                    -- 22;Ocena projekt;VARCHAR2;100;N
  '' AS "Ocena seminarium dyplomowe",                       -- 23;Ocena seminarium dyplomowe;VARCHAR2;100;N
  '' AS "Kod etapu programu osoby",                         -- 24;Kod etapu programu osoby;VARCHAR2;20;N
  '' AS "Cykl etapu programu osoby"                         -- 25;Cykl etapu programu osoby;VARCHAR2;20;N
FROM ko_tr_usos_allstudents_matched;
