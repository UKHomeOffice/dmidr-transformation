WITH comp2_due_cases_aggregate_data AS (
    SELECT SUM("Due this week") as "Total due this week",
           SUM("Due in next 4 weeks") as "Total due next 4 weeks",
           SUM("Out of service standard") as "Total out of service standard",
           COUNT(*) as "Total cases"

    FROM (
        SELECT CASE WHEN case_deadline BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '7 day' THEN 1 ELSE 0 END as "Due this week",
               CASE WHEN case_deadline BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '28 day' THEN 1 ELSE 0 END as "Due in next 4 weeks",
               CASE WHEN case_deadline < NOW() THEN 1 ELSE 0 END as "Out of service standard"
               
        FROM {{ ref('merged_cases') }}
        WHERE user_group = 'COMP2' AND NOT completed

    ) as case_flags

)

SELECT * FROM comp2_due_cases_aggregate_data