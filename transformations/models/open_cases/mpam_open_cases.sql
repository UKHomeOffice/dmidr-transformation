SELECT "Case ID",
       "Business Area",
       "Age",
       "Deadline",
       "Stage",
       "Outside service standard"

FROM {{ ref('open_cases') }}

WHERE case_type = 'MPAM'