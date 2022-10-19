select
    "deadline",
    count(*) as cases_due
from {{ source('decs_raw', 'case_data') }}
where "deadline" is not null and "deadline" != ''
group by "deadline"
order by "deadline"