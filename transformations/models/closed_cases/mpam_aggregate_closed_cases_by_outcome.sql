WITH mpam_aggregate_closed_cases_by_outcome AS (
    SELECT SUM("Case ID") as "Total cases closed"

    FROM {{ ref('closed_cases') }}
    WHERE user_group = 'MPAM'

)

SELECT * FROM mpam_aggregate_closed_cases_by_outcome