-- Create table for case table
CREATE TABLE IF NOT EXISTS case_table (case_type VARCHAR(500), case_responded VARCHAR(500), case_deadline DATE, case_uuid VARCHAR(500));

-- get data from json blob in case table

INSERT INTO case_table (case_type, case_responded, case_deadline, case_uuid)
SELECT audit_payload::json->'audit_payload'->>'type',
TO_DATE(audit_payload::json->'audit_payload'->>'FOI'->>'dateOfResponse', 'YYYY-MM-DD'),
TO_DATE(audit_payload::json->'audit_payload'->>'caseDeadline', 'YYYY-MM-DD'),
case_uuid from transformation.audit_event;

-- Total Cases Due
-- Count CASE_DATA where deadline within Last Working Week for distinct caseUuid
-- SELECT DISTINCT case_uuid, case_type COUNT(case_uuid) FROM case_table WHERE case_deadline BETWEEN NOW() - interval '7 days' and case_deadline GROUP BY case_uuid, case_type;

-- -- Answered
-- -- Count CASE_DATA where DateResponded within Last Working Week for Distinct caseUuid
-- SELECT DISTINCT case_uuid, Count(case_uuid) FROM case_table WHERE case_responded BETWEEN case_deadline - interval '7 days' and case_deadline GROUP BY case_uuid;

-- -- Answered On Time
-- -- Count CASE_DATA where DateResponded before deadline for distinct caseUuid
-- SELECT DISTINCT case_uuid, Count(case_uuid) FROM case_table WHERE case_responded > case_deadline GROUP BY case_uuid;

-- Create table for due cases
CREATE TABLE IF NOT EXISTS due_cases_table (Workflow VARCHAR(500), Directorate VARCHAR(500), case_created_by VARCHAR(500), date_on_CTS DATE, current_handler_name VARCHAR(500), due_date DATE);
INSERT INTO due_cases_table (Directorate, case_created_by, date_on_CTS, current_handler_name, due_date)
SELECT audit_payload::json->'audit_payload'->'COMP'->>'Directorate',
audit_payload::json->'audit_payload'->>'created',
TO_DATE(audit_payload::json->'audit_payload'->>'dateReceived', 'YYYY-MM-DD'),
audit_payload::json->'audit_payload'->>'fullname',
TO_DATE(audit_payload::json->'audit_payload'->>'caseDeadline', 'YYYY-MM-DD') from transformation.audit_event;

