WITH comp2_due_cases_aggregate_data AS (
    SELECT "Total due this week",
           "Total due next 4 weeks",
           "Total out of service standard",
           "Total cases"
           
    
   FROM {{ ref('due_cases_aggregate') }}

   WHERE user_group = 'COMP2'
)

SELECT * FROM comp2_due_cases_aggregate_data