from connection_db import ConnectionDB
from psycopg.rows import class_row
from models import ModelNN


# Получение информации о моделях НС
def select_model_nn():
    db = ConnectionDB()
    class_r  = class_row(ModelNN)
    sql = 'SELECT * FROM public."Model_nn"'
    records = db.exec(sql, class_r)
    return records


# Добавление новой модели нейронной сети
def insert_model_nn(params: tuple):
    db = ConnectionDB()
    sql = 'CALL perceptron_exec.add_modell_nn(%s, %s, %s, %s)'
    db.exec_procedure(sql, params)