WITH mpam_due_cases_aggregate_data AS (
    SELECT "Total due this week",
           "Total due next 4 weeks",
           "Total out of service standard",
           "Total cases"
    FROM (
        SELECT CASE WHEN case_deadline BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '7 day' THEN 1 ELSE 0 END as "Due this week",
               CASE WHEN case_deadline BETWEEN date_trunc('week', NOW()::timestamp) AND date_trunc('week', NOW()::timestamp) + interval '28 day' THEN 1 ELSE 0 END as "Due in next 4 weeks",
               CASE WHEN case_deadline < NOW() THEN 1 ELSE 0 END as "Out of service standard"

        FROM {{ ref('merged_cases') }}
        WHERE user_group = 'MPAM' AND NOT completed
       ) as case_flags
)

SELECT * FROM mpam_due_cases_aggregate_data