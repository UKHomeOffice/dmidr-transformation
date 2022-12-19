-- Getting the most recent value for each column of a case type to bring together into a
-- single column. Otherwise we run into duplicated data in our reports.

WITH cases AS (
    SELECT DISTINCT case_uuid

    FROM {{ ref('flatten_audit_data') }}
),
ranked_user_group AS(
    SELECT *

    FROM (
             SELECT case_uuid,
                    user_group,
                    RANK() OVER (PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM {{ ref('flatten_audit_data') }}

             WHERE user_group IS NOT NULL
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

             WHERE date_created IS NOT NULL
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

             WHERE date_received IS NOT NULL
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

            WHERE case_deadline IS NOT NULL
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

            WHERE case_reference IS NOT NULL
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

            WHERE business_area IS NOT NULL
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

            WHERE allocated_to_uuid IS NOT NULL
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

             WHERE stage IS NOT NULL
         ) AS ranked

    WHERE rank = 1
),
ranked_owning_csu AS (
    SELECT *

    FROM (
             SELECT case_uuid,
                    owning_csu§,
                    RANK() OVER(PARTITION BY case_uuid ORDER BY audit_timestamp DESC) as rank

             FROM  {{ ref('flatten_audit_data') }}

             WHERE owning_csu IS NOT NULL
         ) AS ranked

    WHERE rank = 1
),
completed_case_details AS (
    SELECT case_uuid,
           True as completed,
           audit_timestamp::date AS date_completed

    FROM {{ ref('flatten_audit_data') }}

    WHERE audit_type = 'CASE_COMPLETED'
),
-- This is temporary. We don't currently know how to
-- determined whether a case has been responded to.
case_response_details AS (
    SELECT case_uuid,
           True as responded,
           audit_timestamp::date AS date_responded

    FROM {{ ref('flatten_audit_data') }}

    WHERE audit_type = 'CASE_RESPONDED'
)

SELECT cases.case_uuid,
       user_group,
       date_created,
       date_received,
       case_deadline,
       case_reference,
       business_area,
       allocated_to_uuid,
       COALESCE(responded, False) as responded,
       date_responded,
       COALESCE(completed, False) AS completed,
       date_completed,
       stage

FROM cases

LEFT JOIN
ranked_user_group
ON
cases.case_uuid = ranked_user_group.case_uuid

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

LEFT JOIN
completed_case_details
ON
cases.case_uuid = completed_case_details.case_uuid

LEFT JOIN
case_response_details
ON
cases.case_uuid = case_response_details.case_uuid