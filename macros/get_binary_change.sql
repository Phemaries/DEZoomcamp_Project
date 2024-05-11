{# This macro returns 1 - Yes, 0 - No #}

{% macro get_binary_change(cancelled) %}

    case {{ cancelled }}
        when 1 then 'Yes'
        else 'No'
    end

{% endmacro %}

