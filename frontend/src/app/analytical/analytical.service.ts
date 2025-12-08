import { Injectable } from '@angular/core';
import {HttpClient, HttpParams} from "@angular/common/http";
import { enviroment } from '../../enviroments';
import { GeometryObjPath, InfoReport, ViewReportDiffs, ViewReportGObj, ViewReportImgs, ViewResultReport } from './analytical.models';



@Injectable()
export class AnalyticalService {
    constructor(private http: HttpClient){}

    /**Запрос моделей НС */
    getViewResultReport(){
        return this.http.get<ViewResultReport[]>(enviroment.analytical + "/get_view_result_compare_reports");
    }

    /**Запросы отчета по кускам */
    //Получение информации о результате сравнения и модели НС
    getInfOrderCompare(result_id: number){
        return this.http.get<InfoReport[]>(enviroment.analytical + `/get_inf_order_compare?result_id=${result_id}`);
    }

    //Получение информации об изображениях требуемого объекта
    getImgsReqPath(result_id: number){
        return this.http.get<ViewReportImgs[]>(enviroment.analytical + `/get_imgs_req_path?result_id=${result_id}`);
    }

   //Получение информации об изображениях смоделированного объекта
    getImgsModPath(result_id: number){
        return this.http.get<ViewReportImgs[]>(enviroment.analytical + `/get_imgs_mod_path?result_id=${result_id}`);
    }

   //Получение информации об изображениях отличиях
    getImgsDiffPath(result_id: number){
        return this.http.get<ViewReportImgs[]>(enviroment.analytical + `/get_imgs_diff_path?result_id=${result_id}`);
    }

    //Получение информации о смоделированном объекте
    getGobjModeledByResult(result_id: number){
        return this.http.get<ViewReportGObj[]>(enviroment.analytical + `/get_gobj_modeled_by_result?result_id=${result_id}`);
    }


    //Получение информации о смоделированном объекте
    getGobjRequiredByResult(result_id: number){
        return this.http.get<ViewReportGObj[]>(enviroment.analytical + `/get_gobj_required_by_result?result_id=${result_id}`);
    }


    //Получение информации об отличиях сравниваемых объектов
    getDiffsOrderCompare(result_id: number){
        return this.http.get<ViewReportDiffs[]>(enviroment.analytical + `/get_diffs_order_compare?result_id=${result_id}`);
    }

    /**Получение одного файла obj по директории */
    getObjectDirectory(directory_id: number){
        let params = new HttpParams();
        params = params.append('directory_id', directory_id);
        return this.http.get<GeometryObjPath[]>(enviroment.analytical + `/get_object_directory`,  {params: params});

    }


    /**Сравнение трехмерны ГО */
    compareGeomtryObjects(directory_id_mod: number, directory_id_req: number, perceptron_id: number){
        let params = new HttpParams();
        params = params.append('directory_id_mod', directory_id_mod);
        params = params.append('directory_id_req', directory_id_req);
        params = params.append('perceptron_id', perceptron_id);
        return this.http.post<number>(enviroment.analytical + `/compare_geometry_objects`, null, {params: params});
    }
    
};