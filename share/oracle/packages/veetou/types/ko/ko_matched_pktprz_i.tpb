CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Pktprz_I_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Pktprz_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            , ilosc_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subject_map_id => subject_map_id
            , prz_kod => prz_kod
            , pktprz_id => pktprz_id
            , prg_kod => prg_kod
            , cdyd_pocz => cdyd_pocz
            , cdyd_kon => cdyd_kon
            , ilosc_missmatch => ilosc_missmatch
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            , ilosc_missmatch IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subject_map_id => subject_map_id
            , prz_kod => prz_kod
            );
        SELF.pktprz_id := pktprz_id;
        SELF.prg_kod := prg_kod;
        SELF.cdyd_pocz := cdyd_pocz;
        SELF.cdyd_kon := cdyd_kon;
        SELF.ilosc_missmatch := ilosc_missmatch;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
