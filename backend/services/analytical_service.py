from connection_db import ConnectionDB
from psycopg.rows import class_row
from models import ImgDirectory, ObjDirectory, PerceptronDirectory, AddingResultCompare,\
      DiffReport, InfoReport, ImgsPathReport, GObjReport, ViewResultReport
from . utils import recors_to_json
from constants import URL_HOST, HIGH_DIRECTORY, HIGH_DIRECTORY_DIFF_IMG
from typing import List

def get_images_directory(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(ImgDirectory)
    sql = f'SELECT * FROM directory_exec.get_images_directory(%s)'
    records = db.exec(sql, class_r, params)
    return recors_to_json(records)


def get_object_directory(params: tuple) -> List[ObjDirectory]:
    db = ConnectionDB()
    class_r  = class_row(ObjDirectory)
    sql = f'SELECT * FROM directory_exec.get_object_directory(%s)'
    records: list[ObjDirectory] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY + "/" + r.path
    return records


def get_model_nn_directory(params: tuple) -> List[PerceptronDirectory]:
    db = ConnectionDB()
    class_r  = class_row(PerceptronDirectory)
    sql = f'SELECT * FROM directory_exec.get_model_nn_directory(%s)'
    records = db.exec(sql, class_r, params)
    return records

def add_result_compare(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(AddingResultCompare)
    sql = f'SELECT * FROM analytical_exec.add_result_compare(%s, %s, %s, %s)'
    records = db.exec_func(sql, params)
    print('rec', records)
    return records[0]['add_result_compare']


def add_diff_value(params: tuple):
    db = ConnectionDB()
    sql = f'CALL analytical_exec.add_diff_value(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
    db.exec_procedure(sql,params)


def change_type_result_compare(params: tuple):
    db = ConnectionDB()
    sql = f'CALL analytical_exec.change_type_result_compare(%s, %s)'
    db.exec_procedure(sql,params)

def add_diff_images(params: tuple):
    db = ConnectionDB()
    sql = f'CALL analytical_exec.add_diff_images(%s, %s, %s, %s, %s, %s, %s, %s)'
    db.exec_procedure(sql,params)


#Представление двенадцати отличий для отчета сравнения
def view_diffs_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(DiffReport)
    sql = f'SELECT d_v_name, d_v_value, d_v_result_id FROM public.diffs_by_result WHERE d_v_result_id = %s'
    records = db.exec(sql, class_r, params)
    return records

#Представление информации о НС для отчета сравнения
def view_result_compare_with_model_nn(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(InfoReport)
    sql = f'SELECT r_c_id, date_compare, name, m_nn_id, name_file, date_create, err_resolve	FROM public.result_compare_with_model_nn WHERE r_c_id = %s'
    records = db.exec(sql, class_r, params)
    return records

#Представление пути к файлам фактических изображений требуемого ГО
def view_imgs_real_req_path_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(ImgsPathReport)
    sql = f'SELECT t_i_name, r_c_id, pers_id, pers_name, path FROM public.imgs_real_req_path_by_result WHERE r_c_id = %s'
    records: list[ImgsPathReport] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY + "/" + r.path
    return records

#Представление пути к файлам фактических изображений смоделированного ГО
def view_imgs_real_mod_req_path_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(ImgsPathReport)
    sql = f'SELECT t_i_name, r_c_id, pers_id, pers_name, path FROM public.imgs_real_mod_path_by_result WHERE r_c_id = %s'
    records: list[ImgsPathReport] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY + "/" + r.path
    return records

#Представление пути к файлам изображений-отличий 
def view_imgs_diff_path_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(ImgsPathReport)
    sql = f'SELECT t_i_name, r_c_id, pers_id, pers_name, path FROM public.imgs_diff_path_by_result WHERE r_c_id = %s'
    records: list[ImgsPathReport] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY_DIFF_IMG + "/" + r.path
    return records

#Представление информации о файлах смоделированного ГО
def view_gobj_modeled_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(GObjReport)
    sql = f'SELECT gobj_id, t_o_name, t_o_id, date_create, go_file, r_c_id, gobj_path FROM public.gobj_modeled_by_result WHERE r_c_id = %s'
    records: list[GObjReport] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY + "/" + r.gobj_path
    return records

#Представление информации о файлах требуемого ГО
def view_gobj_required_by_result(params: tuple):
    db = ConnectionDB()
    class_r  = class_row(GObjReport)
    sql = f'SELECT gobj_id, t_o_name, t_o_id, date_create, go_file, r_c_id, gobj_path FROM public.gobj_required_by_result WHERE r_c_id = %s'
    records: list[GObjReport] = db.exec(sql, class_r, params)
    for r in records:
        r.url = URL_HOST + HIGH_DIRECTORY + "/" + r.gobj_path
    return records

#Представление обо всех отчетах сравнения
def view_result_compare_reports():
    db = ConnectionDB()
    class_r  = class_row(ViewResultReport)
    sql = f'SELECT r_c_id, r_c_date, req_file, mod_file, t_o_name, name_file FROM public.result_compare_report;'
    records = db.exec(sql, class_r)
    return records