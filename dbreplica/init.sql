CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS replica;

CREATE TABLE IF NOT EXISTS replica.audit_event
(
    id                     BIGSERIAL,
    uuid                   UUID        NOT NULL,
    case_uuid              UUID,
    stage_uuid             UUID,
    correlation_id         TEXT        NOT NULL,
    raising_service        TEXT        NOT NULL,
    audit_payload          JSONB,
    namespace              TEXT        NOT NULL,
    audit_timestamp        TIMESTAMP   NOT NULL,
    type                   TEXT        NOT NULL,
    user_id                TEXT        NOT NULL,
    case_type              text,
    deleted                BOOLEAN    NOT NULL DEFAULT FALSE,

    PRIMARY KEY (uuid, audit_timestamp, type),
    CONSTRAINT audit_event_uuid_idempotent UNIQUE (uuid, audit_timestamp, type)
    );

INSERT INTO replica.audit_event(
    id, 
    uuid, 
    case_uuid, 
    stage_uuid, 
    correlation_id, 
    raising_service, 
    audit_payload, 
    namespace, 
    audit_timestamp, 
    type, 
    user_id, 
    case_type, 
    deleted)
VALUES(
    1, 
    uuid_generate_v1(), 
    uuid_generate_v1(), 
    uuid_generate_v1(), 
    '1', 
    'hocs-casework-794d5dbd56-5tw6s', 
    '{ 
        "audit_payload": 
        {
            "COMP": {
                "CompType": "MIN",
                "DateReceived": "2019-09-11",
                "Directorate": "UKVI",
                "DateResponded": "2019-10-11",
                "ComplainantHORef": "MIN/0120009/21",
                "BusArea": "UKVI",
                "CatStage3": "Triage-unallocated",
                "CatCCHandle": "Karen"
            }

        }
    }',
    'cs-dev', 
    NOW(), 
    'CASE_CREATED', 
    '593c6e02-ece0-499a-b967-404a20dac380', 
    'a1', 
    FALSE
);