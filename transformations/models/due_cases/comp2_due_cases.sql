WITH mpam_due_cases AS (
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
    FROM {{ ref('due_cases') }} AS c

    WHERE user_group = 'COMP2'
)

SELECT * FROM mpam_due_cases