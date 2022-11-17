-- CREATE TABLE IF NOT EXISTS payload_cols 
-- AS SELECT audit_payload::json->'audit_payload'->>'type' as type_col, 
-- audit_payload::json->'audit_payload'->>'uuid' as uuid_col from transformation.audit_event;


CREATE TABLE IF NOT EXISTS payload_cols (type_col VARCHAR(500), uuid_col VARCHAR(500));
INSERT INTO payload_cols 
SELECT audit_payload::json->'audit_payload'->>'type' as type_col, 
audit_payload::json->'audit_payload'->>'uuid' as uuid_col from transformation.audit_event;
