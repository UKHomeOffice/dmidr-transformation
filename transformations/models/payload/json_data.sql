-- Create table for case table
CREATE TABLE IF NOT EXISTS case_table (case_type VARCHAR(500), case_deadline DATE, case_uuid VARCHAR(500));

-- get data from json blob in case table

INSERT INTO case_table (case_type, case_responded, case_deadline, case_uuid)
SELECT audit_payload::json->'audit_payload'->>'type',
SELECT audit_payload::json->'audit_payload'->>'DateResponded'; 
TO_DATE(audit_payload::json->'audit_payload'->>'caseDeadline', 'YYYY-MM-DD'),
audit_payload::json->'audit_payload'->>'uuid' from transformation.audit_event;

-- Total Cases Due
-- Count CASE_DATA where deadline within Last Working Week for distinct caseUuid
SELECT DISTINCT case_uuid, case_type, COUNT(case_uuid) FROM case_table WHERE case_deadline between '2019-10-08' and '2019-11-10' GROUP BY case_uuid, case_type;

-- Answered
-- Count CASE_DATA where DateResponded within Last Working Week for Distinct caseUuid
SELECT DISTINCT case_uuid, Count(case_uuid) FROM case_table WHERE case_responded BETWEEN case_deadline - interval '7 days' and case_deadline GROUP BY case_uuid;

-- Answered On Time
-- Count CASE_DATA where DateResponded before deadline for distinct caseUuid
SELECT DISTINCT case_uuid, Count(case_uuid) FROM case_table WHERE case_responded > case_deadline GROUP BY case_uuid;