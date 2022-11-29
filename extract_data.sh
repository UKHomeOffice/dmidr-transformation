#!/bin/bash

set -euo pipefail

echo "Starting extract of data"

PGPASSWORD=${transformation_db_password} psql -h${transformation_db_host} -p${transformation_db_port} -d${transformation_db_name} -U${transformation_db_username} << EOF

CREATE EXTENSION IF NOT EXISTS postgres_fdw;
DROP SERVER IF EXISTS import_replica_server CASCADE;
CREATE SERVER IF NOT EXISTS import_replica_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host '${replica_db_host}', port '${replica_db_port}', dbname '${replica_db_name}');
CREATE USER MAPPING FOR user SERVER import_replica_server OPTIONS (user '${replica_db_username}', password '${replica_db_password}');
CREATE schema IF NOT EXISTS transformation;
CREATE FOREIGN TABLE transformation.audit_event(
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
    deleted                BOOLEAN    NOT NULL DEFAULT FALSE) 
SERVER import_replica_server OPTIONS (batch_size '100', schema_name '${replica_db_schema}', table_name 'audit_event')
EOF