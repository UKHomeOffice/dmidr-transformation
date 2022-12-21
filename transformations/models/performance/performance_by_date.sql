WITH answered_on_time_by_date AS (
    SELECT date_responded,
           user_group,
           COUNT(date_responded) AS "Amount Answered On Time"

    FROM {{ ref('merged_cases') }}

    WHERE date_responded < case_deadline

    GROUP BY date_responded, user_group
),
due_by_date AS (
    SELECT case_deadline::date as deadline,
           user_group,
           COUNT(case_deadline) AS "Amount Due"

    FROM {{ ref('merged_cases') }}

    GROUP BY deadline, user_group
),
date_dimension AS (
    SELECT generate_series(date_trunc('week', NOW()::timestamp), date_trunc('week', NOW()::timestamp) + interval '7 day', '1 day'::interval)::date as Date
)


SELECT Date,
       t1.user_group,
       COALESCE("Amount Answered On Time", 0) AS "Amount Answered On Time",
       COALESCE("Amount Due", 0) AS "Amount Due"

FROM due_by_date t1

FULL JOIN
answered_on_time_by_date t2
ON
t1.deadline = t2.date_responded
AND
t1.user_group = t2.user_group

RIGHT OUTER JOIN
date_dimension t3
ON
t1.deadline = t3.Date
OR
t2.date_responded = t3.Date