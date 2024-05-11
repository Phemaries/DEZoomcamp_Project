{# This macro returns the month of travel #}

{% macro get_travel_month(month) %}

    case {{ month }}
        when 1 then 'January'
        when 2 then 'February'
        when 3 then 'March'
        when 4 then 'April'
        when 5 then 'May'
        when 6 then 'June'
        else 'No record'
    end

{% endmacro %}

