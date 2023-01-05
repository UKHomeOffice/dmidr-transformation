WITH mpam_aggregate_closed_cases_by_outcome AS (
    SELECT COUNT("Case ID") as "Upheld",
    COUNT("Case ID") as "Partially upheld",
    COUNT("Case ID") as "Not upheld",
    "Business Area"

    FROM {{ ref('closed_cases') }}
    WHERE user_group = 'MPAM'

    GROUP BY "Business Area"

)

SELECT * FROM mpam_aggregate_closed_cases_by_outcome