-- Create view for due cases
WITH mpam_due_cases AS (
   SELECT case_reference as CTSRef,
       date_created as "Case created date",
       business_area as "Business area",
       allocated_to_uuid as "current handler user id",
       case_deadline as "due date"

    FROM {{ref('flatten')}}

    WHERE case_type = 'MIN'
)

SELECT * FROM mpam_due_cases