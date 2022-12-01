INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), '22bc767d-800c-40da-9565-017f4a24b0a1', uuid_generate_v1(), '1', 'hocs-casework-79433dbd56-5tw22',
    '{
        "stage": "DCU_MIN_DATA_INPUT",
        "data":
        {
            "valid": "true",
            "DateReceived": "2022-11-28",
            "Correspondents": "30bea4ea-3c10-46da-9c3f-cf972a7c32b5",
            "DateOfCorrespondence": "2022-11-28"
        },
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
VALUES(1, uuid_generate_v1(), '22bc767d-800c-40da-9565-017f4a24b0a1', uuid_generate_v1(), '1', 'hocs-casework-79433dbd56-5tw22',
    '{
        "stage": "DCU_MIN_MARKUP",
        "data":
        {
            "valid": "true",
            "DateReceived": "2022-11-28",
            "Correspondents": "30bea4ea-3c10-46da-9c3f-cf972a7c32b5",
            "DateOfCorrespondence": "2022-11-28"
        },
        "type": "MPAM",
        "uuid": "22bc767d-700c-40da-9565-017f4a24b0a1",
        "created": "2022-11-28T12:37:28.752136",
        "reference": "MPAM/0111111/11",
        "caseDeadline": "2022-11-29",
        "dateReceived": "2022-11-27",
        "primaryTopic": "None",
        "primaryCorrespondent": "22bea4ea-3c10-46da-9c3f-cf972a7c32b5",
        "fullname": "Mrs Smith MP",
        "allocatedToUUID": "2202b26b-06ed-4247-a1b3-699167f2dbcd"
        }',
    'cs-dev', NOW() + interval '1 day', 'CASE_UPDATED', '593c6e02-ece0-499a-b967-404a20dac380', 'a1', FALSE
);

INSERT INTO replica.audit_event(id, uuid, case_uuid, stage_uuid, correlation_id, raising_service, audit_payload, namespace, audit_timestamp, type, user_id, case_type, deleted)
VALUES(1, uuid_generate_v1(), uuid_generate_v1(), uuid_generate_v1(), '1', 'hocs-casework-79433dbd56-5tw22',
    '{
        "stage": "DCU_MIN_MARKUP",
        "data":
        {
            "valid": "true",
            "DateReceived": "2022-11-28",
            "CopyNumberTen": "TRUE",
            "Correspondents": "30bea4ea-3c10-46da-9c3f-cf972a7c32b5",
            "OriginalChannel": "EMAIL",
            "DateOfCorrespondence": "2022-11-28"
        },
        "type": "MPAM",
        "uuid": "22bc767d-700c-40da-9565-017f4a24b0a1",
        "created": "2022-11-28T12:37:28.752136",
        "reference": "MPAM/0222222/22",
        "caseDeadline": "2022-11-29",
        "dateReceived": "2022-11-27",
        "primaryTopic": "None",
        "primaryCorrespondent": "22bea4ea-3c10-46da-9c3f-cf972a7c32b5",
        "fullname": "Mr Doe MP",
        "allocatedToUUID": "2202b26b-06ed-4247-a1b3-699167f2dbcd"
        }',
    'cs-dev', NOW() + interval '1 second', 'CASE_UPDATED', '593c6e02-ece0-499a-b967-404a20dac380', 'a1', FALSE
);