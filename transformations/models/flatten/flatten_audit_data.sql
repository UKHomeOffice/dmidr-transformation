{{
  config(
    materialized = "table"
  )
}}

WITH cases AS (
    SELECT case_uuid,
           type as audit_type,
           audit_payload::json ->> 'type' AS user_group,
           TO_DATE(LEFT(audit_payload::json ->> 'created', 9), 'YYYY-MM-DD') AS date_created,
           TO_DATE(audit_payload::json ->> 'dateReceived', 'YYYY-MM-DD') AS date_received,
           TO_DATE(audit_payload::json ->> 'caseDeadline', 'YYYY-MM-DD') AS case_deadline,
           audit_payload::json ->> 'reference' AS case_reference,
           audit_payload::json -> 'data' ->> 'bus_area' AS business_area,
           audit_payload::json -> 'data' ->> 'allocatedToUUID' AS allocated_to_uuid,
           audit_timestamp AS audit_timestamp,
           audit_payload::json ->> 'stage' AS stage
    FROM {{ source('audit_data', 'audit_event') }}
)

SELECT * FROM cases