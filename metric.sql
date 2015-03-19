-- list of metric types
select name from metric_types
order by name;

-- sum of dimension metric by day
select :metric_name, d.name dimension, dt.year, dt.month, dt.day, sum(f.value) sum
from indexing_facts f
  join metric_types mt on f.metric_type_id = mt.metric_type_id
  join dates dt on f.date_id = dt.date_id
  join dimension_types d on f.dimension_type_id = d.dimension_type_id
  join dimension_types pd on f.principal_type_id = pd.dimension_type_id
where mt.name = :metric_name
  and d.name = :dimension_name
  and pd.name = 'user'
group by dt.year, dt.month, dt.day
order by dt.year desc, dt.month desc, dt.day desc;

-- count of dimension metric by day
select :metric_name, d.name dimension, dt.year, dt.month, dt.day, count(f.value) count
from indexing_facts f
  join metric_types mt on f.metric_type_id = mt.metric_type_id
  join dates dt on f.date_id = dt.date_id
  join dimension_types d on f.dimension_type_id = d.dimension_type_id
  join dimension_types pd on f.principal_type_id = pd.dimension_type_id
where mt.name = :metric_name
  and d.name = :dimension_name
  and pd.name = 'user'
group by dt.year, dt.month, dt.day
order by dt.year desc, dt.month desc, dt.day desc;

-- unique submitters by day
select dt.year, dt.month, dt.day, count(distinct u.user_id) user_cnt
from indexing_facts f
  join metric_types mt on f.metric_type_id = mt.metric_type_id
  join dates dt on f.date_id = dt.date_id
  join dimension_types d on f.principal_type_id = d.dimension_type_id
  join users u on f.principal_id = u.user_id
where mt.name = 'wf.batch.submit.indexing'
  and d.name = 'user'
group by dt.year, dt.month, dt.day
order by dt.year desc, dt.month desc, dt.day desc;

