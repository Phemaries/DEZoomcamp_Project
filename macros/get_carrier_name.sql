{# This macro returns the description of the carrier_name #}

{% macro get_carrier_name(carrier) %}

    case {{ carrier }}
        when 'AA' then 'American Airlines'
        when 'AS' then 'Alaska Airlines'
        when 'B6' then 'JetBlue'
        when 'DL' then 'Delta Air Lines'
        when 'F9' then 'Frontier Airlines'
        when 'G4' then 'Allegiant Air'
        when 'HA' then 'Hawaiian Airlines'
        when 'NK' then 'Spirit Airlines'
        when 'UA' then 'United Airlines'
        when 'WN' then 'Southwest Airlines'
        else 'No Carrier'
    end

{% endmacro %}

