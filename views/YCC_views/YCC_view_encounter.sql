create or replace view YCC_view_encounter as
select 
  e.encounter_id
, e.encounter_type
, (select et.name from encounter_type et where e.encounter_type = et.encounter_type_id) as encounter_type_name
, e.patient_id   as encounter_patient_id
,(select pi.identifier from patient_identifier pi where pi.patient_id = e.patient_id and pi.identifier_type=3) as encounter_patient_identifier 
, e.location_id  as encounter_location_id
, (select l.name from location l where l.location_id = e.location_id) as encounter_location_name
-- , e.form_id
, e.encounter_datetime
-- , e.voided   as encounter_voided
, e.visit_id
, v.patient_id     as visit_patient_id
, v.visit_type_id
,(select vt.name from visit_type vt where vt.visit_type_id = v.visit_type_id) as visit_type_name 
, v.date_started as visit_date_started
, v.date_stopped as visit_date_stopped
, round(timestampdiff(minute,v.date_started,v.date_stopped)/60,0) as visit_duration_hours
,if(v.date_stopped is null,'Open','Closed') as visit_status
-- , v.indication_concept_id
, v.location_id  as visit_location_id
,(select l.name from location l where l.location_id = v.location_id) as visit_location_name
-- , v.voided
from encounter e
left join visit v on e.visit_id = v.visit_id
where e.voided = 0 and v.voided = 0
;
-- select * from YCC_view_encounter ;
