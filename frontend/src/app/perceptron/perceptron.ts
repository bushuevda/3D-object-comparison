//Angular модули
import { isPlatformBrowser } from '@angular/common';
import { ChangeDetectorRef, Component, inject, OnInit, PLATFORM_ID } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

//Primeng модули
import { MessageService, TreeNode } from 'primeng/api';
import { ChartModule } from 'primeng/chart';
import { ImageModule } from 'primeng/image';
import { ButtonModule } from 'primeng/button';
import { FloatLabelModule } from 'primeng/floatlabel';
import { RadioButtonModule } from 'primeng/radiobutton';
import { TreeModule } from 'primeng/tree';
import { TreeNodeSelectEvent } from 'primeng/tree';
import { SelectModule } from 'primeng/select';
import { ProgressSpinnerModule } from 'primeng/progressspinner';
import { ToastModule } from 'primeng/toast';

//Модули directory
import { DirectoryService } from '../directory/directory.service';
import { DirectoryDB } from '../directory/directory.models';

//Модули perceptron
import { PerceptronService } from './perceptron.service';
import { TrainParameters, OptimizerSelect, StateTrain} from './perceptron.models';


@Component({
    selector: 'perceptron',
    standalone: true,
    templateUrl: './perceptron.html',
    styleUrl: './perceptron.css',
    providers: [MessageService, DirectoryService, PerceptronService],
    imports: [ChartModule, ImageModule, ButtonModule, FloatLabelModule, RadioButtonModule, CommonModule,
              ProgressSpinnerModule, FormsModule, TreeModule, SelectModule, ToastModule]
})
export class PerceptronComponent implements OnInit {

    /** Данные для диаграммы обучения */
    data: any;
    /** Опции для диаграммы обучения */
    options: any;
    /** Платформа для диаграммы обучения */
    platformId = inject(PLATFORM_ID);

    /**Точность Precision */
    precision!: number;
    /**Полнота Recall */
    recall!: number;
    /** f1 мера */
    f1!: number;
    /** Сбалансированная точность  Bbalanced Accuracy*/
    balancedAccuracy!: number;

    /** enum состояний обучения НС*/
    EnumStateTrain = StateTrain;

    /**Состояние завершения обучения */
    statePrepareTrain: StateTrain = this.EnumStateTrain.NotBegin;

    /** Доступные оптимизаторы */
    optimizers: OptimizerSelect[] = [
        { name: 'Adam', code: '1' },
        { name: 'SGD', code: '2' },
    ];

    /**Название модели */
    nameModel!: string;
    /**Количество эпох */
    countEpochs!: number;
    /**Допустимая погрешность */
    errResolve!: number;
    /**Кол-во нейроном в первом скрытом слое */
    countNeuron!: number;
    /**Размер выборки */
    sizeData!: number;
    /**Оптимизатор */
    optimizer!: OptimizerSelect;

    /**Путь к каталогу */
    pathToDirectory: string = "";

    /**Дерево директорий */
    treeDirectories!: TreeNode[];

    /**Выбранная директория из дерева директорий */
    selectedDirectory!: TreeNode;

    constructor(private cd: ChangeDetectorRef, private messageService: MessageService, 
                private directoryService: DirectoryService, private perceptronService: PerceptronService) {}

    ngOnInit() {
        this.getTreeDirectories();
    }

    /**Ограничение ввода только положительных чисел*/
    changePositiveNumber(event: Event){
      const inputElement = event.target as HTMLInputElement;
      inputElement.value = String(Math.abs(Number(inputElement.value)));
    }

    /**Обработка события изменения поля Количество эпох */
    onChangeCountEpochs(event: Event){
      const inputElement = event.target as HTMLInputElement;
      const value = inputElement.value;
      this.nameModel = `model_epochs${this?.countEpochs}`;
    }

    /**Обработка события изменения поля Допустимая погрешность */
    onChangeErrResolve(event: Event){
      const inputElement = event.target as HTMLInputElement;
      const value = inputElement.value;
      this.nameModel = `model_epochs${this?.countEpochs}_err${this?.errResolve}`;
    }

    /**Обработка события изменения поля Кол-во нейроном в первом скрытом слое */
    onChangeCountNeuron(event: Event){
      const inputElement = event.target as HTMLInputElement;
      const value = inputElement.value;
      this.nameModel = `model_epochs${this?.countEpochs}_err${this?.errResolve}_cneuron${this?.countNeuron}`;
    }

    /**Обработка события изменения поля Размер выборки */
    onChangeSizeData(event: Event){
      const inputElement = event.target as HTMLInputElement;
      const value = inputElement.value;
      this.nameModel = `model_epochs${this?.countEpochs}_err${this?.errResolve}_cneuron${this?.countNeuron}_sizedata${this?.sizeData}`;
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

    /**Событие при выборе node */
    nodeSelect(event: TreeNodeSelectEvent) {
        this.pathToDirectory = this.directoryService.formedStringPathNode(this.directoryService.formedArrayPathNode(event.node));
    }

    /**Событие при снятии выделения node */
    nodeUnselect(event: any) {
      this.pathToDirectory = "";
    }

    /**Обучение модели НС */
    trainModel(event: any){
      if(!this.selectedDirectory || !this.countEpochs || !this.errResolve || !this.countNeuron ||
        !this.sizeData || !this.optimizer){
          if(!this.selectedDirectory)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не выбран каталог!` });
          if(!this.countEpochs)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не заполнено поле 'Количество эпох'!` });
          if(!this.errResolve)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не заполнено поле 'Допустимая погрешность'!` });
          if(!this.countNeuron)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не заполнено поле 'Кол-во нейроной в первом скрытом слое'!` });
          if(!this.sizeData)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не заполнено поле 'Размер выборки'!` });
          if(!this.optimizer)
            this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Не заполнено поле 'Оптимизатор'!` });
      } else{
        this.statePrepareTrain = this.EnumStateTrain.Begin;
        let params: TrainParameters = {
          directory_id: Number(this.selectedDirectory.key),
          directory_path: this.pathToDirectory,
          epochs: this.countEpochs,
          error_resolve: this.errResolve,
          count_neuron: this.countNeuron,
          size_data: this.sizeData,
          optimizer: this.optimizer.name,
          name_model: this.nameModel
        };
        this.perceptronService.trainModelNN(params).subscribe({
          next: (data: any) => { 
            this.precision = data.precision;
            this.recall = data.recall;
            this.f1 = data.f1_score;
            this.balancedAccuracy = data.balanced_accuracy;
          },
          error: (err: any) => this.messageService.add({ severity: 'error', summary: 'Ошибка', detail: `Модель не обучена! ${err}` }),
          complete: () => {
            this.statePrepareTrain = this.EnumStateTrain.End;
            this.messageService.add({ severity: 'success', summary: 'Успешно', detail: 'Модель обучена!' });
            this.initChart();
          }
        });
      }
    }

    /**Инициализация графика обучения */
    initChart() {
        if (isPlatformBrowser(this.platformId)) {
            const documentStyle = getComputedStyle(document.documentElement);
            const textColor = documentStyle.getPropertyValue('--p-text-color');
            const textColorSecondary = documentStyle.getPropertyValue('--p-text-muted-color');
            const surfaceBorder = documentStyle.getPropertyValue('--p-content-border-color');

            this.data = {
              labels: ['Precision', 'Recall', 'F1', 'Balanced accuracy'],
              datasets: [
                  {
                      label: 'Метрики качества',
                      data: [this.precision, this.recall, this.f1, this.balancedAccuracy],
                      backgroundColor: [
                          'rgba(249, 115, 22, 0.2)',
                          'rgba(6, 182, 212, 0.2)',
                          'rgb(107, 114, 128, 0.2)',
                          'rgba(139, 92, 246, 0.2)',
                      ],
                      borderColor: ['rgb(249, 115, 22)', 'rgb(6, 182, 212)', 'rgb(107, 114, 128)', 'rgb(139, 92, 246)'],
                      borderWidth: 1,
                  },
              ],
            };

            this.options = {
                maintainAspectRatio: false,
                aspectRatio: 0.6,
                plugins: {
                    legend: {
                        display: false,
                        labels: {
                            color: textColor,
                            hidden: true
                        }
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: textColorSecondary
                        },
                        grid: {
                            color: surfaceBorder,
                            drawBorder: false
                        }
                    },
                    y: {
                        min: 0,
                        max: 1.0,
                        ticks: {
                            color: textColorSecondary
                        },
                        grid: {
                            color: surfaceBorder,
                            drawBorder: false
                        }
                    }
                }
            };
            this.cd.markForCheck()
        }
    }
}