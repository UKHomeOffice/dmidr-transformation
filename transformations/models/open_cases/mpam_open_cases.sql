SELECT case_uuid AS "Case ID",
       business_area AS "Business Area",
       age AS "Age",
       case_deadline AS "Deadline",
       stage AS "Stage"

FROM {{ ref('open_cases') }}

WHERE case_type = 'MPAM'