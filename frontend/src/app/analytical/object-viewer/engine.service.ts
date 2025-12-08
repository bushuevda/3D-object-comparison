import { ElementRef, Injectable, NgZone, OnDestroy } from '@angular/core';
import * as THREE from 'three';
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js';

@Injectable({ providedIn: 'root' })
export class EngineService implements OnDestroy {

    /**Графические элементы */
    private canvas!: HTMLCanvasElement | null;
    private renderer!: THREE.WebGLRenderer | null;
    private camera!: THREE.PerspectiveCamera;
    private scene!: THREE.Scene;
    private light!: THREE.AmbientLight;
    private frameId: number | null = null;

    /**Трехмерный объект */
    private mesh: THREE.Object3D | undefined;
    
    /**Для измерения времени между кадрами */
    clock = new THREE.Clock();

    public constructor(private ngZone: NgZone) {}

    public ngOnDestroy(): void {
      if (this.frameId != null) {
        cancelAnimationFrame(this.frameId);
      }
      if (this.renderer != null) {
        this.renderer.dispose();
        this.renderer = null;
        this.canvas = null;
      }
    }

    /**Создание сцены */
    public createScene(canvas: ElementRef<HTMLCanvasElement>): void {
      this.canvas = canvas.nativeElement;

      this.renderer = new THREE.WebGLRenderer({
        canvas: this.canvas,
        alpha: true,
        antialias: true 
      });

      let width = window.innerWidth ;
      let height = window.innerHeight ;
      //this.renderer.setSize(window.innerWidth / 2, window.innerHeight / 2);
      this.renderer.setSize(width / 2, height / 2);
    
      this.scene = new THREE.Scene();

      this.camera = new THREE.PerspectiveCamera( 75, width  / height, 0.1, 1000 );
      this.camera.position.z = 5;
      this.scene.add(this.camera);


      this.light = new THREE.AmbientLight(0x404040);
      this.light.position.z = 10;
      this.scene.add(this.light);
    }

    /**Добавление объекта на сцену */
    public add_obj_to_scene(url: string): void{
      const loader = new OBJLoader();
      loader.setCrossOrigin('anonymous');
      loader.setCrossOrigin('use-credentials');
      loader.load( url, (object) => {
          if(this.mesh){
            this.scene.remove(this.mesh);
          }
          const newColor = new THREE.Color(128, 128, 128);

          const newMaterial = new THREE.MeshStandardMaterial({
            color: newColor, // Красный цвет
            metalness: 0.8,
            roughness: 0.2
          });
          object.traverse((child) => {
            if (child instanceof THREE.Mesh) {
              console.log(child)
              // Присваиваем новый материал каждому мешу
              child.material = newMaterial;
            }
          });
          this.mesh = object;
          this.scene.add(this.mesh);
        },
      );
    }

    /**Кадровая анимация */
    public animate(): void {

      this.ngZone.runOutsideAngular(() => {
        if (document.readyState !== 'loading') {
          this.render();
        } else {
          window.addEventListener('DOMContentLoaded', () => {
            this.render();
          });
        }
        window.addEventListener('resize', () => {
          this.resize();
        });
      });
    }

    /**Отрисовка сцены */
    public render(): void {
      const deltaTime = this.clock.getDelta(); 
      const rotationSpeed = 0.5; // Например, 0.5 радиана в секунду (примерно 28 градусов/сек)
      this.frameId = requestAnimationFrame(() => {
        this.render();
      });
      if(this.mesh){
        this.mesh.rotation.x += rotationSpeed * deltaTime;
        this.mesh.rotation.z += rotationSpeed * deltaTime;
      }

      this.renderer?.render(this.scene, this.camera);
    }

    /**Изменение размера canvas */
    public resize(): void {
      const width = window.innerWidth > 1300 ? 1300 : window.innerWidth;
      const height = window.innerHeight > 966 ? 966 : window.innerHeight;

      //this.camera.aspect = width / height;
      //.camera.updateProjectionMatrix();
      this.renderer?.setSize(width / 2, height / 2);
    }
}