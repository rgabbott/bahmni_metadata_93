-- select * from visit;
create or replace view YCC_view_visit_attribute as
select 
  va.visit_attribute_id
, va.visit_id
, va.attribute_type_id
,(select vat.name from visit_attribute_type vat where vat.visit_attribute_type_id = va.attribute_type_id) as visit_attribute_type_name
, va.value_reference
-- , va.uuid
-- , va.creator
-- , va.date_created as va_date_created
-- , va.changed_by
-- , va.date_changed
-- , va.voided as va_voided
-- , va.voided_by
-- , va.date_voided
-- , va.void_reason
-- , v.visit_id                                 -- visit table --------------------------------------
,'|' as vv
, v.patient_id
, v.visit_type_id
,(select vt.name from visit_type vt where vt.visit_type_id = v.visit_type_id) as visit_type_name
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
from visit_attribute va
left join visit v on va.visit_id = v.visit_id
where v.voided = 0
  and va.voided = 0
;
-- select * from RGA_Visit_Attribute;
