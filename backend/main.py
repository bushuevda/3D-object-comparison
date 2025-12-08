from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import uvicorn
from controllers import *
from constants import WEB_SERVER_HOST, WEB_SERVER_PORT, HIGH_DIRECTORY, HIGH_DIRECTORY_DIFF_IMG

app = FastAPI()

# Определяем директорию, где хранятся изображения
# Убедитесь, что у вас есть папка 'static/images' в корне проекта
app.mount(f"/{HIGH_DIRECTORY_DIFF_IMG}", StaticFiles(directory=HIGH_DIRECTORY_DIFF_IMG), name=HIGH_DIRECTORY_DIFF_IMG)
app.mount(f"/{HIGH_DIRECTORY}", StaticFiles(directory=HIGH_DIRECTORY), name=HIGH_DIRECTORY)


origins = [
    "http://localhost:4200",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



app.include_router(guide_router)
app.include_router(directory_router)
app.include_router(file_router)
app.include_router(perceptron_router)
app.include_router(analytical_router)



if __name__ == "__main__":
    uvicorn.run(app, host=WEB_SERVER_HOST, port=WEB_SERVER_PORT)