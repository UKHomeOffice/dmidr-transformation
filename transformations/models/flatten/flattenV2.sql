{{
    config(
        materialized='incremental',
        unique_key='case_uuid',
        incremental_strategy='merge'
    )
}}


WITH using_clause AS (
    SELECT case_uuid,
           audit_payload::json ->> 'type' AS case_type,
           TO_DATE(LEFT(audit_payload::json ->> 'created', 9), 'YYYY-MM-DD') AS date_created,
           TO_DATE(audit_payload::json ->> 'dateReceived', 'YYYY-MM-DD') AS date_received,
           TO_DATE(audit_payload::json ->> 'caseDeadline', 'YYYY-MM-DD') AS case_deadline,
           audit_payload::json ->> 'reference' AS case_reference,
           audit_payload::json -> 'data' ->> 'bus_area' AS business_area,
           audit_payload::json -> 'data' ->> 'allocatedToUUID' AS allocated_to_uuid,
           audit_timestamp AS audit_timestamp,
           audit_payload::json ->> 'stage' AS stage

    FROM {{ source('audit_data', 'audit_event') }}

        {% if is_incremental() %}

            WHERE audit_timestamp >= (SELECT max(audit_timestamp) from {{ this }})

        {% endif %}
),
updates AS (
    SELECT case_uuid,
           case_type, date_created,
           date_received,
           case_deadline,
           case_reference,
           business_area,
           allocated_to_uuid,
           audit_timestamp,
           stage

    FROM using_clause

    {% if is_incremental() %}

        WHERE case_uuid IN (SELECT case_uuid FROM {{ this }})

    {% endif %}
),
inserts AS (

    SELECT case_uuid,
           case_type, date_created,
           date_received,
           case_deadline,
           case_reference,
           business_area,
           allocated_to_uuid,
           audit_timestamp,
           stage

    FROM using_clause

    WHERE case_uuid NOT IN (SELECT case_uuid FROM updates)
)

SELECT * FROM updates UNION SELECT * FROM inserts