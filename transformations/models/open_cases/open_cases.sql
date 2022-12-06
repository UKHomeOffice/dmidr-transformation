WITH open_cases AS (
    SELECT case_uuid AS "Case ID",
           business_area AS "Business Area",
           NOW()::date - date_created::date AS "Age",
           case_deadline AS "Deadline",
           stage AS "Stage",
           case_type,
           CASE WHEN case_deadline > NOW() THEN 1 ELSE 0 END AS "Outside service standard"

    FROM {{ ref('merged_cases') }}

    WHERE stage != 'CASE_CLOSED'
)

SELECT * FROM open_cases