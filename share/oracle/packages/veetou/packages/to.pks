CREATE OR REPLACE PACKAGE V2U_To AUTHID CURRENT_USER AS
--    FUNCTION Number_Or_Null(value IN VARCHAR2) RETURN INTEGER;
    FUNCTION Semester_Code(semester_id IN NUMBER) RETURN VARCHAR2;
    FUNCTION Semester_Id(semester_code IN VARCHAR2) RETURN NUMBER;
    FUNCTION Threads(semesters IN V2u_Ko_Semesters_t)
        RETURN V2u_Ko_Semester_Threads_t;

    FUNCTION Ko_Student(
              job_uuid IN RAW
            , id IN NUMBER := NULL
            , preamble IN V2u_Ko_Preamble_t
            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Student_t;

    FUNCTION Ko_Semester(
              id IN NUMBER := NULL
            , job_uuid IN RAW
            , sheet IN V2u_Ko_Sheet_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN V2u_Ko_Semester_t;

    FUNCTION Ko_Subject(
              id IN NUMBER := NULL
            , job_uuid IN RAW
            , tr IN V2u_Ko_Tr_t
            /*, subj_grades IN V2u_Subj_20Grades_t := NULL */
            , tr_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_t;

--    FUNCTION Ko_Subject_Entity(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , header IN V2u_Ko_Header_t
--            , preamble IN V2u_Ko_Preamble_t
--            , tr IN V2u_Ko_Tr_t
--            , subj_grades IN V2u_Subj_20Grades_t := NULL
--            , tr_ids IN V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Subject_Entity_t;

--    FUNCTION Ko_Specialty_Semester(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , specialty IN REF V2u_Ko_Specialty_t
--            , sheet IN V2u_Ko_Sheet_t
--            , preamble IN V2u_Ko_Preamble_t
--            , sheet_ids V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Specialty_Semester_t;

--    FUNCTION Ko_Specialty_Semester(
--              job_uuid IN RAW
--            , id IN NUMBER := NULL
--            , sheet IN V2u_Ko_Sheet_t
--            , header IN V2u_Ko_Header_t
--            , preamble IN V2u_Ko_Preamble_t
--            , sheet_ids V2u_Ids_t := NULL
--            ) RETURN V2u_Ko_Specialty_Semester_t;

    FUNCTION Ko_Specialty(
              job_uuid IN RAW
            , id IN NUMBER := NULL
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            ) RETURN V2u_Ko_Specialty_t;

--    FUNCTION Ko_Mapped_Subject(
--              subject_entity IN V2u_Ko_Subject_Entity_t
--            , subject_map IN V2u_Subject_Map_t
--            , matching_score IN NUMBER := NULL
--            ) RETURN V2u_Ko_Mapped_Subject_t;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
