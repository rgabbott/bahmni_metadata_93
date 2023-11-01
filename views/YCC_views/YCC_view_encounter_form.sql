create or replace view YCC_view_encounter_form as
select 
 rov.person_id as 'patient_id'
,rov.encounter_id
,rov.visit_date_stopped
,rov.encounter_type
,(select et.name from encounter_type et where et.encounter_type_id = rov.encounter_type) as encounter_type_name
,rov.form_name
,CASE 
  When rov.form_name='Surgery Assessment' THEN 'Surgery'
  When rov.form_name='Surgery Intervention' THEN 'Surgery'
  When rov.form_name='Surgery Event' THEN 'Surgery'
  When rov.form_name='Nutrition Assessment' THEN 'Nutrition'
  When rov.form_name='Nutrition Intervention' THEN 'Nutrition'
  When rov.form_name='Speech Assessment for Patient 0 to 3yrs' THEN 'Speech'
  When rov.form_name='Speech Assessment for Patient 3yrs and older' THEN 'Speech'
  When rov.form_name='Speech Intervention for Patient 0 to 3yrs' THEN 'Speech'
  When rov.form_name='Speech Intervention for Patient 3yrs and older' THEN 'Speech'
  When rov.form_name='ENT Assessment' THEN 'ENT'
  When rov.form_name='ENT Nasopharyngeal Endoscopic Assessment' THEN 'ENT'
  When rov.form_name='ENT Intervention' THEN 'ENT'
  When rov.form_name='Dental and Orthodontic Assessment' THEN 'Dental'
  When rov.form_name='Dental and Orthodontic Intervention' THEN 'Dental'
  When rov.form_name='Social Work Assessment' THEN 'Social Work'
  When rov.form_name='Social Work Intervention' THEN 'Social Work'
  When rov.form_name is null THEN 'Other'
 ELSE 'Other'
 END AS YCC_Service
,CASE 
  When rov.form_name='Surgery Assessment' THEN 1
  When rov.form_name='Surgery Intervention' THEN 1
  When rov.form_name='Surgery Event' THEN 1
  When rov.form_name='Nutrition Assessment' THEN 5
  When rov.form_name='Nutrition Intervention' THEN 5
  When rov.form_name='Speech Assessment for Patient 0 to 3yrs' THEN 4
  When rov.form_name='Speech Assessment for Patient 3yrs and older' THEN 4
  When rov.form_name='Speech Intervention for Patient 0 to 3yrs' THEN 4
  When rov.form_name='Speech Intervention for Patient 3yrs and older' THEN 4
  When rov.form_name='ENT Assessment' THEN 3
  When rov.form_name='ENT Nasopharyngeal Endoscopic Assessment' THEN 3
  When rov.form_name='ENT Intervention' THEN 3
  When rov.form_name='Dental and Orthodontic Assessment' THEN 2
  When rov.form_name='Dental and Orthodontic Intervention' THEN 2
  When rov.form_name='Social Work Assessment' THEN 6
  When rov.form_name='Social Work Intervention' THEN 6
  When rov.form_name is null THEN 99
 ELSE 99
 END AS YCC_Service_Seq
,count(*) as 'obs_count'
from YCC_view_obs rov
-- where rov.encounter_id = (select max(rov2.encounter_id
group by rov.person_id, rov.encounter_id, rov.visit_date_stopped, rov.encounter_type, rov.form_name
;
-- select * from YCC_view_encounter_form ;-- where encounter_id=25 order by  encounter_type desc, form_name asc;
-- select encounter_type,count(*) from encounter group by encounter_type order by 2 desc, 1;
-- select * from encounter_type;
