from fastapi import APIRouter, Depends, HTTPException
from  services import select_perspective, select_difference_guide, \
     select_type_image, select_type_object, select_unit_measurement, \
     insert_perspective, insert_difference_guide, insert_type_image, \
     insert_type_object, insert_unit_measurement, update_unit_measurement, \
     update_perspective, update_difference_guide, update_type_image, \
     update_type_object



guide_router = APIRouter(
    prefix="/guide",
    tags=["guide"],
    #dependencies=[Depends("asdsa")],
    responses={404: {"description": "Not found"}},
)

# Получение ракурсов
@guide_router.get("/get_perspective")
async def get_perspective():
    records = select_perspective()
    return records

# Получение отличий
@guide_router.get("/get_difference_guide")
async def get_difference_guide():
    records = select_difference_guide()
    return records

# Получение типов изображений
@guide_router.get("/get_type_image")
async def get_type_image():
    records = select_type_image()
    return records

# Получение типов объектов
@guide_router.get("/get_type_object")
async def get_type_object():
    records = select_type_object()
    return records

# Получение единиц измерения
@guide_router.get("/get_unit_measurement")
async def get_unit_measurement():
    records = select_unit_measurement()
    return records

# Добавление ракурса
@guide_router.post("/add_perspective")
async def add_perspective(name: str, short_name = None):
    records = insert_perspective(params=(name, short_name,))
    return records

# Добавление отличия
@guide_router.post("/add_difference_guide")
async def add_difference_guide(name: str, short_name = None):
    records = insert_difference_guide(params=(name, short_name,))
    return records

# Добавление типа изображения
@guide_router.post("/add_type_image")
async def add_type_image(name: str, short_name = None):
    records = insert_type_image(params=(name, short_name,))
    return records

# Добавление типа объекта
@guide_router.post("/add_type_object")
async def add_type_object(name: str, short_name = None):
    records = insert_type_object(params=(name, short_name,))
    return records

# Добавление единицы измерения
@guide_router.post("/add_unit_measurement")
async def add_unit_measurement(name: str, short_name = None):
    records = insert_unit_measurement(params=(name, short_name,))
    return records

# Обновление ракурса
@guide_router.patch("/upd_perspective")
async def upd_perspective(id: str, name: str, short_name = None):
    print("sdfsddf")
    print(id, name, short_name)
    records = update_perspective(params=(id, name, short_name,))
    return records

# Обновление отличия
@guide_router.patch("/upd_difference_guide")
async def upd_perspective(id: str, name: str, short_name = None):
    records = update_difference_guide(params=(id, name, short_name,))
    return records

# Обновление типа изображения
@guide_router.patch("/upd_type_image")
async def upd_perspective(id: str, name: str, short_name = None):
    records = update_type_image(params=(id, name, short_name,))
    return records

# Обновление типа объекта
@guide_router.patch("/upd_type_object")
async def upd_perspective(id: str, name: str, short_name = None):
    records = update_type_object(params=(id, name, short_name,))
    return records

# Обновление единицы измерения
@guide_router.patch("/upd_unit_measurement")
async def upd_perspective(id: str, name: str, short_name = None):
    records = update_unit_measurement(params=(id, name, short_name,))
    return records