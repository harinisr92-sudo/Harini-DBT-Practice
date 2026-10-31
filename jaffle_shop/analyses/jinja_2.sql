{%- set apples = ["Fuji", "Gala", "Honeycrisp","Granny Smith","Pink Lady","McIntosh","Golden Delicious","Red Delicious","Cortland","Empire"] -%}

{%- for i in apples -%}
    {% if i!="Granny Smith" %}
        {{ i }}
        {% else %}
        {{ i }} is not my favorite apple!
        {% endif %}
{%- endfor -%}