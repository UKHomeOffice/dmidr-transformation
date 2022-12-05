WITH open_cases AS (
    SELECT case_uuid,
           business_area,
           NOW()::date - date_created::date AS age,
           case_deadline,
           stage,
           case_type

    FROM {{ ref('merged_cases') }}

    WHERE stage != 'CASE_CLOSED'
)

SELECT * FROM open_cases