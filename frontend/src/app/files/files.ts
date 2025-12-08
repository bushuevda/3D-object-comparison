//Angular модули
import { Component, OnInit, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

//Primeng модули
import { MessageService, TreeNode } from 'primeng/api';
import { ToastModule } from 'primeng/toast';
import { ButtonModule } from 'primeng/button';
import { FileUpload, FileUploadHandlerEvent, FileUploadModule } from 'primeng/fileupload';
import { FloatLabelModule } from 'primeng/floatlabel';
import { SelectModule } from 'primeng/select';
import { TreeModule, TreeNodeSelectEvent, TreeNodeUnSelectEvent } from 'primeng/tree';
import { BadgeModule } from 'primeng/badge';

//Модули directory
import { DirectoryService } from '../directory/directory.service';
import { DirectoryDB } from '../directory/directory.models';

//Модули files
import { CheckFileNumber, ModelCheckFiles, TypeImage} from './files.models';
import { FilesService } from './files.service';

//Модули guide
import { GuideService } from '../guide/guide.service';
import { HelpDataTable, UniversalRow } from '../guide/guide.models';

//Другие модули
import { TruncateFilenamePipe } from '../pipes/truncate-filename.pipe';


@Component({
    standalone: true,
    selector: 'files',
    templateUrl: './files.html',
    styleUrl: './files.css',
    imports: [TruncateFilenamePipe, FileUploadModule, ToastModule, ButtonModule, FloatLabelModule, SelectModule, TreeModule, CommonModule, FormsModule, BadgeModule],
    providers: [MessageService, DirectoryService, FilesService, GuideService]
})
export class FilesComponent implements OnInit{
    /** Загрузчики файлов */ 
    @ViewChild("ref_file_obj") ref_file_obj!: FileUpload;
    @ViewChild("ref_img_forward") ref_img_forward!: FileUpload;
    @ViewChild("ref_img_back") ref_img_back!: FileUpload;
    @ViewChild("ref_img_left") ref_img_left!: FileUpload;
    @ViewChild("ref_img_right") ref_img_right!: FileUpload;
    @ViewChild("ref_img_up") ref_img_up!: FileUpload;
    @ViewChild("ref_img_down") ref_img_down!: FileUpload;

    /**Дерево директорий */
    treeDirectories!: TreeNode[];

    /**Путь к каталогу */
    pathToDirectory: string = "";

    /**Типы объектов */
    typesObject!: UniversalRow[];

    /**Выбранный тип объекта */
    selectedTypeObject: UniversalRow | undefined;

    /**Состояния наличие файла в директории */
    stateFileUpload = {
      obj: true,
      up: true,
      down: true,
      left: true,
      right: true,
      forward: true,
      back: true
    };


    /**enum типов изображений */
    typesImage = TypeImage;

    /**enum ракурсов изображений */
    perspectivesImage = CheckFileNumber;

    /**Выбранная директория из дерева директорий */
    selectedDirectory!: TreeNode;

    constructor(private messageService: MessageService, private directoryService: DirectoryService, 
              private fileService: FilesService, private guideService: GuideService) {}

    ngOnInit() {
      this.guideService.getDataTable(HelpDataTable.ObjectType).subscribe({
        next: (data: UniversalRow[]) => {
          this.typesObject = data;
        }
      });

      this.getTreeDirectories();
    }


    /**Получение дерева директорий */
    getTreeDirectories(){
      this.directoryService.getDataDirectoriesWithoutCompare().subscribe({
        next: (data: DirectoryDB[]) => {
          let dataTreePrimeng: TreeNode[] = this.directoryService.listToTree(data);
          this.treeDirectories = dataTreePrimeng;
        }
      });
    }

    /**Загрузка файла obj */
    customUploadHandlerObj(event: FileUploadHandlerEvent) {
      if(!this.selectedTypeObject){
        this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: 'Не выбран тип объекта!'});
      } else {

        this.fileService.sendFileToServerObj(event.files[0], Number(this.selectedDirectory.key), this.pathToDirectory, this.selectedTypeObject.id).subscribe(
          {
            next: (val: any) => {
              this.checkDirectoryFiles(Number(this.selectedDirectory.key));
              //Для obj файла выбрано 7
              this.clearFilesUpload(CheckFileNumber.obj);
            },
            error: (err: any) => this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: err}),
            complete: () => this.messageService.add({severity: 'success', summary: 'Успешно.', detail: 'Файл загружен и добавлен на сервер!'})
          }
        );
      }
    }

    /**Загрузка файла изображения */
    customUploadHandlerImg(event: FileUploadHandlerEvent, perspective_id: number, type_image_id: number) {
      let error: any;
      this.fileService.sendFileToServerImage(event.files[0], Number(this.selectedDirectory.key), this.pathToDirectory, type_image_id, perspective_id).subscribe(
        {
          next: (val: any) => {
            error = val.error;
            this.checkDirectoryFiles(Number(this.selectedDirectory.key));
            this.clearFilesUpload(perspective_id);
          },
          error: (err: any) => this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: err}),
          complete: () => {
            if(error)
              this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: 'Отсутствует файл .obj в выбранной директории!'});
            else
              this.messageService.add({severity: 'success', summary: 'Успешно.', detail: 'Файл загружен и добавлен на сервер!'});
          }
        }
      );
    }

    /**Выбор директории */
    nodeSelect(event: TreeNodeSelectEvent) {
      this.pathToDirectory = this.directoryService.formedStringPathNode(this.directoryService.formedArrayPathNode(event.node));
      this.checkDirectoryFiles(Number(event.node.key));
    }

    /**Снятия выбора директории */
    nodeUnselect(event: TreeNodeUnSelectEvent) {
      this.pathToDirectory = "";
      this.stateFileUpload = {
        obj: true,
        up: true,
        down: true,
        left: true,
        right: true,
        forward: true,
        back: true
      };
    }

    /**Очистка загрузчиков файлов */
    clearFilesUpload(checkFileNumber: number){
      switch(checkFileNumber){
        case CheckFileNumber.forward:
          this.ref_img_forward.clear();
          break;
        case CheckFileNumber.back:
          this.ref_img_back.clear();
          break;
        case CheckFileNumber.left:
          this.ref_img_left.clear();
          break;
        case CheckFileNumber.right:
          this.ref_img_right.clear();
          break;
        case CheckFileNumber.up:
          this.ref_img_up.clear();
          break;
        case CheckFileNumber.down:
          this.ref_img_down.clear();
          break;
        case CheckFileNumber.obj:
          this.ref_file_obj.clear();
          break;
      }
    }

    /**Проверка наличия файлов в директории */
    checkDirectoryFiles(directory_id: number){
      this.fileService.checkFilesDirectory(directory_id).subscribe({
        next: (data: ModelCheckFiles[]) => {
          data.forEach((val) => {
            switch(val.id){
              case CheckFileNumber.forward:
                this.stateFileUpload.forward = val.exist;
                break;
              case CheckFileNumber.back:
                this.stateFileUpload.back = val.exist;
                break;
              case CheckFileNumber.left:
                this.stateFileUpload.left = val.exist;
                break;
              case CheckFileNumber.right:
                this.stateFileUpload.right = val.exist;
                break;
              case CheckFileNumber.up:
                this.stateFileUpload.up = val.exist;
                break;
              case CheckFileNumber.down:
                this.stateFileUpload.down = val.exist;
                break;
              case CheckFileNumber.obj:
                this.stateFileUpload.obj = val.exist;
                break;
            }
          });
        },
        error: (err: any) => console.log(err)
      });
    }

}