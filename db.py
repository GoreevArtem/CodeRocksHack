import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


def QUERY_GET(connection, query, param = False):
    try:
        with connection.cursor() as cursor:
            cursor.execute(query)
            records = cursor.fetchone() if param == False else cursor.fetchall()
            return records
    except (Exception, Error) as error:
        print("[ERROR] PostgreSQL", error)



def QUERY(connection, query):
    try:
        with connection.cursor() as cursor:
            cursor.execute(query)
            connection.commit()
    except (Exception, Error) as error:
        print("[ERROR] PostgreSQL", error)
