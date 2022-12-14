WITH mpam_performance AS (
    SELECT SUM("Due this week") as "Due",
           0 as "Awaiting QA",
           SUM("Answered") as "Answered",
           SUM("Answered on time") as "Completed in time",
           (SUM("Answered on time") / SUM("Answered")) * 100 as "Performance",
           SUM("Unanswered") as "Unanswered",
           SUM("Due this week") * 0.95 AS "Required to achieve 95% target",
           (SUM("Due this week") * 0.95) - SUM("Answered") as "Outstanding required to achieve 95% target",
           0 as "Age profile" 

    FROM (
        SELECT CASE WHEN case_deadline BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '7 day' THEN 1 ELSE 0 END as "Due this week",
               CASE WHEN date_responded BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '7 day' AND completed THEN 1 ELSE 0 END as "Answered",
               CASE WHEN date_responded BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '7 day' AND date_completed < case_deadline THEN 1 ELSE 0 END as "Answered on time",
               CASE WHEN date_responded IS NULL THEN 1 ELSE 0 END as "Unanswered"

        FROM {{ ref('merged_cases') }}
        WHERE user_group = 'MPAM'
       ) as case_flags
)

SELECT * FROM mpam_performance