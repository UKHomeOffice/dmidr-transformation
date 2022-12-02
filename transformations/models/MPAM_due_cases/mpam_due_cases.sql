WITH mpam_due_cases AS (
    SELECT c.case_uuid,
           case_reference as "CTSRef",
           date_created as "Case Created Date",
           business_area as "Business Area",
           allocated_to_uuid as "Current Handler User Id",
           case_deadline as "Due Date",
           'WORKFLOW' as "Workflow",
           'DIRECTORATE' as "Directorate",
           'SIGNEE' as "Signee",
           stage as "Stage",
           To_Char(case_deadline, 'Day') as "Day"

    FROM {{ ref('merged_cases') }} AS c

    WHERE case_type = 'MPAM'
)

SELECT "CTSRef",
       "Case Created Date",
       "Business Area",
       "Current Handler User Id",
       "Due Date",
       "Workflow",
       "Directorate",
       "Signee",
       "Stage",
       "Day"

FROM mpam_due_cases