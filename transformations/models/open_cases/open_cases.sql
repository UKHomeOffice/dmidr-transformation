WITH open_cases AS (
    SELECT case_uuid AS "Case ID",
           business_area AS "Business Area",
           NOW()::date - date_created::date AS "Age",
           case_deadline AS "Deadline",
           stage AS "Stage",
           user_group,
           CASE WHEN case_deadline < NOW() THEN 1 ELSE 0 END AS "Outside Service Standard"

    FROM {{ ref('merged_cases') }}

    WHERE NOT completed
)

SELECT * FROM open_cases