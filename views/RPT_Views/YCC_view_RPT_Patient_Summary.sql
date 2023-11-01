--  Patient Summary Report
create or replace view YCC_view_RPT_Patient_Summary as
Select 
  p.patient_identifier                as 'Patient_identifier'
, p.patient_name                      as 'Patient_Name'
, p.patient_birthdate                 as 'DOB'
, p.patient_gender                    as 'gender'
, p.type_of_cleft                     as 'Type_of_Cleft'
, p.treatment_plan_exists             as 'Treatment_Plan_exists'
, p.patient_create_date               as 'Patient_create_date'  -- if(p.patient_create_date>=@start_date,'N','E')  as 'isNewPatient'                -- If Patient Registration date = or > beginning of reporting period, set to "N". Else "E"
, if(p.is_closed_Discharge,'C',if(p.is_closed_Lost_Contact,"D","A")) as 'Status'
											-- Patient Status A = Active D = Drop Out C = Completed all treatment
                                            -- Based on Patient Case Status on the Patient Treatment Plan OBS form. 
                                            -- If Patient Case Status "Is Closed - Discharge",  set to "C";  If "Is Closed - Lost Contact", set to "D" else set to "A"
, Case 
    WHEN p.Current_Education_Level = 'Not old enough for school'             THEN 'N'
    WHEN p.Current_Education_Level = 'Primary school-aged - not in school'   THEN 'O'
    WHEN p.Current_Education_Level = 'Attending primary school'              THEN 'E'
    WHEN p.Current_Education_Level = 'Completed primary school'              THEN 'G'
    WHEN p.Current_Education_Level = 'Secondary school-aged - not in school' THEN 'O'
    WHEN p.Current_Education_Level = 'Attending secondary school'            THEN 'E'
    WHEN p.Current_Education_Level = 'Completed secondary school'            THEN 'G'
    WHEN p.Current_Education_Level = 'Attending college or university'       THEN 'E'
    WHEN p.Current_Education_Level = 'Completed college or university'       THEN 'G'
    ELSE ''
  END
  AS 'School_Status' 
, p.patient_age_now
, p.internal_patient_id
from YCC_view_RPT_Patient_Detail p
;
