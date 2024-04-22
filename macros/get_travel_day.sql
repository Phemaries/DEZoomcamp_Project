{# This macro returns the day of travel #}

{% macro get_travel_day(day) %}

    case {{ day }}
        when 1 then 'Monday'
        when 2 then 'Tuesday'
        when 3 then 'Wednesday'
        when 4 then 'Thursday'
        when 5 then 'Friday'
        when 6 then 'Saturday'
        when 7 then 'Sunday'
        else 'No Data'
    end

{% endmacro %}

