from  services import insert_directory, select_directory, update_directory,\
      check_files_directory, select_directory_obj_required, select_directory_obj_modeled,\
      select_directoris_without_compare
from fastapi import APIRouter
from constants import TYPE_OBJ_MODELED, TYPE_OBJ_REQUIRED

directory_router = APIRouter(
    prefix="/directory",
    tags=["directory"],
    responses={404: {"description": "Not found"}},
)


# Получение записей таблиц
@directory_router.get("/get_directory")
async def get_directory():
    records = select_directory()
    return records

# Получение записей таблиц
@directory_router.get("/get_directory_by_type")
async def get_directory_by_type(type_obj_id: int):
    records = list()
    if type_obj_id == TYPE_OBJ_MODELED:
        records = select_directory_obj_modeled()
    elif type_obj_id == TYPE_OBJ_REQUIRED:
        records = select_directory_obj_required()
    return records

# Получение каталогов без изображений-отличий
@directory_router.get("/get_directories_without_compare")
async def get_directories_without_compare():
    records = list()
    records = select_directoris_without_compare()
    return records


# Добавление записи в таблицу
@directory_router.post("/add_directory")
async def add_directory(name: str, parent_id = None):
    records = insert_directory(params=(name, parent_id,))
    return records


# Обновлене записи в таблице
@directory_router.post("/upd_directory")
async def upd_directory(id: int, name: str):
    records = update_directory(params=(id, name,))
    return records


# Получения списка наличия файлов в директории
@directory_router.get("/check_directory_files")
async def check_files_dir(directory_id: int):
    records = check_files_directory(params=(directory_id,))
    return records
