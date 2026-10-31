{% macro refund_rate(refund_amount_col, returned_qty_col, sales_amount_col) %}

(
    SUM({{ refund_amount_col }} * {{ returned_qty_col }})
    /
    NULLIF(SUM({{ sales_amount_col }}), 0)
) * 100

{% endmacro %}