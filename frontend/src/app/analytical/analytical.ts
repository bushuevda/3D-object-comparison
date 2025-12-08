//Angular модули
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

//Primeng модули
import { MessageService, TreeNode } from 'primeng/api';
import { TreeModule } from 'primeng/tree';
import { StepperModule } from 'primeng/stepper';
import { ToastModule } from 'primeng/toast';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';
import { ImageModule } from 'primeng/image';
import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { MenubarModule } from 'primeng/menubar';
import { TreeNodeSelectEvent } from 'primeng/tree';

//Другие модули
import { forkJoin } from 'rxjs';
import { TYPE_OBJ_MODELED, TYPE_OBJ_REQUIRED } from '../shared/constants';

//Модули analytical
import { OrderTableInfo } from './analytical.models';
import { AnalyticalService } from './analytical.service';
import { StateExistFiles, ViewResultReport, GeometryObjPath, Report} from './analytical.models';
import { EngineService } from './object-viewer/engine.service';
import { ObjectViewerComponent } from './object-viewer/object-viewer';

//Модули directory
import { DirectoryDB } from '../directory/directory.models';
import { DirectoryService } from '../directory/directory.service';

//Модули files
import { FilesService } from '../files/files.service';
import { CheckFileNumber, ModelCheckFiles } from '../files/files.models';

//Модули perceptron
import { PerceptronService } from '../perceptron/perceptron.service';
import { ModelNN} from '../perceptron/perceptron.models';



@Component({
    selector: 'analytical',
    standalone: true,
    templateUrl: './analytical.html',
    styleUrl: './analytical.css',
    imports: [CommonModule, FormsModule, ImageModule, StepperModule, TreeModule, ToastModule, ButtonModule, 
            TableModule, ObjectViewerComponent, MenubarModule, ProgressSpinnerModule],
    providers: [MessageService, DirectoryService, FilesService, PerceptronService, AnalyticalService]
})
export class AnalyticalComponent {
    
    //-------------Общие переменные-------------
    /**Элементы меню */
    items = [
        {
            label: 'Сформировать отчет',
            icon: 'pi pi-file-arrow-up',
            command: () => {
                this.stateShowFormedReport = true;
                this.stateShowReport = false;
                this.stateShowReportRead = false;
            }
        },
        {
            label: 'Просмотреть отчеты',
            icon: 'pi pi-file-check',
            command: () => {
                this.stateShowFormedReport = false;
                this.stateShowReport = true;
                this.stateShowReportRead = false;

            }
        },
    ]
    /**Форма отчета сравнения */
    orderTable: OrderTableInfo = {};


    //-------------Состояния-------------
    /**Состояние открытия меню сравнения характеристик */
    stateShowFormedReport: boolean = true;
    /**Состояние открытия меню просмотра старых отчетов */
    stateShowReport: boolean = false;
    /**Состояние открытия выбора модели НС */
    stateShowModelNN: boolean = true;
    /**Состояние открытия сформированного отчета сравнения */
    stateShowReadyReport: boolean = false;
    /**Состояние отображение отчета для чтения */
    stateShowReportRead: boolean = false;
    /**Состояние загрузки отчета для чтения */
    stateLoadingReportRead: boolean = false;


    //-------------Переменные для p-stepper-------------
    /**Наличие файлов для выбранного каталога требуемого объекта */
    rulesUpload1: StateExistFiles = {
        obj: false,
        up: false,
        down: false,
        left: false,
        right: false,
        forward: false,
        back: false,
        all: false
    };
    /**Наличие файлов для выбранного каталога смоделированного объекта */
    rulesUpload2: StateExistFiles = {
        obj: false,
        up: false,
        down: false,
        left: false,
        right: false,
        forward: false,
        back: false,
        all: false
    };
    /**Текущий шаг компонента p-stepper*/
    stepNum: number = 1;
    /**Дерево директорий */
    treeDirectories!: TreeNode[];
    /**Выбранная директория из дерева директорий */
    selectedDirectory1!: TreeNode;
    /**Выбранная директория из дерева директорий */
    selectedDirectory2!: TreeNode;



    //-------------Переменные для таблицы Отчеты сравнения-------------
    /**Данные таблицы Отчетов сравнения */
    viewsReport!: ViewResultReport[];
    /**Столбцы таблицы Отчетов сравнения*/
    columnsViewResultReport =[
        {field: "r_c_id", header:"Код"},
        {field: "r_c_date", header:"Дата создания"},
        {field: "req_file", header:"Имя файла требуемого ГО"},
        {field: "mod_file", header:"Имя файла смоделированного ГО"},
        {field: "t_o_name", header:"Класс объекта"},
        {field: "name_file", header:"Название файла модели НС"},
    ];
    /**Выбранный отчет для чтения из таблицы */
    selectedResult!: ViewResultReport;


    //-------------Переменные для таблицы Модели НС-------------
    /**Данные таблицы модели НС */
    modelsPerceptron!: ModelNN[];
    /**Столбцы таблицы моделей НС*/
    columnsTableNN = [
        {field: "id", header:"Код"},
        {field: "name_file", header:"Файл модели"},
        {field: "date_create", header:"Дата создания"},
        {field: "directory_id", header:"Код директории"},
        {field: "name_file_history", header:"Файл истории обучения"},
        {field: "err_resolve", header:"Допустимая погрешность"},
    ];
    /**Выбранная директория из дерева директорий */
    selectedModelNN!: ModelNN;


    constructor(private messageService: MessageService, private directoryService: DirectoryService, 
                private fileService: FilesService, private perceptronService: PerceptronService, 
                private analyticalService: AnalyticalService, private engSv: EngineService) {}


    ngOnInit() {
        this.getTreeDirectories();
        this.getModelNNTable();
        this.getViewResultReportTable();
    }

    /**Событие при снятии выделения node */
    nodeUnselect(event: any) {
    }

    /**Событие при выборе node */
    nodeSelect(event: TreeNodeSelectEvent) {
        if(this.stepNum == 1){
            this.rulesUpload1 = {
                obj: false,
                up: false,
                down: false,
                left: false,
                right: false,
                forward: false,
                back: false,
                all: false
            };
            this.checkDirectoryFiles(Number(event.node.key), String(event.node.label), this.rulesUpload1);
        }
        else if(this.stepNum == 2){
            this.rulesUpload2 = {
                obj: false,
                up: false,
                down: false,
                left: false,
                right: false,
                forward: false,
                back: false,
                all: false
            };
            this.checkDirectoryFiles(Number(event.node.key), String(event.node.label), this.rulesUpload2);
        }

        this.analyticalService.getObjectDirectory(Number(event.node.key)).subscribe({
            next: (data: GeometryObjPath[]) => {
                this.engSv.add_obj_to_scene(data[0].url);
            }
        })
    }

    /**Получение дерева директорий +*/
    getTreeDirectories(){
        let type_obj_id = this.stepNum == 1 ? TYPE_OBJ_MODELED : TYPE_OBJ_REQUIRED;
        this.directoryService.getDataDirectoriesById(type_obj_id).subscribe({
            next: (data: DirectoryDB[]) => {
                let dataTreePrimeng: TreeNode[] = this.directoryService.listToTree(data);
                this.treeDirectories = dataTreePrimeng;
            }
        });
    }

    /**Проверка наличия файлов в директории +*/
    checkDirectoryFiles(directory_id: number, directory_name: string, rulesUpload: StateExistFiles){
        this.fileService.checkFilesDirectory(directory_id).subscribe({
            next: (data: ModelCheckFiles[]) => {
                data.forEach((val) => {
                    switch(val.id){
                        case CheckFileNumber.forward:
                        rulesUpload.forward = val.exist;
                        break;
                        case CheckFileNumber.back:
                        rulesUpload.back = val.exist;
                        break;
                        case CheckFileNumber.left:
                        rulesUpload.left = val.exist;
                        break;
                        case CheckFileNumber.right:
                        rulesUpload.right = val.exist;
                        break;
                        case CheckFileNumber.up:
                        rulesUpload.up = val.exist;
                        break;
                        case CheckFileNumber.down:
                        rulesUpload.down = val.exist;
                        break;
                        case CheckFileNumber.obj:
                        rulesUpload.obj = val.exist;
                        break;
                    }
                });
                this.showNotFiles(directory_name, rulesUpload);
            },
            error: (err: any) => console.log(err)
        });
    }

    /**Вывод уведомлений отсутствующих файлов + */
    showNotFiles(name_catalog: string,  rulesUpload: StateExistFiles) {
        rulesUpload.all = rulesUpload.back  && rulesUpload.forward && rulesUpload.down && rulesUpload.up
                                && rulesUpload.left && rulesUpload.right && rulesUpload.obj;
        if(!rulesUpload.forward)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует изображение спереди!`});
        if(!rulesUpload.back)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  изображение сзади!`});
        if(!rulesUpload.left)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  изображение слева!`});
        if(!rulesUpload.right)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  изображение справа!`});
        if(!rulesUpload.up)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  изображение сверху!`});
        if(!rulesUpload.down)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  изображение снизу!`});
        if(!rulesUpload.obj)
            this.messageService.add({severity: 'error', summary: 'Ошибка.', detail: `В каталоге ${name_catalog} отсутствует  файл .obj!`});
    }

    /**Получение модели НС +*/
    getModelNNTable(){
        this.perceptronService.getModelNN().subscribe({
            next: (data: ModelNN[]) =>{
                this.modelsPerceptron = data;
            }
        });
    }

    /**Получение данных для таблицы Отчеты сравнения +*/
    getViewResultReportTable(){
        this.analyticalService.getViewResultReport().subscribe({
            next: (data: ViewResultReport[]) =>{
                this.viewsReport = data;
            }
        });
    }

    /**Переход в начало формирования отчета +*/
    stepNewReport(event: any, callback: (stepId: number) => void, stepId: number){
        callback(stepId);
        this.stateShowModelNN = true;
        this.stateShowReadyReport = false;
    }

    /**Подготовка отчета +*/
    prepareReport(report: Report){
        /**Первая часть отчета */
        let part1 = report.data1[0];
    
        this.orderTable.resultCompare = {
            id: part1.r_c_id,
            date_compare: part1.date_compare,
            type_object: part1.name,
        };

        this.orderTable.modelNeuralNetwork = {
            id: part1.m_nn_id,
            ed_izm: "%",
            date_create: part1.date_create,
            resolve_diff: part1.err_resolve,
            name_file: part1.name_file
        };


        /**Вторая часть отчета */
        report.data2 = report.data2.sort((a, b) => a.pers_id - b.pers_id);
        this.orderTable.imagesFilesRequired = {
            top: report.data2[0].url,
            bottom: report.data2[1].url,
            left: report.data2[2].url,
            right: report.data2[3].url,
            forward: report.data2[4].url,
            back: report.data2[5].url,
        };

        /**Третья часть отчета */
        report.data3 = report.data3.sort((a, b) => a.pers_id - b.pers_id);
        this.orderTable.imagesFilesModeled = {
            top: report.data3[0].url,
            bottom: report.data3[1].url,
            left: report.data3[2].url,
            right: report.data3[3].url,
            forward: report.data3[4].url,
            back: report.data3[5].url,
        };

        /**Четвертая часть отчета */
        report.data4 = report.data4.sort((a, b) => a.pers_id - b.pers_id);
        this.orderTable.imagesFilesDiff = {
            top: report.data4[0].url,
            bottom: report.data4[1].url,
            left: report.data4[2].url,
            right: report.data4[3].url,
            forward: report.data4[4].url,
            back: report.data4[5].url,
        };

        /**Пятая часть отчета */
        let part5 = report.data5[0];

        this.orderTable.geometryObjectModeled = {
            id: part5.gobj_id,
            date_create: part5.date_create,
            name_file: part5.go_file,
            type_object: part5.t_o_name
        };


        /**Шестая часть отчета */
        let part6 = report.data6[0];

        this.orderTable.geometryObjectRequired = {
            id: part6.gobj_id,
            date_create: part6.date_create,
            name_file: part6.go_file,
            type_object: part6.t_o_name
        };

        /**Седьмая часть отчета */
        let part7 = report.data7[0];

        this.orderTable.geometryObjectModeled = {
            id: part7.gobj_id,
            date_create: part7.date_create,
            name_file: part7.go_file,
            type_object: part7.t_o_name
        };


        /**Восьмая часть отчета */

        let avg_real = report.data8.reduce((total, currentValue) => total + Number(currentValue.d_v_value), 0) / 12;

        this.orderTable.compareValues = {
            diff_count_vertex: {
                value: Number(report.data8[0].d_v_value),
                ed_izm: "%"
            },
            diff_count_edge: {
                value: Number(report.data8[1].d_v_value),
                ed_izm: "%"
            },
            diff_count_face: {
                value: Number(report.data8[2].d_v_value),
                ed_izm: "%"
            },
            diff_map_faces: {
                value: Number(report.data8[3].d_v_value),
                ed_izm: "%"
            },
            diff_map_edge: {
                value: Number(report.data8[4].d_v_value),
                ed_izm: "%"
            },
            diff_map_angle: {
                value: Number(report.data8[5].d_v_value),
                ed_izm: "%"
            },
            diff_forward: {
                value: Number(report.data8[6].d_v_value),
                ed_izm: "%"
            },
            diff_back: {
                value: Number(report.data8[7].d_v_value),
                ed_izm: "%"
            },
            diff_left: {
                value: Number(report.data8[8].d_v_value),
                ed_izm: "%"
            },
            diff_right: {
                value: Number(report.data8[9].d_v_value),
                ed_izm: "%"
            },
            diff_bottom: {
                value: Number(report.data8[10].d_v_value),
                ed_izm: "%"
            },
            diff_top: {
                value: Number(report.data8[11].d_v_value),
                ed_izm: "%"
            },
            diff_real: {
                value: avg_real,
                ed_izm: "%"
            },
        };
    }

    /**Получения ранее сформированного отчета + */
    getReport(event: any, r_c_id: number = this.selectedResult.r_c_id){
        this.stateShowReport = false;
        this.stateLoadingReportRead = true;

        forkJoin({
            data1: this.analyticalService.getInfOrderCompare(r_c_id),
            data2: this.analyticalService.getImgsReqPath(r_c_id),
            data3: this.analyticalService.getImgsModPath(r_c_id),
            data4: this.analyticalService.getImgsDiffPath(r_c_id),
            data5: this.analyticalService.getGobjModeledByResult(r_c_id),
            data6: this.analyticalService.getGobjRequiredByResult(r_c_id),
            data7: this.analyticalService.getGobjModeledByResult(r_c_id),
            data8: this.analyticalService.getDiffsOrderCompare(r_c_id)
        }).subscribe({
            next: (report: Report) => {
                this.prepareReport(report);
                this.stateShowReportRead = true;
                this.stateLoadingReportRead = false;
            }
        })

    }

    /**Формирование отчета сравнения + */
    compareObjects(event: any){

        let directory_id_req = Number(this.selectedDirectory1.key);
        let directory_id_mod = Number(this.selectedDirectory2.key);
        let perceptron_id = this.selectedModelNN.id;
        
        this.stateShowModelNN = false;

        this.analyticalService.compareGeomtryObjects(directory_id_mod, directory_id_req, perceptron_id).subscribe({
            next: (r_c_id: number) => {
                forkJoin({
                    data1: this.analyticalService.getInfOrderCompare(r_c_id),
                    data2: this.analyticalService.getImgsReqPath(r_c_id),
                    data3: this.analyticalService.getImgsModPath(r_c_id),
                    data4: this.analyticalService.getImgsDiffPath(r_c_id),
                    data5: this.analyticalService.getGobjModeledByResult(r_c_id),
                    data6: this.analyticalService.getGobjRequiredByResult(r_c_id),
                    data7: this.analyticalService.getGobjModeledByResult(r_c_id),
                    data8: this.analyticalService.getDiffsOrderCompare(r_c_id)
                }).subscribe({
                    next: (report: Report) => {
                        this.prepareReport(report);
                        this.stateShowReadyReport = true;
                    }
                });
            }
        });
    }

}
