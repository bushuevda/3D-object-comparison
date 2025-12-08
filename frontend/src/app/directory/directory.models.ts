
/**Модель для каталогов */
export interface DirectoryDB{
    id: number,
    name: string,
    parent_id: number | null
}