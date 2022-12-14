import psycopg2
import os

TRANSFORM_DATABASE = "transformation"
TRANSFORMATION_SCHEMA = "transformation"
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


def extract_data():
    try:
        with create_db_connection(REPLICA_DATABASE) as replica_connection, create_db_connection(TRANSFORM_DATABASE) as transform_connection:
            with replica_connection.cursor(name='replica_fetch_large_result') as replica_cursor:
                replica_cursor.execute(f'select * from {REPLICA_SCHEMA}.audit_event')

                while True:
                    records = replica_cursor.fetchmany(size=10)

                    if not records:
                        break

                    for r in records:
                        print(r)

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

extract_data()