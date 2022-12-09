WITH mpam_aggregate_closed_cases_by_age AS (
    SELECT SUM("Case ID") as "Total cases closed",
           "Age" as "Age (days)"
    FROM {{ ref('closed_cases') }}
    WHERE user_group = 'MPAM'
    GROUP BY "Age"
)

SELECT * FROM mpam_aggregate_closed_cases_by_age