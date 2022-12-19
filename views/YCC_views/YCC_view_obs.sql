create or replace view YCC_view_obs as select 
 obs.obs_id
,obs.person_id
,obs.concept_id
,obs.encounter_id
,obs.obs_datetime
,obs.location_id   as obs_location_id
,obs.obs_group_id
-- ,obs.value_group_id    -- not used?
,obs.value_coded
,(select cn.name from concept_name cn where cn.concept_id=obs.value_coded and cn.locale='en' and cn.concept_name_type='FULLY_SPECIFIED' and cn.voided=0) as value_coded_name
-- ,obs.value_coded_name_id   -- not used?
,obs.value_drug    -- not used?
,obs.value_datetime
,obs.value_numeric
,obs.value_modifier   -- not used?
,obs.value_text
,obs.value_complex
,obs.comments
,obs.date_created as obs_date_created
-- ,obs.voided  as obs_voided           -- YES this is used!!!
,obs.previous_version
,obs.form_namespace_and_path
,substring_index(substring(obs.form_namespace_and_path,8,200),".",1 ) as 'form_name'
,obs.status                       -- FINAL or AMENDED
-- ,obs.interpretation            -- not used?
-- ,c.retired as 'Concept_retired'
,(select cn.name from concept_name cn where cn.concept_id=obs.concept_id and cn.locale='en' and cn.voided=0 and cn.concept_name_type='FULLY_SPECIFIED' and cn.voided=0) 'concept_name'
-- ,c.short_name                 -- not used?
-- ,c.description                   -- not used?
-- ,c.form_text
,c.datatype_id as concept_datatype_id
,(select dt.name from concept_datatype dt where dt.concept_datatype_id = c.datatype_id) 'datatype_name'
,c.class_id as concept_class_id
,c.is_set   as concept_is_set
,e.encounter_datetime
,e.encounter_type
,e.location_id as encounter_location_id
,e.visit_id  as visit_id
,v.visit_type_id as visit_type_id
,v.date_started  as visit_date_started
,v.date_stopped  as visit_date_stopped
,v.location_id   as visit_location_id
from obs
Left join concept c on c.concept_id = obs.concept_id
Left join encounter e on e.encounter_id = obs.encounter_id
left join visit v on v.visit_id = e.visit_id
where obs.voided = 0
  and c.retired = 0
  and e.voided = 0
;
-- select * from YCC_view_obs o 
-- where o.concept_name in ('Current Education Level' , 'xPatient Case Status')
-- or o.concept_id = 4654 or obs_group_id=4654 ;
-- select o.concept_name,count(*) from YCC_view_obs o group by o.concept_name order by 1;
