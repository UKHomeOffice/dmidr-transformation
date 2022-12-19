WITH comp2_aggregate_closed_cases AS (
    SELECT COUNT("Case ID") as "Total cases closed",
           SUM("Closed inside") as "Cases closed inside of service standard",
           SUM("Closed outside") as "Cases closed outside of service standard"
    
    FROM (
        SELECT "Case ID",
               CASE WHEN "Outside Service Standard" = 1 THEN 1 ELSE 0 END as "Closed outside",
               CASE WHEN "Outside Service Standard" = 0 THEN 1 ELSE 0 END as "Closed inside"

        FROM {{ ref('closed_cases') }}
        WHERE user_group = 'COMP2'
    ) as closed_cases
)

SELECT * FROM comp2_aggregate_closed_cases