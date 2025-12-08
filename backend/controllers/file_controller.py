from  services import insert_directory, select_directory
from fastapi import APIRouter, Depends, HTTPException, UploadFile, Form
from fastapi.responses import FileResponse
import shutil
from typing import Annotated # Для Python 3.9+
import os
from services import add_inf_gobj, add_inf_img, check_exist_gobj
from constants import HIGH_DIRECTORY, HIGH_DIRECTORY_DIFF_IMG

file_router = APIRouter(
    prefix="/file",
    tags=["file"],
    #dependencies=[Depends("asdsa")],
    responses={404: {"description": "Not found"}},
)


# Загрузка файла obj на сервер
@file_router.post('/upload_file_gobject')
async def upload_file_gobject(file: UploadFile, dir_path: Annotated[str, Form()], dir_id: Annotated[str, Form()], type_obj_id: Annotated[str, Form()]):
    # Расширение файла
    file_extension = os.path.splitext(file.filename)[1]
    # Формирование имени файла
    FILE_OBJ_NAME = f"file_gobj_dir{dir_id}_type_obj{type_obj_id}{file_extension}"
    try:
        # Создание директории если она отсутствует
        if not os.path.isdir(f"{HIGH_DIRECTORY}{dir_path}"):
            os.makedirs(f"{HIGH_DIRECTORY}{dir_path}")
        # Переименование файла и задание пути файла
        file.filename = FILE_OBJ_NAME
        path_file = f"{HIGH_DIRECTORY}{dir_path}/{file.filename}"
        # Сохранение файла на веб-сервере
        with open(path_file, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        # Добавление информации в БД
        add_inf_gobj(params=(FILE_OBJ_NAME, int(dir_id), int(type_obj_id)))
    except Exception as e:
        print(e)
    return {"filename": file.filename}


# Загрузка файла изображения на сервер
@file_router.post('/upload_file_image')
async def upload_file_image(file: UploadFile, dir_path: Annotated[str, Form()], type_image_id: Annotated[str, Form()], 
                             perspective_id: Annotated[str, Form()], dir_id: Annotated[str, Form()]):
    # Расширение файла
    file_extension = os.path.splitext(file.filename)[1]
    # Формирование имени файла
    FILE_IMG_NAME = f"img_dir{dir_id}_persp{perspective_id}_type_img{type_image_id}{file_extension}"

    if not check_exist_gobj(params=(int(dir_id),))[0][0]:
        return {"error": True}

    try:

        # Создание директории если она отсутствует
        if not os.path.isdir(f"{HIGH_DIRECTORY}{dir_path}"):
            os.makedirs(f"{HIGH_DIRECTORY}{dir_path}")
        # Переименование файла и задание пути файла
        file.filename = FILE_IMG_NAME
        path_file = f"{HIGH_DIRECTORY}{dir_path}/{file.filename}"
        # Сохранение файла на веб-сервере
        with open(path_file, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        # Добавление информации в БД
        add_inf_img(params=(FILE_IMG_NAME, int(type_image_id), int(perspective_id), int(dir_id)))
    except Exception as e:
        print(e)
    return {"filename": file.filename}




# Эндпоинт для получения конкретного изображения отличия
@file_router.get("/diff-images", response_class=FileResponse)
async def get_image(path_image: str):
    file_path = HIGH_DIRECTORY_DIFF_IMG + "/" + path_image
    if os.path.exists(file_path):
        # Возвращаем файл напрямую
        return FileResponse(file_path, media_type="image/png")
    return {"error": "Image not found"}


# Эндпоинт для получения конкретного изображения 
@file_router.get("/images", response_class=FileResponse)
async def get_obj(path_image: str):
    file_path = HIGH_DIRECTORY + "/" + path_image
    if os.path.exists(file_path):
        # Возвращаем файл напрямую
        return FileResponse(file_path, media_type="image/png")
    return {"error": "Image not found"}

# Эндпоинт для получения конкретного файла obj
@file_router.get("/gobj", response_class=FileResponse)
async def get_obj(path_gobj: str):
    file_path = HIGH_DIRECTORY + "/" + path_gobj
    if os.path.exists(file_path):
        # Возвращаем файл напрямую
        return FileResponse(file_path, media_type="model/obj")
    return {"error": "Obj not found"}