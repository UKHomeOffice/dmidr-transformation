{% test not_higher_than(model, column_name, max_value_column) %}

with correct_max_value as (    
    select case when {{ column_name }} < "{{ max_value_column }}" then 1 else 0 end as below_max
    from {{ model }}
)

select * 
from correct_max_value
where below_max = 0

{% endtest %}