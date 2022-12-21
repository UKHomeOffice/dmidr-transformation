SELECT Date,
       "Amount Answered On Time",
       "Amount Due"

FROM {{ ref('performance_by_dates')}}

WHERE user_group = 'MPAM'