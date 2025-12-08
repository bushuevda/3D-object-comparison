import configparser
import psycopg
from psycopg.rows import dict_row

class ConnectionDB:
    def __init__(self):
        config = configparser.ConfigParser()
        config.read('config.ini')

        self.db_name = config['database']['dbname']
        self.db_user = config['database']['user']
        self.db_password = config['database']['password']
        self.db_host = config['database']['host']
        self.db_port = config['database']['port']


    def exec(self, sql, class_row, params = None):
        conn = psycopg.connect(
            dbname = self.db_name,
            user = self.db_user, 
            password = self.db_password,
            host = self.db_host,
            port = self.db_port
        )
        cursor = conn.cursor(row_factory=class_row)
        cursor.execute(sql, params)
        records = cursor.fetchall()
        cursor.close()
        conn.close()
        return records
    

    def exec_func(self, sql, params = None):
        conn = psycopg.connect(
            dbname = self.db_name,
            user = self.db_user, 
            password = self.db_password,
            host = self.db_host,
            port = self.db_port
        )
        cursor = conn.cursor(row_factory=dict_row)
        cursor.execute(sql, params)
        
        records = cursor.fetchall()
        conn.commit()
        cursor.close()
        conn.close()
        return records

    def exec_procedure(self, sql, params = None):
        conn = psycopg.connect(
            dbname = self.db_name,
            user = self.db_user, 
            password = self.db_password,
            host = self.db_host,
            port = self.db_port
        )
        cursor = conn.cursor()
        cursor.execute(sql, params)
        conn.commit()
        cursor.close()
        conn.close()
