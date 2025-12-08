from . controllers_util import Model, DifferenceBuilder, PathFilesObject
from fastapi import APIRouter
from  services import get_images_directory, get_object_directory, get_model_nn_directory,\
      add_result_compare, directory_add_ret_id, add_diff_value, change_type_result_compare,\
      add_diff_images, view_diffs_by_result, view_result_compare_with_model_nn, view_imgs_real_req_path_by_result,\
      view_imgs_real_mod_req_path_by_result, view_imgs_diff_path_by_result, view_gobj_required_by_result,\
      view_gobj_modeled_by_result, view_result_compare_reports
from models import ObjDirectory, ImgDirectory, PerceptronDirectory
from constants import HIGH_DIRECTORY, TYPE_OBJ_RAW, TYPE_OBJ_CORRECT, TYPE_OBJ_INCORRECT,\
      DIR_DIFFERENCE_IMAGE, HIGH_DIRECTORY_DIFF_IMG, RES_DIF_IMG_FORWARD, RES_DIF_IMG_BACK,\
          RES_DIF_IMG_LEFT, RES_DIF_IMG_RIGHT, RES_DIF_IMG_UP, RES_DIF_IMG_DOWN
import numpy as np
import os

analytical_router = APIRouter(
    prefix="/analytical",
    tags=["analytical"],
    responses={404: {"description": "Not found"}},
)


#Получение изображений из БД по id каталога
def get_images_path(directory_id: int):
    imgs = list()
    imgs_json  = get_images_directory(params=(directory_id,))
    for val in imgs_json:
        i = ImgDirectory.model_validate_json(val)
        i.path = HIGH_DIRECTORY + "/" + i.path
        imgs.append(i)
    imgs = sorted(imgs, key=lambda img: img.perspective_id)
    imgs_without_perspective = list()
    for img in imgs:
        imgs_without_perspective.append(img.path)
    return imgs_without_perspective

#Получение файла obj из БД по id каталога
def get_obj_path(directory_id: int) -> ObjDirectory:
    objects = get_object_directory(params=(directory_id,))
    obj = objects[0]
    obj.path = HIGH_DIRECTORY + "/" + obj.path
    return obj

#Получение модели персептрона keras из БД по id 
def get_model_perceptron(perceptron_id: int):
    model_nn = get_model_nn_directory(params=(perceptron_id,))
    path = HIGH_DIRECTORY + "/" + model_nn[0].path
    
    model_perceptron = Model()
    load_model= model_perceptron.read_model_from_file(path)
    return load_model

#Добавление и получение id добавленной записи в Result_compare
def get_id_result_compare(required_obj_id: int, modeled_obj_id: int, class_obj: int, perceptron_id: int) -> int:
    result_compare_id = add_result_compare(params=(required_obj_id,  modeled_obj_id, class_obj, perceptron_id))
    return result_compare_id


#Создание каталога для изображений-отличий
def create_dir_for_compare(result_compare_id: int) -> str:
    dir_compare = f"{DIR_DIFFERENCE_IMAGE}{result_compare_id}" 
    path_compare = f"{HIGH_DIRECTORY_DIFF_IMG}/{DIR_DIFFERENCE_IMAGE}{result_compare_id}" 
    # Создание директории если она отсутствует
    if not os.path.isdir(path_compare):
        os.makedirs(path_compare)

    path_compare = path_compare + "/"    
    return path_compare, dir_compare

#Создание директории в БД для изображений-отличий
def add_dir_diff_images(dir_diff_img: str) -> int:
    dir_json = directory_add_ret_id(params=(dir_diff_img, None,))
    dir_id = dir_json[0]['directory_add_ret_id']
    return dir_id


#Получение типа на основе анализа персептроном
def get_type_analyze(result_analyze):
    val1 = result_analyze[0][0]
    val2 = result_analyze[0][1]

    type_compare = TYPE_OBJ_CORRECT if val1 > val2 else TYPE_OBJ_INCORRECT
    return type_compare 


#Добавление результата анализа в БД
def add_diff(diffs: list[int], result_compare_id: int):
    add_diff_value(params=(*diffs, result_compare_id,))

#Изменения типа результата анализа в БД
def change_type_compare(type_result_analyze: int, result_compare_id: int):
    change_type_result_compare(params=(type_result_analyze, result_compare_id,))


def add_diff_imgs(id_dir_diff_img:int, obj_id: int):
    #Порядок важен
    add_diff_images(params=(RES_DIF_IMG_FORWARD, RES_DIF_IMG_BACK, RES_DIF_IMG_LEFT, RES_DIF_IMG_RIGHT, RES_DIF_IMG_UP, RES_DIF_IMG_DOWN, obj_id, id_dir_diff_img,))


# Сравнение геометрических объектов
@analytical_router.post("/compare_geometry_objects")
async def compare_geometry_objects(directory_id_mod: int, directory_id_req: int, perceptron_id: int):
    #Получение путей к файлам смоделированного объекта
    obj1 = get_obj_path(directory_id_mod)
    imgs1 = get_images_path(directory_id_mod)


    #Получение путей к файлам требуемогом объекта
    obj2 = get_obj_path(directory_id_req)
    imgs2 = get_images_path(directory_id_req)

    #Получение модели персепрона
    model_perceptron = get_model_perceptron(perceptron_id)

    #Создание структуры путей к файлам
    #Смоделированный объект
    go1 = PathFilesObject(obj1.path, *imgs1)
    #Требуемый объект
    go2 = PathFilesObject(obj2.path, *imgs2)

    #Создание записи в Result_compare и получение id созданной записи
    result_compare_id = get_id_result_compare(obj1.id,  obj2.id, TYPE_OBJ_RAW, perceptron_id)
    
    #Создание каталога изображений-отличий и получение его пути
    path_dir_diff_img, dir_diff_img = create_dir_for_compare(result_compare_id)
    #Создать дирректорию в БД вернуть id
    id_dir_diff_img = add_dir_diff_images(dir_diff_img)

    #Сравнение характеристик
    diffs = DifferenceBuilder.build_diff(go1, go2, path_dir_diff_img)

    
    #Анализ персептроном и получения типа 
    type_result_analyze = get_type_analyze(model_perceptron.predict(np.array([diffs]))) 

    #Добавление информации в БД после анализа
    #Добавление результатов анализа в БД
    add_diff(diffs, result_compare_id)
    #Изменение класса объекта результата анализа в БД
    change_type_compare(type_result_analyze, result_compare_id)
    #Добавление изображений-отличий в БД
    add_diff_imgs(id_dir_diff_img, obj2.id)



    print(type_result_analyze)
    #Возвращение отчета сравнения
    return result_compare_id



# Получение отличий отчета сравнения
@analytical_router.get("/get_diffs_order_compare")
async def get_diffs_order_compare(result_id: int):
    records = view_diffs_by_result(params=(result_id,))
    return records


# Получение информации об отчете сравнения и модели НС
@analytical_router.get("/get_inf_order_compare")
async def get_inf_order_compare(result_id: int):
    records = view_result_compare_with_model_nn(params=(result_id,))
    return records


# Получение информации о фактич. изображения требуемого ГО
@analytical_router.get("/get_imgs_req_path")
async def get_imgs_req_path(result_id: int):
    records = view_imgs_real_req_path_by_result(params=(result_id,))
    return records


# Получение информации о фактич. изображения смоделир. ГО
@analytical_router.get("/get_imgs_mod_path")
async def get_imgs_mod_path(result_id: int):
    records = view_imgs_real_mod_req_path_by_result(params=(result_id,))
    return records


# Получение информации об изображения-отличиях
@analytical_router.get("/get_imgs_diff_path")
async def get_imgs_diff_path(result_id: int):
    records = view_imgs_diff_path_by_result(params=(result_id,))
    return records

# Получение информации о файлах смоделированного ГО
@analytical_router.get("/get_gobj_modeled_by_result")
async def get_gobj_modeled_by_result(result_id: int):
    records = view_gobj_modeled_by_result(params=(result_id,))
    return records

# Получение информации о файлах требуемого ГО
@analytical_router.get("/get_gobj_required_by_result")
async def get_gobj_required_by_result(result_id: int):
    records = view_gobj_required_by_result(params=(result_id,))
    return records


# Получение информации о файлах требуемого ГО
@analytical_router.get("/get_view_result_compare_reports")
async def get_view_result_compare_reports():
    records = view_result_compare_reports()
    return records


# Получение информации о файлах требуемого ГО
@analytical_router.get("/get_object_directory")
async def get_obj_directory(directory_id: int):
    records = get_object_directory(params=(directory_id,))
    return records