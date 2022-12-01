-- Getting the most recent value for each column of a case type to bring together into a
-- single column. Otherwise we run into duplicated data in our reports.

WITH cases AS (
    SELECT DISTINCT case_uuid

    FROM {{ ref('flatten_audit_data') }}
),
ranked_case_type AS(
    SELECT *

    FROM (
             SELECT case_uuid,
                    case_type,
                    RANK() OVER (PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM {{ ref('flatten_audit_data') }}

             WHERE case_type is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_date_created AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    date_created,
                    RANK() OVER (PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM {{ ref('flatten_audit_data') }}

             WHERE date_created is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_date_received AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    date_received,
                    RANK() OVER (PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM {{ ref('flatten_audit_data') }}

             WHERE date_received is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_case_deadline AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    case_deadline,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

            FROM  {{ ref('flatten_audit_data') }}

            WHERE case_deadline is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_case_reference AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    case_reference,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

            FROM  {{ ref('flatten_audit_data') }}

            WHERE case_reference is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_business_area AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    business_area,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

            FROM  {{ ref('flatten_audit_data') }}

            WHERE business_area is not null
         )  AS ranked

    WHERE rank = 1
),
ranked_allocated_to_uuid AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    allocated_to_uuid,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

            FROM  {{ ref('flatten_audit_data') }}

            WHERE allocated_to_uuid is not null
         ) AS ranked

    WHERE rank = 1
),
ranked_stage AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    stage,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM  {{ ref('flatten_audit_data') }}

             WHERE stage is not null
         ) AS ranked

    WHERE rank = 1
)

SELECT cases.case_uuid,
       case_type,
       date_created,
       date_received,
       case_deadline,
       case_reference,
       business_area,
       allocated_to_uuid,
       stage

FROM cases

LEFT JOIN
ranked_case_type
ON
cases.case_uuid = ranked_case_type.case_uuid

LEFT JOIN
ranked_allocated_to_uuid
ON
cases.case_uuid = ranked_allocated_to_uuid.case_uuid

LEFT JOIN
ranked_business_area
ON
cases.case_uuid = ranked_business_area.case_uuid

LEFT JOIN
ranked_case_deadline
ON
cases.case_uuid = ranked_case_deadline.case_uuid

LEFT JOIN
ranked_case_reference
ON
cases.case_uuid = ranked_case_reference.case_uuid

LEFT JOIN
ranked_date_created
ON
cases.case_uuid = ranked_date_created.case_uuid

LEFT JOIN
ranked_date_received
ON
cases.case_uuid = ranked_date_received.case_uuid

LEFT JOIN
ranked_stage
ON
cases.case_uuid = ranked_stage.case_uuid