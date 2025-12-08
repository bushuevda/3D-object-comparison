from pydantic import BaseModel
from typing import Optional
from datetime import date

class ResultCompare(BaseModel):
    id: int
    name: str
    parent_id: Optional[int] = None

#Модель obj файла директории
class ObjDirectory(BaseModel):
    path: str
    id: int
    url: str = None

#Модель файла изображения директории
class ImgDirectory(BaseModel):
    path: str
    perspective_id: int

#Путь к модели НС
class PerceptronDirectory(BaseModel):
    path: str


class AddingResultCompare(BaseModel):
    id: int

#Отчет сравнения - отличия
class DiffReport(BaseModel):
    d_v_name: str
    d_v_value: int
    d_v_result_id: int

#Отчет сравнения - результат и модель НС
class InfoReport(BaseModel):
    r_c_id: int
    date_compare: date
    name: str
    m_nn_id: int
    name_file: str
    date_create: date
    err_resolve: int

#Отчет сравнения - изображения требуемого, смоделированного и разницы
class ImgsPathReport(BaseModel):
    t_i_name: str
    r_c_id: int
    pers_id: int
    pers_name: str
    path: str
    url: str = None

# Отчет сравнения - информация о требуемом и смоделированном  ГО
class GObjReport(BaseModel):
    gobj_id: int
    t_o_name: str
    t_o_id: int
    date_create: date
    go_file: str
    r_c_id: int
    gobj_path: str
    url: str = None

#Представление обо всех отчетах сравнения
class ViewResultReport(BaseModel):
    r_c_id: int
    r_c_date: date
    req_file: str
    mod_file: str
    t_o_name: str
    name_file: str