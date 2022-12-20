import psycopg2
import os
import json

TRANSFORM_DATABASE = "transformation"
TRANSFORMATION_SCHEMA = "transformation"
REPLICA_DATABASE = "replica"
REPLICA_SCHEMA = os.environ.get("replica_db_schema")

SELECT_QUERY = f"select * from {REPLICA_SCHEMA}.audit_event WHERE audit_timestamp > NOW() - interval '6 month'"

INSERT_QUERY = f'insert into {TRANSFORMATION_SCHEMA}.audit_event(id,uuid,case_uuid,stage_uuid,correlation_id,' \
               f'raising_service,audit_payload,namespace,audit_timestamp,type,user_id,case_type,deleted) ' \
               f'VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'

AUDIT_PAYLOAD_INDEX = 6

def create_db_connection(database):
    return psycopg2.connect(
        host=os.environ.get(f"{database}_db_host"),
        user=os.environ.get(f"{database}_db_username"),
        password=os.environ.get(f"{database}_db_password"),
        database=os.environ.get(f"{database}_db_name"),
        port=int(os.environ.get(f"{database}_db_port"))
    )


def extract_data():
    try:
        with create_db_connection(REPLICA_DATABASE) as replica_connection, \
                create_db_connection(TRANSFORM_DATABASE) as transform_connection:

            with replica_connection.cursor(name='replica_fetch_large_result') as replica_cursor, \
                    transform_connection.cursor() as transform_cursor:

                replica_cursor.execute(SELECT_QUERY)

                while True:
                    records = replica_cursor.fetchmany(size=10)

                    if not records:
                        break

                    for r in records:
                        # Have to turn it into json object so that it can be inserted into a JSONB.
                        r = list(r)
                        r[AUDIT_PAYLOAD_INDEX] = json.dumps(r[AUDIT_PAYLOAD_INDEX])
                        transform_cursor.execute(INSERT_QUERY, r)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

extract_data()