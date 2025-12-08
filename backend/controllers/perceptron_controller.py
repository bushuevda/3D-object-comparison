from fastapi import APIRouter
from services import insert_model_nn, select_model_nn
from models import TrainParameters
from . controllers_util import *
from datetime import datetime


perceptron_router = APIRouter(
    prefix="/perceptron",
    tags=["perceptron"],
    responses={404: {"description": "Not found"}},
)


# Получение моделей персептрона
@perceptron_router.get("/get_perceptron")
async def get_perceptron():
    records = select_model_nn()
    return records


# Обучение персептрона
@perceptron_router.post("/train_perceptron")
async def train_perceptron(parameters: TrainParameters):
    print(parameters)
    model = ModelFabric()
    now_data_time = str(datetime.now().strftime("_%Y_%m_%d_%H_%M_%S"))
    NAME_MODEL = parameters.name_model + now_data_time + ".keras"
    NAME_HISTORY = parameters.name_model + now_data_time + "_history.pkl"
    print(parameters)
    try:
        history = model(count_hidden_neuron = parameters.count_neuron, optimizer = parameters.optimizer, epochs = parameters.epochs,
              size_data = parameters.size_data, name_model = NAME_MODEL, name_history = NAME_HISTORY, 
              error_resolve = parameters.error_resolve, dir_path = parameters.directory_path)
        records = insert_model_nn(params=(NAME_MODEL, parameters.directory_id, NAME_HISTORY, parameters.error_resolve,))


        return prepare_history(history)
    except Exception as e:
        print(e)

# Подготовка истории обучения
def prepare_history(history):
    #Приведение f1 к требуемому виду
    list_f1 = list()
    for par in history['f1_score']:
        res = (float(par[0]) + float(par[1])) / 2
        print(res)
        list_f1.append(res)
    history['f1_score'] = list_f1

    #Нахождение среднего арифметического

    avg_precision = sum(history['precision']) / len(history['precision'])

    avg_recall = sum(history['recall']) / len(history['recall'])

    avg_f1 = sum(history['f1_score']) / len(history['f1_score'])

    avg_b_accuracy = sum(history['balanced_accuracy']) / len(history['balanced_accuracy'])

    dict_history = dict()
    dict_history['precision'] = avg_precision
    dict_history['recall'] = avg_recall
    dict_history['f1_score'] = avg_f1
    dict_history['balanced_accuracy'] = avg_b_accuracy
    return dict_history