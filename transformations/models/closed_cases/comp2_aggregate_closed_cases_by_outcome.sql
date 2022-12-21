WITH comp2_aggregate_closed_cases_by_outcome AS (
    SELECT COUNT("Case ID") as "Upheld",
    COUNT("Case ID") as "Partially upheld",
    COUNT("Case ID") as "Not upheld"

    FROM {{ ref('closed_cases') }}
    WHERE user_group = 'COMP2'

)

SELECT * FROM comp2_aggregate_closed_cases_by_outcome