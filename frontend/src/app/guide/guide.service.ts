
import { Injectable } from '@angular/core';
import {UniversalRow, HelpDataTable, TableInfo} from './guide.models'
import {HttpClient, HttpParams} from "@angular/common/http";
import { enviroment } from '../../enviroments';

@Injectable()
export class GuideService{

    constructor(private http: HttpClient){}

    /**Получение данных выбранной таблицы */
    getDataTable(typeTable: HelpDataTable){
        switch(typeTable){
            case HelpDataTable.UnitMeasurement:
                return this.http.get<UniversalRow[]>(enviroment.helpData + "/get_unit_measurement");
            case HelpDataTable.GuideDiferences:
                return this.http.get<UniversalRow[]>(enviroment.helpData + "/get_difference_guide");
            case HelpDataTable.ImageAngle:
                return this.http.get<UniversalRow[]>(enviroment.helpData + "/get_perspective");
            case HelpDataTable.ImageType:
                return this.http.get<UniversalRow[]>(enviroment.helpData + "/get_type_image");
            case HelpDataTable.ObjectType:
                return this.http.get<UniversalRow[]>(enviroment.helpData + "/get_type_object");
        }
    }

    /**Обновление данных выбранной таблицы */
    updateDataTable(typeTable: HelpDataTable, id: number | null, name: string, short_name: string){
        let params = new HttpParams();
        params = params.append('id', String(id));
        params = params.append('name', name);
        params = params.append('short_name', short_name);
        switch(typeTable){
            case HelpDataTable.UnitMeasurement:
                return this.http.patch(enviroment.helpData + "/upd_unit_measurement", null, {params: params});
            case HelpDataTable.GuideDiferences:
                return this.http.patch(enviroment.helpData + "/upd_difference_guide", null, {params: params});
            case HelpDataTable.ImageAngle:
                return this.http.patch(enviroment.helpData + "/upd_perspective", null, {params: params});
            case HelpDataTable.ImageType:
                return this.http.patch(enviroment.helpData + "/upd_type_image", null, {params: params});
            case HelpDataTable.ObjectType:
                return this.http.patch(enviroment.helpData + "/upd_type_object", null, {params: params});
        }
    }

    /**Добавление записи в выбранную таблицу */
    insertDataTable(typeTable: HelpDataTable, name: string, short_name: string){
        let params = new HttpParams();
        params = params.append('name', name);
        params = params.append('short_name', short_name);
        switch(typeTable){
            case HelpDataTable.UnitMeasurement:
                return this.http.post(enviroment.helpData + "/add_unit_measurement", null, {params: params});
            case HelpDataTable.GuideDiferences:
                return this.http.post(enviroment.helpData + "/add_difference_guide", null, {params: params});
            case HelpDataTable.ImageAngle:
                return this.http.post(enviroment.helpData + "/add_perspective", null, {params: params});
            case HelpDataTable.ImageType:
                return this.http.post(enviroment.helpData + "/add_type_image", null, {params: params});
            case HelpDataTable.ObjectType:
                return this.http.post(enviroment.helpData + "/add_type_object", null, {params: params});
        }
    }

    /**Получене значений для выпадающего списка фильтра */
    getOptions(value: string, data: any[]): any[]{
        const setResult = new Set();
        let index = 0;
        let result = [];
        if(data){
            for(let item of data){
                if(item[value]){
                    setResult.add(item[value]);
                }
            }
        }
        for(let item of setResult){
            result.push({'id': index, 'name': item});
            index++;
        }
        return result;
    }

}
