WITH mpam_due_cases AS (
    SELECT case_uuid,
           case_reference as "CTSRef",
           date_created as "Case Created Date",
           business_area as "Business Area",
           allocated_to_uuid as "Current Handler User Id",
           case_deadline as "Due Date",
           'WORKFLOW' as "Workflow",
           'DIRECTORATE' as "Directorate",
           'SIGNEE' as "Signee",
           stage as "Stage",
           To_Char(case_deadline, 'fmDay') as "Day"

    FROM {{ ref('merged_cases') }}
    WHERE user_group = 'MPAM' AND NOT completed
)

SELECT * FROM mpam_due_cases