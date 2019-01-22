CREATE OR REPLACE PACKAGE BODY V2U_To AS
    FUNCTION Ko_Semester_Instance(
              job_uuid IN RAW
            , id IN NUMBER
            , preamble IN V2u_Ko_Preamble_t
            , sheet IN V2u_Ko_Sheet_t
            ) RETURN V2u_Ko_Semester_Instance_t
    IS
    BEGIN
        RETURN V2u_Ko_Semester_Instance_t(
                  job_uuid => job_uuid
                , id => id
                , semester_code => preamble.semester_code
                , semester_number => preamble.semester_number
                , ects_mandatory => sheet.ects_mandatory
                , ects_other => sheet.ects_other
                , ects_total => sheet.ects_total
                , ects_attained => sheet.ects_attained
                , sheet_id => sheet.id
                );
    END;

    FUNCTION Ko_Subject_Instance(
              job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , tr IN V2u_Ko_Tr_t
            , subj_grades IN V2u_Ko_Subj_Grades_t := NULL
            ) RETURN V2u_Ko_Subject_Instance_t
    IS
    BEGIN
        RETURN V2u_Ko_Subject_Instance_t(
              job_uuid => job_uuid
            , id => id
            , university => header.university
            , faculty => header.faculty
            , studies_modetier => preamble.studies_modetier
            , studies_field => preamble.studies_field
            , studies_specialty => preamble.studies_specialty
            , semester_code => preamble.semester_code
            , subj_code => tr.subj_code
            , subj_name => tr.subj_name
            , subj_hours_w => tr.subj_hours_w
            , subj_hours_c => tr.subj_hours_c
            , subj_hours_l => tr.subj_hours_l
            , subj_hours_p => tr.subj_hours_p
            , subj_hours_s => tr.subj_hours_s
            , subj_credit_kind => tr.subj_credit_kind
            , subj_ects => tr.subj_ects
            , subj_tutor => tr.subj_tutor
            , subj_grades => subj_grades
            );
    END;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
