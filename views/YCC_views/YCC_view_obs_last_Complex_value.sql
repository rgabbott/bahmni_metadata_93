create or replace view YCC_view_obs_last_complex_value as
select o.obs_id,o.person_id, o.concept_name, o.value_complex
from YCC_view_obs o 
where o.concept_datatype_id = 13  -- datatype_name='Complex'
  and o.obs_id = (select max(oo.obs_id) 
                    from YCC_view_obs oo 
				   where oo.person_id=o.person_id 
                     and oo.concept_name=o.concept_name 
                     -- and oo.value_coded_name=o.value_coded_name 
                     and oo.concept_datatype_id = 13)
order by o.person_id, o.concept_name, o.value_coded_name;

-- select * from YCC_obs_last_Complex_value ; -- where person_id=70 ;
-- select * from concept_datatype;
