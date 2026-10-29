{% test generic_non_negative(model,column_name) %}

Select * from {{ model }}
where {{ column_name }} < 0

{% endtest %}