 {% test not_higher_than(model, column_name, max_value_column) %}

select * 
from {{ model }}
where {{ column_name }} > "{{ max_value_column }}"

{% endtest %}