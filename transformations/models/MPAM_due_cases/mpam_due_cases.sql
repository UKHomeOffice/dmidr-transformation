WITH case_latest_stage AS (
    SELECT *

    FROM (
        SELECT case_uuid,
               stage,
               RANK() OVER (PARTITION BY case_uuid ORDER BY audit_timestamp) AS RANKING

        FROM {{ ref('flattenV2') }}

        WHERE stage IS NOT NULL
         ) AS stage_ranking
),
mpam_due_cases AS (
    SELECT c.case_uuid,
           case_reference as CTSRef,
           date_created as "Case Created Date",
           business_area as "Business Area",
           allocated_to_uuid as "Current Handler User Id",
           case_deadline as "Due Date",
           'WORKFLOW' as "Workflow",
           'DIRECTORATE' as "Directorate",
           'SIGNEE' as "Signee",
           cs.stage as Stage

    FROM {{ ref('flattenV2') }} AS c

    LEFT OUTER JOIN
    case_latest_stage AS cs
    ON
    c.case_uuid = cs.case_uuid

    WHERE case_type = 'MPAM'
)

SELECT CTSRef,
       "Case Created Date",
       "Business Area",
       "Current Handler User Id",
       "Due Date",
       "Workflow",
       "Directorate",
       "Signee",
       Stage

FROM mpam_due_cases