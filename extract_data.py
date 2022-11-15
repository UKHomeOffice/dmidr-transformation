import psycopg2
import os
from io import StringIO

TRANSFORM_DATABASE = "transformation"
REPLICA_DATABASE = "replica"
REPLICA_SCHEMA = os.environ.get("replica_db_schema")


def create_db_connection(database):
    return psycopg2.connect(
        host=os.environ.get(f"{database}_db_host"),
        user=os.environ.get(f"{database}_db_username"),
        password=os.environ.get(f"{database}_db_password"),
        database=os.environ.get(f"{database}_db_name"),
        port=int(os.environ.get(f"{database}_db_port"))
    )


def create_extract_table():
    with create_db_connection(TRANSFORM_DATABASE) as transform_connection:
        with transform_connection.cursor() as cursor:
            cursor.execute(f"""CREATE TABLE IF NOT EXISTS audit_event
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
                               PRIMARY KEY(uuid, audit_timestamp, type),
                               CONSTRAINT audit_event_uuid_idempotent UNIQUE(uuid, audit_timestamp, type)
                           ) 
                """)


def extract_data():
    try:
        input = StringIO()
        with create_db_connection(REPLICA_DATABASE) as replica_connection, create_db_connection(TRANSFORM_DATABASE) as transform_connection:
            with replica_connection.cursor() as replica_cursor:
                replica_cursor.copy_expert(
                    f'COPY (select * from {REPLICA_SCHEMA}.audit_event fetch first 10 rows only) TO STDOUT', input)
                with transform_connection.cursor() as transform_cursor:
                    input.seek(0)
                    transform_cursor.copy_expert(
                        'COPY audit_event from STDOUT', input)
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def get_comp_performance():
    try:
        with create_db_connection(REPLICA_DATABASE) as connection:
            with connection.cursor() as cursor:
                select_top_ten(cursor)

                for row in cursor.fetchall():
                    print(row)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def select_top_ten(cursor):
    top_ten_sql = f"""
        select *
        from {REPLICA_SCHEMA}.audit_event
        fetch first 10 rows only;
    """
    cursor.execute(top_ten_sql)


create_extract_table()
extract_data()

get_comp_performance()
