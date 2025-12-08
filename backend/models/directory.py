from pydantic import BaseModel
from typing import Optional

# Модель для каталогов
class Directory(BaseModel):
    #Код каталога
    id: int
    #Имя каталога
    name: str
    #Код каталога-родителя
    parent_id: Optional[int] = None

# Проверка файлов каталога
class CheckFilesDir(BaseModel):
    #Код файла
    id: int
    #Состояние наличия
    exist: bool

# Добавление каталога и возвращение его id
class DirAddId(BaseModel):
    #Код каталога
    id: int