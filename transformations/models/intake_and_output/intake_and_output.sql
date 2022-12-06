WITH intake_and_output AS (
    SELECT case_uuid AS "Case ID",
           business_area AS "Business Area",
           date_created AS "Date Created",
           date_received AS "Date Recieved",
           completed AS "Closed",
           date_completed AS "Date Closed",
           responded AS "Responded",
           date_responded AS "Date Responded",
           To_Char(case_deadline, 'fmDay') AS "Day",
           case_type

    FROM {{ ref('merged_cases') }}
)

SELECT * FROM intake_and_output