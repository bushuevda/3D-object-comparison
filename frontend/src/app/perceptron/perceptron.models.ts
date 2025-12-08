/**Оптимизаторы */
export type Optimizer = "Adam" | "SGD";

/**Выбранный оптимизатор */
export type OptimizerSelect = {
    name: Optimizer,
    code: string
}

/**Состояния обучений НС */
export enum StateTrain{
    NotBegin,
    Begin,
    End
}


/**Параметры для обучения модели НС */
export interface TrainParameters{
    directory_id: number,
    directory_path: string,
    epochs: number,
    error_resolve: number,
    count_neuron: number,
    size_data: number,
    optimizer: Optimizer,
    name_model: string
}

/**Сведения о модели нейронной сети*/
export interface ModelNN{
    /**Код */
    id: number;
    /**Имя файла */
    name_file: string;
    /**Дата создания*/
    date_create: string;
    /**Код директории */
    directory_id: number;
    /**Название файла истории обучения */
    name_file_history: string;
    /**Допустимая погрешность */
    err_resolve: number;
}

