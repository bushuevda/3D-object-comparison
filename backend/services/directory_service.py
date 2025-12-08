from connection_db import ConnectionDB
from psycopg.rows import class_row
from models import Directory, CheckFilesDir, DirAddId
from . utils import recors_to_json


# Выборка каталогов из БД
def select_directory():
    db = ConnectionDB()
    class_r  = class_row(Directory)
    sql = 'SELECT * FROM public."Directory"'
    records = db.exec(sql, class_r)
    return records

# Получение каталогов смоделированных файлов ГО
def select_directory_obj_modeled():
    db = ConnectionDB()
    class_r  = class_row(Directory)
    sql = 'SELECT * FROM public.modeled_files_obj_dir'
    records = db.exec(sql, class_r)
    return records

# Получение каталогов требуемых файлов ГО
def select_directory_obj_required():
    db = ConnectionDB()
    class_r  = class_row(Directory)
    sql = 'SELECT * FROM public.required_files_obj_dir'
    records = db.exec(sql, class_r)
    return records

# Добавление каталога
def insert_directory(params: tuple):
    db = ConnectionDB()
    sql = 'CALL directory_exec.directory_add(%s, %s)'
    db.exec_procedure(sql, params)

# Обновление каталога
def update_directory(params: tuple):
    db = ConnectionDB()
    sql = 'CALL directory_exec.directory_change(%s, %s)'
    db.exec_procedure(sql, params)

# Проверка файлов каталога
def check_files_directory(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(CheckFilesDir)
    sql = f'SELECT * FROM directory_exec.check_files_directory(%s)'
    records = db.exec(sql, class_r, params)
    return records

# Добавление каталога и возвращение его id
def directory_add_ret_id(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(DirAddId)
    sql = f'SELECT * FROM directory_exec.directory_add_ret_id(%s, %s)'
    records = db.exec_func(sql, params)
    return records


# Получение каталогов без изображений-отличий
def select_directoris_without_compare():
    db = ConnectionDB()
    class_r  = class_row(Directory)
    sql = 'SELECT * FROM public.dirs_without_compare;'
    records = db.exec(sql, class_r)
    return records