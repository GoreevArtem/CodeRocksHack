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


if __name__ == "__main__":
    try:
        connection = psycopg2.connect("postgres://icwsptef:gInfaMD89g87DZbN7gUGPpROyg7UQvCD@ziggy.db.elephantsql.com/icwsptef")
        connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

        
        print(QUERY_GET(connection=connection, query = 'SELECT * FROM public."Company"'))
        print(QUERY_GET(connection=connection, query = """SELECT * FROM public."Employee" WHERE full_name = 'werw rwer'""", param = True))

        QUERY(connection=connection, query="""INSERT INTO public."Employee" VALUES (1, 'Galaxy S9', 'Samsung', '4', '63000')""")

        QUERY(connection=connection, query="""UPDATE public."Employee" SET id = id + 3000;""")
        QUERY(connection=connection, query="""DELETE FROM public."Employee" WHERE full_name='Samsung';""")


    except (Exception, Error) as error:
        print("[ERROR] PostgreSQL", error)
    finally:
        if connection:
            connection.close()