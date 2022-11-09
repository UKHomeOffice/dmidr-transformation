import psycopg2
import os


TRANSFORMATION_DATABASE = "transformation"
REPLICA_DATABASE = "replica"


def create_db_connection(database):
    return psycopg2.connect(
        host=os.environ.get(f"{database}_db_host"),
        user=os.environ.get(f"{database}_db_username"),
        password=os.environ.get(f"{database}_db_password"),
        database=os.environ.get(f"{database}_db_name"),
        port=int(os.environ.get(f"{database}_db_port"))
    )


def get_comp_performance():
    try:
        with create_db_connection(REPLICA_DATABASE) as connection:
            with connection.cursor() as cursor:
                select_top_ten(cursor)

                for row in cursor.fetchall():
                    print(row[0])

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)


def select_top_ten(cursor):
    schema = os.environ.get("replica_db_schema")

    top_ten_sql = f"""
        select *
        from {schema}.audit_event
        fetch first 10 rows only;
    """
    cursor.execute(top_ten_sql)


get_comp_performance()
