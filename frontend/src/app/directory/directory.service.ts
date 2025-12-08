import { Injectable } from '@angular/core';
import {HttpClient, HttpParams} from "@angular/common/http";
import { enviroment } from '../../enviroments';
import { TreeNode } from 'primeng/api';
import { DirectoryDB } from './directory.models';

@Injectable()
export class DirectoryService {


    constructor(private http: HttpClient){}

    /**Запрос получения директорий */
    getDataDirectories(){
        return this.http.get<DirectoryDB[]>(enviroment.directory + "/get_directory");
    }

    /**Получение каталогов без изображений-отличий */
    getDataDirectoriesWithoutCompare(){
        return this.http.get<DirectoryDB[]>(enviroment.directory + "/get_directories_without_compare");
    }

    /**Запрос получения директорий */
    getDataDirectoriesById(type_obj_id: number){
        let params = new HttpParams();
        params = params.append('type_obj_id', String(type_obj_id));

        return this.http.get<DirectoryDB[]>(enviroment.directory + `/get_directory_by_type`,  {params: params});
    }


    /**Запрос добавления директории без родителя (верхний уровень) */
    addDirectoryNoneParent(name: string){
        let params = new HttpParams();
        params = params.append('name', name);
        return this.http.post(enviroment.directory + "/add_directory", null, {params: params});
    }

    /**Запрос добавления директории с родителем */
    addDirectoryWithParent(name: string, parent_id: number){
        let params = new HttpParams();
        params = params.append('name', name);
        params = params.append('parent_id', parent_id);
        return this.http.post(enviroment.directory + "/add_directory", null, {params: params});
    }


    /**Запрос обновления директории */
    updateDirectory(id: number, name: string){
        let params = new HttpParams();
        params = params.append('id', id);
        params = params.append('name', name);
        return this.http.post(enviroment.directory + "/upd_directory", null, {params: params});
    }

    /** Рекрусивная функция формирования массива дирректорий пути */
    formedArrayPathNode(node: TreeNode, path: string[] = []): string[]{
        if(node.parent != null){
        this.formedArrayPathNode(node.parent, path);
        }
        path.push(String(node.label));
        return path;
    }

    /** Функция преобразования массива директорий пути в строку */
    formedStringPathNode(path: string[]): string{
        let pathStr: string = "";
        path.forEach((val) => {
        pathStr += `/${val}`;
        })
        return pathStr;
    }

   /**Список в дерево */
   listToTree(list: any[]) {
    const map = new Map();
    const tree: any[] = [];

    // 1. Создаем хеш-таблицу (Map) и инициализируем пустой массив children для каждого элемента
    list.forEach(item => {
        // Создаем копию объекта, чтобы не мутировать исходный массив, и добавляем поле children
        map.set(item.id, { key: item.id.toString(), label: item.name, icon: 'pi pi-folder', children: [] }); 
    });

    // 2. Проходим по списку еще раз и связываем дочерние элементы с родительскими
    list.forEach(item => {
        const mappedItem = map.get(item.id);
        // Если у элемента есть родитель, находим его в map и добавляем текущий элемент в его children
        if (item.parent_id !== null) {
            const parent = map.get(item.parent_id);
            if (parent) {
                parent.children.push(mappedItem);
            }
        } else {
            // Если родителя нет (parent_id === null), значит, это корневой элемент
            tree.push(mappedItem);
        }
    });

    return tree;
  }

};