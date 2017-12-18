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

-- count of dimension metric by day - 
select :metric_name, d.name dimension, concat(dt.month, "/", dt.day, "/", dt.year) as date, count(f.value) count
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

-- unique submitters by day - report
select concat(dt.year, "-", dt.month, "-", dt.day), count(distinct u.user_id) user_cnt
from indexing_facts f
  join metric_types mt on f.metric_type_id = mt.metric_type_id
  join dates dt on f.date_id = dt.date_id
  join dimension_types d on f.principal_type_id = d.dimension_type_id
  join users u on f.principal_id = u.user_id
where mt.name = 'wf.batch.submit.indexing'
  and d.name = 'user'
group by dt.year, dt.month, dt.day
order by dt.year asc, dt.month asc, dt.day asc;

select date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day), count(1)  
from dates d
  join indexing_facts on d.date_id = indexing_facts.date_id
  join metric_types ON metric_types.metric_type_id = indexing_facts.metric_type_id
  join dimension_types ON dimension_types.dimension_type_id = indexing_facts.dimension_type_id
  join users ON users.user_id = indexing_facts.principal_id
where metric_types.name = 'wf.batch.submit.indexing'
  and dimension_types.name = 'user'
group by date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day)
order by date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day) asc;

select date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day), count(1)  
from dates d
  join indexing_facts on d.date_id = indexing_facts.date_id
  join metric_types ON metric_types.metric_type_id = indexing_facts.metric_type_id
  join dimension_types ON dimension_types.dimension_type_id = indexing_facts.dimension_type_id
  join users ON users.user_id = indexing_facts.principal_id
where metric_types.name = 'user.authenticate'
  and dimension_types.name = 'user'
group by date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day)
order by date_add(date_add(makedate(d.year,1), interval (d.month)-1 month), interval (d.day)-1 day) asc;

-- unique authentications by day - report
select concat(dt.year, "-", dt.month, "-", dt.day), count(1) user_cnt
from indexing_facts f
  join metric_types mt on f.metric_type_id = mt.metric_type_id
  join dates dt on f.date_id = dt.date_id
  join dimension_types d on f.principal_type_id = d.dimension_type_id
  join users u on f.principal_id = u.user_id
where mt.name = 'user.authenticate'
  and d.name = 'user'
group by dt.year, dt.month, dt.day
order by dt.year asc, dt.month asc, dt.day asc;

