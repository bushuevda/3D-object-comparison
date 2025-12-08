/**
 * Общий интерфейс для нескольких таблиц:
 * 1. Единицы измерения
 * 2. Справочник отличий
 * 3. Ракурс изображения
 * 4. Тип изображения
 * 5. Тип объекта
 */

/**
 * Интерфейс для таблицы Единицы измерения
 */
export interface UniversalRow{
  id: number;
  name: string;
  short_name: string;
}


/**Для переключения между таблицами */
export enum HelpDataTable{
  UnitMeasurement = 1,
  GuideDiferences,
  ImageAngle,
  ImageType,
  ObjectType
}

/**Информация о типе таблицы */
export interface TableInfo{
  name: string;
  typeTable: HelpDataTable;
}