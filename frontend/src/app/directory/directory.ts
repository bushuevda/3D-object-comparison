//Angular модули
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

//Primeng модули
import { TreeModule } from 'primeng/tree';
import { ToastModule } from 'primeng/toast';
import { ListboxModule } from 'primeng/listbox';
import { FloatLabelModule } from 'primeng/floatlabel';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { MultiSelectModule } from 'primeng/multiselect';
import { SelectModule } from 'primeng/select';
import { MessageService, TreeNode } from 'primeng/api';
import { TreeNodeSelectEvent } from 'primeng/tree';

//Модули directory
import { DirectoryService } from './directory.service';
import { DirectoryDB } from './directory.models';


@Component({
    selector: 'directory',
    standalone: true,
    templateUrl: './directory.html',
    styleUrl: './directory.css',
    providers: [DirectoryService, MessageService],
    imports: [CommonModule, FormsModule, TreeModule, ListboxModule, FloatLabelModule,
                ButtonModule, TableModule, MultiSelectModule, SelectModule, ToastModule]
})
export class DirectoryComponent implements OnInit{

    /**Путь к каталогу */
    pathToDirectory: string = "";

    /**Имя нового каталога */
    nameNewDirectory: string = "";

    /**Имя каталога для изменения */
    nameChangeDirectory: string = "";

    /**Дерево директорий */
    treeDirectories!: TreeNode[];

    /**Выбранная директория из дерева директорий */
    selectedDirectory!: TreeNode;


    constructor(private directoryService: DirectoryService, private messageService: MessageService) {}

    ngOnInit() {
        this.getTreeDirectories();
    }

    /**Обнуление инпутов +*/
    resetInputs(){
      this.pathToDirectory = "";
      this.nameChangeDirectory = "";
      this.nameNewDirectory = "";
    }

    /**Получение дерева директорий +*/
    getTreeDirectories(){
      this.directoryService.getDataDirectoriesWithoutCompare().subscribe({
        next: (data: DirectoryDB[]) => {
          let dataTreePrimeng: TreeNode[] = this.directoryService.listToTree(data);
          this.treeDirectories = dataTreePrimeng;
        }
      });
    }

    /**Событие при выборе node +*/
    nodeSelect(event: TreeNodeSelectEvent) {
        this.pathToDirectory = this.directoryService.formedStringPathNode(this.directoryService.formedArrayPathNode(event.node));
    }

    /**Событие при снятии выделения node +*/
    nodeUnselect(event: any) {
      this.pathToDirectory = "";
    }

    /**Событие изменения директории +*/
    onClickChange(event: MouseEvent){
      if(this.selectedDirectory && this.nameChangeDirectory){
        this.directoryService.updateDirectory(Number(this.selectedDirectory.key), this.nameChangeDirectory).subscribe({
          next: (data: any) => console.log(data),
          error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не изменена! ${err}` }),
          complete: () => {
            this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Запись изменена!' });
            this.getTreeDirectories();
            this.resetInputs();
          }
        });
      }
      else{
        if(!this.nameChangeDirectory)
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Каталог не изменен. Не заполнено новое имя для каталога!` });
        if(!this.selectedDirectory)
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Каталог не изменен. Не выбран каталог!` });
      }
    }

    /**Событие добавления директории */
    onClickAdd(event: MouseEvent){
      console.log(this.selectedDirectory);
      if(this.selectedDirectory && this.nameNewDirectory){
        this.directoryService.addDirectoryWithParent(this.nameNewDirectory, Number(this.selectedDirectory.key)).subscribe({
          next: (data: any) => console.log(data),
          error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не добавлена! ${err}` }),
          complete: () => {
            this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Запись добавлена!' });
            this.getTreeDirectories();
            this.resetInputs();
          }
        });
      }
      else {
        if(this.nameNewDirectory)
          this.directoryService.addDirectoryNoneParent(this.nameNewDirectory).subscribe({
            next: (data: any) => console.log(data),
            error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Запись не добавлена! ${err}` }),
            complete: () => {
              this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Запись добавлена!' });
              this.getTreeDirectories();
              this.resetInputs();
            }
          });
        else{
          this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Каталог не добавлена. Не заполнено имя нового каталога!` });
        }
      }
    }

}