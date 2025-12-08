from connection_db import ConnectionDB
from psycopg.rows import class_row
from models import Guide
from . utils import recors_to_json


# Получение ракурсов
def select_perspective():
    db = ConnectionDB()
    class_r  = class_row(Guide)
    sql = 'SELECT * FROM public."Perspective"'
    records = db.exec(sql, class_r)
    return records

# Получение отличий
def select_difference_guide():
    db = ConnectionDB()
    class_r  = class_row(Guide)
    sql = 'SELECT * FROM public."Difference_guide"'
    records = db.exec(sql, class_r)
    return records

# Получение типов изображений
def select_type_image():
    db = ConnectionDB()
    class_r  = class_row(Guide)
    sql = 'SELECT * FROM public."Type_image"'
    records = db.exec(sql, class_r)
    return records

# Получение типов объектов
def select_type_object():
    db = ConnectionDB()
    class_r  = class_row(Guide)
    sql = 'SELECT * FROM public."Type_object"'
    records = db.exec(sql, class_r)
    return records

# Получение единиц измерения
def select_unit_measurement():
    db = ConnectionDB()
    class_r  = class_row(Guide)
    sql = 'SELECT * FROM public."Unit_measurement"'
    records = db.exec(sql, class_r)
    return records

# Добавление ракурса
def insert_perspective(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.perspective_add(%s, %s)'
    db.exec_procedure(sql, params)

# Добавление отличия
def insert_difference_guide(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.difference_guide_add(%s, %s)'
    db.exec_procedure(sql, params)

# Добавление типа изображения
def insert_type_image(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.type_image_add(%s, %s)'
    db.exec_procedure(sql, params)

# Добавление типа объекта
def insert_type_object(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.type_object_add(%s, %s)'
    db.exec_procedure(sql, params)

# Добавление единицы измерения
def insert_unit_measurement(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.unit_measurement_add(%s, %s)'
    db.exec_procedure(sql, params)

# Обновление ракурса
def update_perspective(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.perspective_upd(%s, %s, %s)'
    db.exec_procedure(sql, params)

# Обновление отличия
def update_difference_guide(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.difference_guide_upd(%s, %s, %s)'
    db.exec_procedure(sql, params)

# Обновление типа изображения
def update_type_image(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.type_image_upd(%s, %s, %s)'
    db.exec_procedure(sql, params)

# Обновление типа объекта
def update_type_object(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.type_object_upd(%s, %s, %s)'
    db.exec_procedure(sql, params)

# Обновление единицы измерения
def update_unit_measurement(params: tuple):
    db = ConnectionDB()
    sql = 'CALL guides_exec.unit_measurement_upd(%s, %s, %s)'
    db.exec_procedure(sql, params)