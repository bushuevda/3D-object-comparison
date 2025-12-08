/**Ракурсы изображений и файл obj  */
export enum CheckFileNumber{
    forward = 1,
    back,
    left,
    right,    
    up,
    down,
    obj
}

/**Типы изображений*/
export enum TypeImage{
    real = 1,
    diff
}

/**Модель наличия файлов */
export interface ModelCheckFiles{
    id: CheckFileNumber,
    exist: boolean
};

/**Модель типа объекта*/
export interface TypeObject{
    id: number,
    name: string,
    short_name: string
}