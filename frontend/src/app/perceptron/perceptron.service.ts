import { Injectable } from '@angular/core';
import {HttpClient, HttpParams} from "@angular/common/http";
import { enviroment } from '../../enviroments';
import { ModelNN, TrainParameters } from './perceptron.models';


@Injectable()
export class PerceptronService {

    constructor(private http: HttpClient){}

    /**Запрос обучения модели НС*/
    trainModelNN(params: TrainParameters){
        return this.http.post(enviroment.perceptron + "/train_perceptron", params);
    }

    /**Запрос моделей НС */
    getModelNN(){
        return this.http.get<ModelNN[]>(enviroment.perceptron + "/get_perceptron");
    }

};