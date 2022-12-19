WITH comp2_aggregate_closed_cases_by_outcome AS (
    SELECT COUNT("Case ID") as "Total cases closed"

    FROM {{ ref('closed_cases') }}
    WHERE user_group = 'COMP2'

)

SELECT * FROM comp2_aggregate_closed_cases_by_outcome