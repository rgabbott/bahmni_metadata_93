echo 'starting'

./osql.sh < ./YCC_views/YCC_view_obs.sql

./osql.sh < ./YCC_views/YCC_view_obs_last_Boolean_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Coded_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Complex_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Date_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Datetime_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_NA_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Numeric_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Text_value.sql
./osql.sh < ./YCC_views/YCC_view_obs_last_Time_value.sql
 

./osql.sh < ./YCC_views/YCC_view_visit_attribute.sql

./osql.sh < ./YCC_views/YCC_view_visit.sql

./osql.sh < ./YCC_views/YCC_view_encounter.sql
./osql.sh < ./YCC_views/YCC_view_encounter_form.sql

./osql.sh < ./RPT_views/YCC_view_RPT_Patient_Detail.sql
./osql.sh < ./RPT_views/YCC_view_RPT_Patient_Summary.sql
