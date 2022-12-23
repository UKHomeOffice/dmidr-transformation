import psycopg2
import os


class TestBase:

    def create_db_connection(self):
        return psycopg2.connect(
            host=os.environ.get(f"transformation_db_host"),
            user=os.environ.get(f"transformation_db_username"),
            password=os.environ.get(f"transformation_db_password"),
            database=os.environ.get(f"transformation_db_name"),
            port=int(os.environ.get(f"transformation_db_port"))
        )

    def get_result(self, view):
        aggregate_closed_cases = f'select * from {view}'
        with self.create_db_connection() as connection:

            with connection.cursor() as cursor:

                cursor.execute(aggregate_closed_cases)
                return cursor.fetchone()
