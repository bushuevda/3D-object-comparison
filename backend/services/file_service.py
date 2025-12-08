from connection_db import ConnectionDB


# Функция добавления информации о файле геометрического объекта (.obj)
def add_inf_gobj(params: tuple):
    db = ConnectionDB()
    sql = 'CALL files_exec.add_file_gobject(%s, %s, %s)'
    db.exec_procedure(sql, params)

# Функция добавления информации об изображении геометрического объекта
def add_inf_img(params: tuple):
    db = ConnectionDB()
    sql = 'CALL files_exec.add_file_image(%s, %s, %s, %s)'
    db.exec_procedure(sql, params)

# Функция проверки наличия файла (.obj) в директории
def check_exist_gobj(params: tuple):
    db = ConnectionDB()
    sql = 'SELECT files_exec.check_exist_gobj(%s)'
    records = db.exec(sql, None, params)
    return records