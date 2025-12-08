from pydantic import BaseModel
from datetime import date

#Модель НС
class ModelNN(BaseModel):
    id: int
    name_file: str
    date_create: date
    directory_id: int
    name_file_history: str
    err_resolve: int

#Модель истории обучения
class ModelHistory(BaseModel):
    optimizer: str
    epochs: int
    accuracy: list[float]
    f1_score: list[list[float, float]]
    loss: list[float]
    precision: list[float] 
    recall: list[float] 

#Модель параметров обчуения
class TrainParameters(BaseModel):
    directory_id: int
    directory_path: str
    epochs: int
    error_resolve: int
    count_neuron: int
    size_data: int
    optimizer: str
    name_model: str


