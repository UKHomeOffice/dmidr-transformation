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

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), uuid_generate_v1(), uuid_generate_v1(), '1', 'hocs-casework-79433dbd56-5tw22', 
    '{ 
        "data": 
        {
            "valid": "true", 
            "DateReceived": "2022-11-28", 
            "CopyNumberTen": "TRUE", 
            "Correspondents": "30bea4ea-3c10-46da-9c3f-cf972a7c32b5", 
            "OriginalChannel": "EMAIL", 
            "DateOfCorrespondence": "2022-11-28"
        },
        "BusinessArea": "UKVI",
        "type": "MPAM", 
        "uuid": "22bc767d-700c-40da-9565-017f4a24b0a1", 
        "created": "2022-11-28T12:37:28.752136", 
        "reference": "MPAM/0222222/22", 
        "caseDeadline": "2022-11-29", 
        "dateReceived": "2022-11-27", 
        "primaryTopic": "None", 
        "primaryCorrespondent": "22bea4ea-3c10-46da-9c3f-cf972a7c32b5",
        "fullname": "Mrs Smith MP",
        "allocatedToUUID": "2202b26b-06ed-4247-a1b3-699167f2dbcd"
        }',
    'cs-dev', NOW(), 'CASE_CREATED', '593c6e02-ece0-499a-b967-404a20dac380', 'a1', FALSE
);

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(2, '036f8240-70c0-11ed-873f-0242ac120001', '036f8240-70c0-11ed-873f-0242ac120001', '036f8240-70c0-11ed-873f-0242ac120001', '1', 'hocs-casework-79433dbd56-5tw22', 
    '{ 
        "data": 
        {
            "valid": "true", 
            "DateReceived": "2022-11-28", 
            "CopyNumberTen": "TRUE", 
            "Correspondents": "30bea4ea-3c10-46da-9c3f-cf972a7c32b5", 
            "OriginalChannel": "EMAIL", 
            "DateOfCorrespondence": "2022-11-28"
        },
        "BusinessArea": "IE",
        "type": "MPAM", 
        "uuid": "22bc767d-700c-40da-9565-017f4a24b0a1", 
        "created": "2022-11-28T12:37:28.752136", 
        "reference": "MPAM/0222222/22", 
        "caseDeadline": "2022-11-29", 
        "dateReceived": "2022-11-27", 
        "primaryTopic": "None", 
        "primaryCorrespondent": "22bea4ea-3c10-46da-9c3f-cf972a7c32b5",
        "fullname": "Mrs Smith MP",
        "allocatedToUUID": "2202b26b-06ed-4247-a1b3-699167f2dbcd"
        }',
    'cs-dev', NOW(), 'CASE_CLOSED', '593c6e02-ece0-499a-b967-404a20dac380', 'a1', FALSE
);