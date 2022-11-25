-- Create view for due cases
WITH mpam_due_cases AS (
   SELECT case_reference as CTSRef,
       date_created as "Case Created Date",
       business_area as "Business Area",
       allocated_to_uuid as "Current Handler User Id",
       case_deadline as "Due Date"

    FROM {{ref('flatten')}}

    WHERE case_type = 'MPAM'
)

SELECT * FROM mpam_due_cases