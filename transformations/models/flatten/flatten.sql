WITH CASES AS (
    SELECT case_uuid,
           audit_payload::json ->> 'type',
           TO_DATE(LEFT(audit_payload::json ->> 'created', 9), 'YYYY-MM-DD'),
           TO_DATE(audit_payload::json ->> 'dateReceived', 'YYYY-MM-DD'),
           TO_DATE(audit_payload::json ->> 'caseDeadline', 'YYYY-MM-DD'),
           audit_payload::json ->> 'reference',
           audit_payload::json -> 'data' ->> 'bus_area',
           audit_payload::json -> 'data' ->> 'allocatedToUUID'
    FROM replica.audit_event;
)

SELECT * FROM CASES;