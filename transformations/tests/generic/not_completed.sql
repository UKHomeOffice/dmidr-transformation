{% test not_completed(model, column_name, base_table, base_key) %}

select "{{ base_key }}"
from {{ base_table }}
join {{ model }} on "{{ base_key }}" = {{ column_name }}
where completed

{% endtest %}