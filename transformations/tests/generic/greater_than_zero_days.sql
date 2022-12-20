{% test greater_than_zero_days(model, column_name) %}

select *
from {{ model }}
where {{ column_name }} < 0

{% endtest %}