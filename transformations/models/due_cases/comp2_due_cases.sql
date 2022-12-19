WITH comp2_due_cases AS (
    SELECT c.case_uuid as "Case Reference",
           owning_csu as "Owning CSU",
           business_area as "Business Area",
           'LOCATION' as "Location",
           'NRO' as "NRO",
           'CASE QUEUE NAME' as "Case Queue Name", 
           'UKBA RECIEVED DATE' as "UKBA Recieved Date",
           stage AS "Status",
           allocated_to_uuid as "Current Handler User Id",
           case_deadline as "Due Date",
           date_created as "Case Created Date"

    FROM {{ ref('merged_cases') }} AS c
    WHERE user_group = 'COMP2' AND NOT completed

)

SELECT * FROM comp2_due_cases