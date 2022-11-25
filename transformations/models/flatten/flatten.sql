CREATE SCHEMA IF NOT EXISTS transformation;

-- Create table for case table
CREATE TABLE IF NOT EXISTS transformation.case_table (
    case_uuid VARCHAR(50),
    case_type VARCHAR(500),
    date_created DATE,
    date_received DATE,
    case_deadline DATE,
    case_reference VARCHAR(100),
    business_area VARCHAR(100),
    allocated_to_uuid VARCHAR(100)
                                      );

-- get data from json blob in case table
INSERT INTO transformation.case_table (
                        case_uuid,
                        case_type,
                        date_created,
                        date_received,
                        case_deadline,
                        case_reference,
                        business_area,
                        allocated_to_uuid
                        )
    SELECT case_uuid,
           audit_payload::json->>'type',
           TO_DATE(LEFT(audit_payload::json->>'created', 9), 'YYYY-MM-DD'),
           TO_DATE(audit_payload::json->>'dateReceived', 'YYYY-MM-DD'),
           TO_DATE(audit_payload::json->>'caseDeadline', 'YYYY-MM-DD'),
           audit_payload::json->>'reference',
           audit_payload::json->'data'->>'bus_area',
           audit_payload::json->'data'->>'allocatedToUUID'
    from replica.audit_event;
