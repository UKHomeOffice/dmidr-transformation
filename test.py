from pymysql import connect, cursors


def create_db_connection():
    # need to check how to get the environment variables here can't actually remember
    return connect(
        host=os.environ.get("DB_HOST"),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASS"),
        database=os.environ.get("DB_NAME"),
        cursorclass=cursors.DictCursor,
    )

def get_comp_performance():
    connection = create_db_connection()

    with connection.cursor() as cursor:
        result = select_top_ten(cursor)
        
    for row in result:
        print(row[0])

def select_top_ten(cursor):
    top_ten_sql = f"""
        select *
        from audit_event
        fetch first 10 rows only;
    """
    cursor.execute(top_ten_sql)
