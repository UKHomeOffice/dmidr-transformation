WITH created_count AS (
    SELECT user_group,
           business_area,
           date_created,
           COUNT(date_created) AS "Total created"

    FROM {{ ref('merged_cases') }}

    WHERE date_created IS NOT NULL

    GROUP BY business_area, date_created
),
received_count AS (
    SELECT user_group,
           business_area,
           date_received,
           COUNT(date_received) AS "Total received"

    FROM {{ ref('merged_cases') }}

    WHERE date_received IS NOT NULL

    GROUP BY business_area, date_received
),
completed_count AS (
    SELECT user_group,
           business_area,
           date_completed,
           COUNT(date_completed) AS "Total completed"

    FROM {{ ref('merged_cases') }}

    WHERE date_completed IS NOT NULL

    GROUP BY business_area, date_completed
),
responded_count AS (
    SELECT user_group,
           business_area,
           date_responded,
           COUNT(date_responded) AS "Total responded"

    FROM {{ ref('merged_cases') }}

    WHERE date_responded IS NOT NULL

    GROUP BY business_area, date_responded
),
grouped_counts AS (
    SELECT crc.date_created AS date,
           crc.business_area,
           crc.user_group,
           "Total created",
           "Total received",
           "Total responded",
           "Total completed"

    FROM created_count crc

    FULL JOIN
    received_count recc
    ON
    crc.user_group = rc.user_group
    AND
    crc.business_area = crc.business_area
    AND
    crc.date_created = rc.date_received

    FULL JOIN
    completed_count coc
    ON
    crc.user_group = coc.user_group
    AND
    crc.business_area = coc.business_area
    AND
    crc.date_created = coc.date_completed

    FULL JOIN
    responded_count resc
    ON
    crc.user_group = resc.user_group
    AND
    crc.business_area = resc.business_area
    AND
    crc.date_created = resc.date_responded
),
date_dimension AS (
    SELECT generate_series(date_trunc('week', NOW()::timestamp), date_trunc('week', NOW()::timestamp) + interval '7 day', '1 day'::interval)::date as Date
)

SELECT * FROM grouped_counts