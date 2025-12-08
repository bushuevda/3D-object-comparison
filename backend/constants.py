import configparser

config = configparser.ConfigParser()
config.read('config.ini')

WEB_SERVER_PORT = int(config['web_server']['port'])
WEB_SERVER_HOST = config['web_server']['host']
URL_HOST = "http://" + config['web_server']['host'] + ":" + config['web_server']['port'] + "/"



# Каталог где хранятся все каталоги с файлами (считается что у него нет каталога-родителя)
HIGH_DIRECTORY = "directories"
# Каталог где хранятся все каталоги результаты сравнения изображений (считается что у него нет каталога-родителя)
HIGH_DIRECTORY_DIFF_IMG = "directories_diff_images"

#perspective_id в таблице Perspective в БД
#Вид спереди
PERSPECTIVE_FORWARD = 1
#Вид сзади
PERSPECTIVE_BACK = 2
#Вид слева
PERSPECTIVE_LEFT = 3
#Вид справа
PERSPECTIVE_RIGHT = 4
#Вид сверху
PERSPECTIVE_UP = 5
#Вид снизу
PERSPECTIVE_DOWN = 6

#type image id
#Фактическое
TYPE_IMG_REAL = 1
#Разница
TYPE_IMG_DIFFERENCE = 2


#type obj id
#Смоделированный
TYPE_OBJ_MODELED = 1
#Требуемый
TYPE_OBJ_REQUIRED = 2
#Необработанный
TYPE_OBJ_RAW = 3
#Соответствующий
TYPE_OBJ_CORRECT = 4
#Несоответствующий
TYPE_OBJ_INCORRECT = 5


#Название результата сравнения изображений
#Вид спереди
RES_DIF_IMG_FORWARD = "diff_forward.png"
#Вид сзади
RES_DIF_IMG_BACK = "diff_back.png"
#Вид слева
RES_DIF_IMG_LEFT = "diff_left.png"
#Вид справа
RES_DIF_IMG_RIGHT = "diff_right.png"
#Вид сверху
RES_DIF_IMG_UP = "diff_up.png"
#Вид снизу
RES_DIF_IMG_DOWN = "diff_down.png"

#Часть названия каталога для результат сравнения
DIR_DIFFERENCE_IMAGE = "compare"
