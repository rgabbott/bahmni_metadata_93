-- 
create or replace view YCC_view_visit as
select 
  v.visit_id                                 -- visit table --------------------------------------
, v.patient_id
, v.visit_type_id
,(select vt.name from visit_type vt where vt.visit_type_id = v.visit_type_id) as visit_type_name
,(select va.value_reference from YCC_view_visit_attribute va where va.visit_id =v.visit_id and va.attribute_type_id=1) as visit_status
,(select va.value_reference from YCC_view_visit_attribute va where va.visit_id =v.visit_id and va.attribute_type_id=2) as admission_status
, v.date_started  as v_date_started
, v.date_stopped  as v_date_stopped
, if(v.date_stopped is null, 'Open', 'Closed') as visit_progress
, v.indication_concept_id
, v.location_id
,(select l.name from location l where l.location_id = v.location_id) as visit_location_name
-- , v.creator
, v.date_created as visit_date_created
-- , v.changed_by
-- , v.date_changed
-- , v.voided  as visit_voided
-- , v.voided_by
-- , v.date_voided
-- , v.void_reason
-- , v.uuid
from visit v
where v.voided = 0
;
-- select * from YCC_view_visit;
