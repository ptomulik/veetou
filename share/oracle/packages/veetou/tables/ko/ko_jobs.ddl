CREATE TABLE v2u_ko_jobs
OF V2u_Ko_Job_t
    ( CONSTRAINT v2u_ko_jobs_pk PRIMARY KEY (job_uuid) )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
COMMENT ON TABLE v2u_ko_jobs IS 'Uruchomiena programu VEETOU na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_jobs.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU';
COMMENT ON COLUMN v2u_ko_jobs.job_timestamp IS 'Chwila czasowa uruchomienia VEETOU';
COMMENT ON COLUMN v2u_ko_jobs.job_host IS 'Host, na którym uruchomiono VEETOU';
COMMENT ON COLUMN v2u_ko_jobs.job_user IS 'Użytkownik, który dokonał uruchomienia';
COMMENT ON COLUMN v2u_ko_jobs.job_name IS 'Symboliczna nazwa uruchomienia';

-- vim: set ft=sql ts=4 sw=4 et:
