WITH comp_performance AS (
       SELECT "Due",
       "Awaiting QA",
       "Answered",
       "Completed in time",
       "Performance",
       "Unanswered",
       "Required to achieve 95% target",
       "Outstanding required to achieve 95% target",
       "Age profile"
       FROM {{ ref('performance') }}
       WHERE user_group = 'COMP'
) 

SELECT * FROM comp_performance