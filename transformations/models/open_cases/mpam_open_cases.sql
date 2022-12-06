SELECT "Case ID",
       "Business Area",
       "Age",
       "Deadline",
       "Stage",
       "Outside Service Standard"

FROM {{ ref('open_cases') }}

WHERE case_type = 'MPAM'