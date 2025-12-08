/**Совокупность таблиц отчета */
export interface OrderTableInfo{
    /**Результат сравнения */
    resultCompare?: ResultCompare;
    /**Модель НС */
    modelNeuralNetwork?: ModelNeuralNetwork;
    /**Требуемый ГО */
    geometryObjectRequired?: GeometryObjectFile;
    /**Смоделированный ГО */
    geometryObjectModeled?: GeometryObjectFile;
    /**Значение отличий*/
    compareValues?: CompareValues;
    /**Изображения смоделированного ГО */
    imagesFilesModeled?: ImagesFiles;
    /**Изображения требуемого ГО */
    imagesFilesRequired?: ImagesFiles;
    /**Изображения отличий ГО */
    imagesFilesDiff?: ImagesFiles;
}

/**Результат сравнения */
export interface ResultCompare{
    /**Номер */
    id: number;
    /**Дата сравнения */
    date_compare: string;
    /**Тип объекта*/
    type_object: string;
}

/**Модель НС */
export interface ModelNeuralNetwork{
    /**Номер */
    id: number;
    /**Имя файла */
    name_file: string;
    /**Дата создания*/
    date_create: string;
    /**Допустимое отличие */
    resolve_diff: number;
    /**Единица измерения */
    ed_izm: string;
}

/**Сведения о файлах геометрических объектов*/
export interface GeometryObjectFile{
    /**Номер */
    id: number;
    /**Тип объекта */
    type_object: string;
    /**Дата создания*/
    date_create: string;
    /**Имя файла */
    name_file: string;
}

/**Строка отличия для CompareValues*/
export interface CompareRow{
    /**Значение */
    value: number;
    /**Единица измерения */
    ed_izm: string;
}

/**Значение отличий*/
export interface CompareValues{
    /**Отличие кол-ва вершин*/
    diff_count_vertex: CompareRow;
    /**Отличие кол-ва ребер*/
    diff_count_edge: CompareRow;
    /**Отличие кол-ва граней*/
    diff_count_face: CompareRow;
    /**Отличие карт площадей граней*/
    diff_map_faces: CompareRow;
    /**Отличие карт длин ребер*/
    diff_map_edge: CompareRow;
    /**Отличие карт углов между ребрами*/
    diff_map_angle: CompareRow;
    /**Отличие вида спереди*/
    diff_forward: CompareRow;
    /**Отличие вида сзади*/
    diff_back: CompareRow;
    /**Отличие вида слева*/
    diff_left: CompareRow;
    /**Отличие вида справа*/
    diff_right: CompareRow;
    /**Отличие вида снизу*/
    diff_bottom: CompareRow;
    /**Отличие вида сверху*/
    diff_top: CompareRow;
    /**Фактическое отличие*/
    diff_real: CompareRow;
}

/**Сведения о файлах изображений геометрических объектов*/
export interface ImagesFiles{
    /**Спереди*/
    forward: string;
    /**Сзади*/
    back: string;
    /**Слева*/
    left: string;
    /**Справа*/
    right: string;
    /**Снизу*/
    bottom: string;
    /**Сверху*/
    top: string;
}

/**Состояние проверки файлов */
export type StateExistFiles = {
    /**Наличие файла ГО */
    obj: boolean,
    /**Наличие файла изображения вида сверху */
    up: boolean,
    /**Наличие файла изображения вида снизу */
    down: boolean,
    /**Наличие файла изображения вида слева */
    left: boolean,
    /**Наличие файла изображения вида справа */
    right: boolean,
    /**Наличие файла изображения вида спереди */
    forward: boolean,
    /**Наличие файла изображения вида сзади */
    back: boolean,
    /**Сложение всех состояний проверки файлов */
    all: boolean
}

/**Сведения об отчете сравнения*/
export interface ViewResultReport{
    /**Код */
    r_c_id: number;
    /**Дата создания*/
    r_c_date: string;
    /**Имя файла требуемого ГО */
    req_file: string;
    /**Имя файла смоделированного ГО*/
    mod_file: string;
    /**Класс объекта */
    t_o_name: string;
    /**Название файла модели НС */
    name_file: string;
}

/**Отчета сравнения - результат и модель НС*/
export interface InfoReport {
    /**Код результата сравнения*/
    r_c_id: number;
    /**Дата сравнения*/
    date_compare: string;
    /**Класс */
    name: string;
    /**Код модели НС */
    m_nn_id: number;
    /**Дата создания модели НС*/
    date_create: string;
    /**Имя файла модели НС */
    name_file: string;
    /**Допустимая погрешность */
    err_resolve: number;
}

/**Отчет сравнения - изображения требуемого, смоделированного и разницы*/
export interface ViewReportImgs {
    /**Тип изображения */
    t_i_name: string;
    /**Код результата сравнения*/
    r_c_id: number;
    /**Код ракурса изображения*/
    pers_id: number;
    /**Название ракурса изображения*/
    pers_name: string;
    /**Путь к изображению */
    path: string;
    /**url изображения */
    url: string;
}

/** Отчет сравнения - информация о требуемом и смоделированном  ГО*/
export interface ViewReportGObj {
    /**Код изображения */
    gobj_id: number;
    /**Тип объекта */
    t_o_name: string;
    /**Дата создания */
    date_create: string;
    /**Название файла ГО */
    go_file: string;
    /**Код результата сравнения*/
    r_c_id: number;
    /**url ГО */
    url: string;
}

/**Отчет сравнения - отличия*/
export interface ViewReportDiffs {
    /**Название отличия */
    d_v_name: string;
    /**Значение */
    d_v_value: string;
    /**Код результата сравнения*/
    d_v_result_id: string;
}

/**Модель obj файла директории*/
export interface GeometryObjPath{
    id: number;
    path: string;
    url: string;
}




export interface Report {
    data1: InfoReport[];
    data2: ViewReportImgs[];
    data3: ViewReportImgs[];
    data4: ViewReportImgs[];
    data5: ViewReportGObj[];
    data6: ViewReportGObj[];
    data7: ViewReportGObj[];
    data8: ViewReportDiffs[];
}