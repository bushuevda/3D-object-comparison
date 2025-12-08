import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { enviroment } from '../../enviroments';
import { ModelCheckFiles } from './files.models';

@Injectable({providedIn: 'root' })
export class FilesService {
    constructor(private http: HttpClient) {}

    /**Отправка obj файла на сервер */
    sendFileToServerObj(file: File, directory_id: number, directory_path: string, typeObjId: number){
        const formData: FormData = new FormData();
        formData.append('dir_path', directory_path)
        formData.append('file', file, file.name);
        formData.append('dir_id', directory_id.toString());
        formData.append('type_obj_id', typeObjId.toString());
        return this.http.post(enviroment.files + "/upload_file_gobject", formData);
    }

    /**Отправка файла изображения на сервер */
    sendFileToServerImage(file: File, directory_id: number, directory_path: string, type_image_id: number, perspective_id: number){
        const formData: FormData = new FormData();
        formData.append('dir_path', directory_path)
        formData.append('file', file, file.name);
        formData.append('type_image_id', type_image_id.toString());
        formData.append('perspective_id', perspective_id.toString());
        formData.append('dir_id', directory_id.toString());
        return this.http.post(enviroment.files + "/upload_file_image", formData);
    }

    /**Проверка файлов директории */
    checkFilesDirectory(directory_id: number){
        let params = new HttpParams();
        params = params.append('directory_id', directory_id);
        return this.http.get<ModelCheckFiles[]>(enviroment.directory + "/check_directory_files", {params: params});
    }


}