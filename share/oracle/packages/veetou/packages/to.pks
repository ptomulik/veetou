CREATE OR REPLACE PACKAGE V2U_To AUTHID CURRENT_USER AS
    FUNCTION Ko_Semester_Instance(
              job_uuid IN RAW
            , id IN NUMBER
            , preamble IN V2u_Ko_Preamble_t
            , sheet IN V2u_Ko_Sheet_t
            ) RETURN V2u_Ko_Semester_Instance_t;

    FUNCTION Ko_Subject_Instance(
              job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , tr IN V2u_Ko_Tr_t
            , subj_grades IN V2u_Ko_Subj_Grades_t := NULL
            , tr_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Instance_t;

    FUNCTION Ko_Specialty(
              job_uuid IN RAW
            , id IN NUMBER
            , subject_instance IN V2u_Ko_Subject_Instance_t
            , sheet_ids IN V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_t;

    FUNCTION Ko_Specialty(
              job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids V2u_Ko_Ids_t := NULL
            ) RETURN V2u_Ko_Specialty_t;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
