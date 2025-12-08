//Angular модули
import { Component, OnInit, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

//Primeng модули
import { ListboxModule } from 'primeng/listbox';
import { FloatLabelModule } from 'primeng/floatlabel';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { MultiSelectModule } from 'primeng/multiselect';
import { MessageService } from 'primeng/api';
import { SelectModule } from 'primeng/select';
import { Table } from 'primeng/table';
import { ToastModule } from 'primeng/toast';
import { ListboxChangeEvent } from 'primeng/listbox';

//Модули guide
import {UniversalRow, TableInfo, HelpDataTable} from "./guide.models"
import {GuideService} from './guide.service'


@Component({
    selector: 'guide',
    standalone: true,
    templateUrl: './guide.html',
    styleUrl: './guide.css',
    providers: [GuideService, MessageService],
    imports: [CommonModule, FormsModule, ListboxModule, FloatLabelModule, ButtonModule, TableModule,
            MultiSelectModule, SelectModule, ToastModule ]
})
export class GuideComponent implements OnInit {

    @ViewChild('ptableRoute') table!: Table;

    /**Информация о таблицах */
    tableInfo: TableInfo[] = [
      { name: 'Единица измерения', typeTable: HelpDataTable.UnitMeasurement },
      { name: 'Справочник отличий', typeTable: HelpDataTable.GuideDiferences },
      { name: 'Ракурс изображения', typeTable: HelpDataTable.ImageAngle },
      { name: 'Тип изображения', typeTable: HelpDataTable.ImageType },
      { name: 'Тип объекта', typeTable: HelpDataTable.ObjectType }
    ];

    /**Столбцы таблицы */
    columnsTable: any[] = [
      {field: "id", header:"Код"},
      {field: "name", header:"Название"},
      {field: "short_name", header:"Краткое название"},
    ];

    /**Данные привязанные к форме - для изменения и добавление записей */
    id!: number | null;
    name!: string;
    short_name!: string;

    /** Выбранная строка таблицы */
    selectedRow!: UniversalRow;

    /** Данные выбранной таблицы */
    selectedTable!: UniversalRow[];

    /** Выбранная таблица */
    selectedTableNumber!: HelpDataTable;

    constructor(private guideService: GuideService, private messageService: MessageService){}

    ngOnInit(): void {}

    /**Для получения данных с формы */
    onSelectRow(row: UniversalRow){
      this.id = row.id;
      this.name = row.name;
      this.short_name = row.short_name;
    }

    /**Обнуление input */
    resetInputs(){
      this.id = null;
      this.name = "";
      this.short_name = "";
    }

    /**Выбор таблицы из списка таблицы */
    onChange(event: ListboxChangeEvent){
      if(event.value === null)
        this.selectedTable = [];

      if(this.selectedTableNumber !== event?.value?.typeTable){
        this.table.clearFilterValues();
        this.selectedTableNumber = event?.value?.typeTable;
        this.getRowsTable(this.selectedTableNumber);
        this.resetInputs();
      }
    }

    /**Заполнение таблицы данными */
    getRowsTable(numberTable: number){
      if(numberTable){
        this.guideService.getDataTable(numberTable).subscribe({
          next: (data: UniversalRow[]) => {
              this.selectedTable = data;
          },
          error: (err: any) => console.log(err),
        });
      }

    }

    /**Изменение записи таблицы */
    updateRowTable(event: MouseEvent){
      if(this.name && this.id){
        this.guideService.updateDataTable(this.selectedTableNumber, this.id, this.name, this.short_name).subscribe({
          next: (data: any) => this.resetInputs(),
          error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена! ${err}` }),
          complete: () => {
            this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Запись изменена!' });
            this.getRowsTable(this.selectedTableNumber);
          }
        });
      } 
      else{
        if(!this.id){
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена. Не выбрана строка таблицы!` });
        }
        if(!this.name){
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена. Не заполнено поле 'Название'!` });
        }
        if(!this.selectedTableNumber){
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена. Не выбрана таблица!` });
        }
      }

    }

    /**Добавление записи в таблицу */
    insertRowTable(event: MouseEvent){
      if(this.name){
        this.guideService.insertDataTable(this.selectedTableNumber, this.name, this.short_name).subscribe({
          next: (data: any) => this.resetInputs(),
          error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не добавлена! ${err}` }),
          complete: () => {
            this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Запись добавлена!' });
            this.getRowsTable(this.selectedTableNumber);
          }
        });
      }
      else {
        if(!this.selectedTableNumber){
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена. Не выбрана таблица!` });
        }
        if(!this.name){
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не добавлена. Не заполнено поле 'Название'!` });
        }
      }

    }

    /**Получения значений для выпадающего списка фильтра */
    getOptions(val: string){
      return this.guideService.getOptions(val, this.selectedTable);
    }


}