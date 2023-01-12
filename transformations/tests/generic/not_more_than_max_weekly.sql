{% test not_more_than_max_weekly(model, column_name, base_table, base_date_field) %}

with base_table_count as (
    select count("{{ base_date_field }}") as max_weekly_count
    from {{ base_table }}
    where "{{ base_date_field }}" between date_trunc('week', now()::timestamp) and date_trunc('week', now()::timestamp) + interval '7 day'
)

select {{ column_name }}
from {{ model }}
where {{ column_name }} > (select max_weekly_count from base_table_count limit 1)
and {{ column_name }} != 0

{% endtest %}
