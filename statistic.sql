
-- Daily project aggregate statistic for a given time period
select MAKEDATE(period.period_year, period.period_value) as date, SUM(project_facts.value) as sum, statistic_types.name as stat  
from project_facts
left join principal_types ON principal_types.principal_type_id = project_facts.principal_type_id
left join aggregate_types ON aggregate_types.aggregate_type_id = project_facts.aggregate_type_id
left join period ON period.period_id = project_facts.period_id
left join period_types ON period_types.period_type_id = period.period_type_id
left join statistic_types ON statistic_types.statistic_type_id = project_facts.statistic_type_id
where statistic_types.name = :statistic
and principal_types.principal_type = 'aggregate'
and period_types.name = 'DAILY'
and period.period_year between YEAR(:startDate) and YEAR(:endDate)
and aggregate_types.name = 'SUM'
and (period.period_value between DAYOFYEAR(:startDate) and DAYOFYEAR(:endDate))
group by period.period_year, period.period_value
order by period.period_year, period.period_value;

-- Unique users contributing per day for a given time period
select MAKEDATE(period.period_year, period.period_value) as date, COUNT(DISTINCT project_facts.principal_id) as users 
from project_facts
left join principal_types ON principal_types.principal_type_id = project_facts.principal_type_id
left join period ON period.period_id = project_facts.period_id
left join period_types ON period_types.period_type_id = period.period_type_id
left join statistic_types ON statistic_types.statistic_type_id = project_facts.statistic_type_id
where statistic_types.name in ('wf.batch.submit.indexing', 'wf.batch.submit.indexing.review', 'wf.record.submit.indexing', 'wf.record.submit.indexing.review')
and principal_types.principal_type = 'user'
and period_types.name = 'DAILY'
and period.period_year between YEAR(:startDate) and YEAR(:endDate)
and (period.period_value between DAYOFYEAR(:startDate) and DAYOFYEAR(:endDate))
group by period.period_year, period.period_value
order by period.period_year, period.period_value;
