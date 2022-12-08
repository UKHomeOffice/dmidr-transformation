SELECT "Case ID",
       "Business Area",
       "Date Created",
       "Date Recieved",
       "Closed",
       "Date Closed",
       "Responded",
       "Date Responded",
       "Day"

FROM {{ ref('intake_and_output') }}

WHERE user_group = 'MPAM'