from pydantic import BaseModel
from typing import Optional

# Модель справочника
class Guide(BaseModel):
    id: int
    name: str
    short_name: Optional[str] = None


