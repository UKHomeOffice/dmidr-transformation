from pymysql import connect, cursors
import os


def create_db_connection():
    return connect(
        host=os.environ.get("replica_db_host"),
        user=os.environ.get("replica_db_username"),
        password=os.environ.get("replica_db_password"),
        database=os.environ.get("replica_db_name"),
        port=int(os.environ.get("replica_db_port")),
        cursorclass=cursors.DictCursor,
    )


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
