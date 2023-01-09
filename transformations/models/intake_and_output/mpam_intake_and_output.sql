SELECT Date,
       business_area,
       "Total completed",
       "Total responded",
       "Total received",
       "Total created"

FROM {{ ref('intake_and_output_by_dates') }}

WHERE user_group = 'MPAM'