CREATE or replace VIEW YCC_view_RPT_Patient_Detail AS
select 
 pid1.identifier AS 'patient_identifier'
,concat(coalesce(per.given_name,''),' ',coalesce(per.middle_name,''),' ',coalesce(per.family_name,'')) AS 'patient_name'
,date_format(p.birthdate, "%d-%b-%Y") as 'patient_birthdate'
,p.date_created AS 'patient_create_date'
,timestampdiff(month,p.birthdate,pa.date_created)/12 As 'patient_age_at_registration'
,timestampdiff(month,p.birthdate,curdate())/12 As 'patient_age_now'
,p.gender AS 'patient_gender'
, (select lc.value_coded_name from YCC_view_obs_last_coded_value lc where lc.person_id=pa.patient_id and lc.concept_name='Cleft Type') AS 'type_of_cleft'      -- diagnosis short name: CL CP or CLP
, coalesce((select max('Y') from YCC_view_obs ro where ro.person_id = pa.patient_id and ro.form_name='Patient Treatment Plan'),'N')  
   AS 'treatment_plan_exists'       -- If Patient Treatment Plan OBS form exists, set to "Y". Else "N"
-- ,if(p.date_created>=@start_date,'N','E')  as 'new_patient'                -- If Patient Registration date = or > beginning of reporting period, set to "N". Else "E"
-- the following two values determine "patient_status":
, (select not(isnull(lc.value_datetime)) from YCC_view_obs_last_date_value lc where lc.person_id=pa.patient_id and lc.concept_name='Is Closed - Discharge') AS 'is_closed_Discharge'
, (select not(isnull(lc.value_datetime)) from YCC_view_obs_last_date_value lc where lc.person_id=pa.patient_id and lc.concept_name='Is Closed - Lost Contact') AS 'is_closed_Lost_Contact'
-- ,'' AS 'patient_status'                     -- Patient Status A = Active D = Drop Out C = Completed all treatment
--                                             -- Based on Patient Case Status on the Patient Treatment Plan OBS form. 
--                                             -- If Patient Case Status "Is Closed - Discharge",  set to "C";  If "Is Closed - Lost Contact", set to "D" else set to "A"
, (select lc.value_coded_name from YCC_view_obs_last_coded_value lc where lc.person_id=pa.patient_id and lc.concept_name='Current Education Level') AS 'Current_Education_Level'      -- diagnosis short name: CL CP or CLP
-- ,'' AS 'school_status'       -- School status E=Enrolled G=Graduated N=Not school aged O=Out of school (if school-aged)
                             -- From "Current Education Level" on most recent patient Visit:
							 -- If Current Education Level is:
							 -- "Not old enough for school" set to "N"
							 -- "Primary school-aged - not in school" set to O
							 -- "Attending primary school" set to E
							 -- "Completed primary school" set to G
							 -- "Secondary school-aged - not in school" set to O
							 -- "Attending secondary school" set to E
							 -- "Completed secondary school" set to G
							 -- "Attending college or university" set to E
							 -- "Completed college or univerity" set to G

,DATE_FORMAT(p.date_created, "%d-%b-%Y")  AS 'registration_date'
,pa.voided AS 'patient_voided'
,p.voided AS 'person_voided'
,per.voided AS 'person_name_voided'
,pa.patient_id as 'internal_Patient_id'
from patient pa 
left outer join person_name per on pa.patient_id=per.person_id
left outer join person p on pa.patient_id=p.person_id 
left outer join patient_identifier pid1 on pa.patient_id=pid1.patient_id and pid1.identifier_type=3 -- 3 = patient_id 4 = Yekatit OPD
where p.voided = 0 and pa.voided = 0
;
-- select * from RPT_View_Patient_Detail ; --  WHERE patient_create_date BETWEEN date('1/1/2000') AND DATE('1/1/2025');      -- '#startDate#' and '#endDate#';
