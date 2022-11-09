import psycopg2
import os


def create_db_connection():
    conn = None
    try:
        print('Connecting to the Audit database...')
        conn = psycopg2.connect(
            host=os.environ.get("replica_db_host"),
            user=os.environ.get("replica_db_username"),
            password=os.environ.get("replica_db_password"),
            database=os.environ.get("replica_db_name"),
            port=int(os.environ.get("replica_db_port")),
            cursorclass=cursors.DictCursor,
        )
        cur = conn.cursor()

        print('Audit database version:')
        cur.execute('SELECT version()')

        db_version = cur.fetchone()
        print(db_version)

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')

    return conn


def get_comp_performance():
    connection = create_db_connection()

    with connection.cursor() as cursor:
        result = select_top_ten(cursor)

    for row in result:
        print(row[0])


def select_top_ten(cursor):

    schema = os.environ.get("replica_db_schema")

    top_ten_sql = f"""
        select *
        from {schema}.audit_event
        fetch first 10 rows only;
    """
    cursor.execute(top_ten_sql)


get_comp_performance()
