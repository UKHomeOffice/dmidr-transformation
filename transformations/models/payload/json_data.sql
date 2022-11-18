CREATE TABLE IF NOT EXISTS case_table (case_type VARCHAR(500), case_deadline DATE, case_uuid VARCHAR(500));
INSERT INTO case_table (case_type, case_deadline, case_uuid)
SELECT audit_payload::json->'audit_payload'->>'type', 
TO_DATE(audit_payload::json->'audit_payload'->>'caseDeadline', 'YYYY-MM-DD'),
audit_payload::json->'audit_payload'->>'uuid' from transformation.audit_event;
