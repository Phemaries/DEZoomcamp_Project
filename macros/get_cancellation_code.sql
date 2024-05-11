{# This macro returns the reasons for cancellation #}

{% macro get_cancellation_code(canc) %}

    case {{ canc }}
        when 'A' then 'Carrier'
        when 'B' then 'Weather'
        when 'C' then 'National Aviation System'
        when 'D' then 'Security' 
        else 'No cancellation'      
    end

{% endmacro %}

