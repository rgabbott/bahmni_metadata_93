-- this not needed? returns a set or collection....
create or replace view YCC_view_obs_last_NA_value as -- this not needed? returns a set or collection....
select o.obs_id as ID, o.person_id as Person_id_id, o.concept_name as ConceptName, o.*
from YCC_view_obs o 
where o.concept_datatype_id = 4   -- datatype_name='N/A'
  and o.obs_id = (select max(oo.obs_id) 
                    from YCC_view_obs oo 
				   where oo.person_id=o.person_id 
                     and oo.concept_name=o.concept_name 
                     -- and oo.value_coded_name=o.value_coded_name 
                     and oo.concept_datatype_id = 4)
;
-- order by o.person_id, o.concept_name, o.value_coconcept_datatype_id = 4ded_name;
-- select * from YCC_view_obs_last_NA_value where person_id=70 ;
-- select * from concept_datatype;
