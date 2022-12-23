do $$

declare 
mpam_case_uuid_1 uuid := uuid_generate_v1();
mpam_case_raising_service_1 varchar := 'hocs-casework-1234567890-1234a';
mpam_user_id_1 uuid := uuid_generate_v1();

mpam_case_uuid_2 uuid := uuid_generate_v1();
mpam_case_raising_service_2 varchar := 'hocs-casework-1234567890-1234b';
mpam_user_id_2 uuid := uuid_generate_v1();

mpam_case_uuid_3 uuid := uuid_generate_v1();
mpam_case_raising_service_3 varchar := 'hocs-casework-1234567890-1234c';
mpam_user_id_3 uuid := uuid_generate_v1();

today date := now();
a_week_ago date := today - interval '7 day';
yesterday date := today - interval '1 day'; 
tomorrow date := today + interval '1 day';


begin

-- Closed Cases Inside of Service Standard

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), mpam_case_uuid_1, uuid_generate_v1(), '1', mpam_case_raising_service_1,
    ('{
        "type": "MPAM",
        "uuid": "' || mpam_case_uuid_1 || '",
        "created": "' || a_week_ago || '",
        "reference": "MPAM/0222222/22",
        "caseDeadline": "' || yesterday || '",
        "dateReceived": "' || a_week_ago || '",
        "primaryTopic": "None",
        "primaryCorrespondent": "' || uuid_generate_v1() || '",
        "fullname": "Mr Doe MP",
        "allocatedToUUID": "' || uuid_generate_v1() || '"
        }')::json,
    'cs-dev', NOW() + interval '1 second', 'CASE_COMPLETED', uuid_generate_v1(), 'a1', FALSE
);

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), mpam_case_uuid_2, uuid_generate_v1(), '1', mpam_case_raising_service_2,
    ('{
        "type": "MPAM",
        "uuid": "' || mpam_case_uuid_2 || '",
        "created": "' || a_week_ago || '",
        "reference": "MPAM/0222222/22",
        "caseDeadline": "' || yesterday || '",
        "dateReceived": "' || a_week_ago || '",
        "primaryTopic": "None",
        "primaryCorrespondent": "' || uuid_generate_v1() || '",
        "fullname": "Mr Doe MP",
        "allocatedToUUID": "' || uuid_generate_v1() || '"
        }')::json,
    'cs-dev', NOW() + interval '1 second', 'CASE_COMPLETED', uuid_generate_v1(), 'a1', FALSE
);

-- Closed Cases Outside of Service Standard

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), mpam_case_uuid_3, uuid_generate_v1(), '1', mpam_case_raising_service_3,
    ('{
        "type": "MPAM",
        "uuid": "' || mpam_case_uuid_3 || '",
        "created": "' || a_week_ago || '",
        "reference": "MPAM/0222222/22",
        "caseDeadline": "' || tomorrow || '",
        "dateReceived": "' || a_week_ago || '",
        "primaryTopic": "None",
        "primaryCorrespondent": "' || uuid_generate_v1() || '",
        "fullname": "Mr Doe MP",
        "allocatedToUUID": "' || uuid_generate_v1() || '"
        }')::json,
    'cs-dev', NOW() + interval '1 second', 'CASE_COMPLETED', uuid_generate_v1(), 'a1', FALSE
);

end $$;