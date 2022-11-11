CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS audit_event
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

INSERT INTO audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), uuid_generate_v1(), uuid_generate_v1(), '1', '', null, NOW(), '', '', '', FALSE)

