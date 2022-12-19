{% test divide_by_zero_percentage(model, column_name, dependent_on) %}

with dependent_on_zero as ( 
    select *
    from {{ model }}
    where {{ dependent_on }} = 0
)

select *
from dependent_on_zero
where {{ column_name }} > 0

{% endtest %}