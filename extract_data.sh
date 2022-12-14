#!/bin/bash

set -euo pipefail

echo "Starting extract of data"

PGPASSWORD=${transformation_db_password} psql -h${transformation_db_host} -p${transformation_db_port} -d${transformation_db_name} -U${transformation_db_username} << EOF

CREATE schema IF NOT EXISTS transformation;

DROP TABLE IF EXISTS transformation.audit_event;

CREATE TABLE IF NOT EXISTS transformation.audit_event
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
    CONSTRAINT audit_event_uuid_idempotent UNIQUE (uuid, audit_timestamp, type));

EOF