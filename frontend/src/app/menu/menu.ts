import { Component, OnInit } from '@angular/core';
import { Router} from "@angular/router";
import { AuthService } from '../auth/auth.service';
import { MenuItem } from 'primeng/api';

import { CommonModule } from '@angular/common';

import { ToolbarModule } from 'primeng/toolbar';
import { ButtonModule } from 'primeng/button';
import { RouterOutlet, RouterLink, RouterLinkActive} from "@angular/router";


@Component({
  standalone: true,
  selector: 'menu',
  templateUrl: './menu.html',
  styleUrl: './menu.css',
  imports: [ToolbarModule, ButtonModule, CommonModule, RouterOutlet, RouterLink ]
})
export class MenuComponent implements OnInit {

  items: MenuItem[] | undefined;

  constructor(private router: Router, private authService: AuthService){}
  onSubmitFiles(){
    this.router.navigate(["/files"])
  }
  onSubmitLogout(){
    this.authService.loginOut()
  }


  ngOnInit() {
      this.items = [
          {
              label: 'Home',
              icon: 'pi pi-home'
          },
          {
              label: 'Справочные данные',
              icon: 'pi pi-database'
          },
          {
              label: 'Обучение модели НС',
              icon: 'pi pi-microchip-ai'
          },
          {
              label: 'Каталоги',
              icon: 'pi pi-folder'
          },
          {
              label: 'Загрузка файлов',
              icon: 'pi pi-file-plus',
              routerLink:"/files"
          },
          {
              label: 'Сравнение характеристик ГО',
              icon: 'pi pi-equals'
          },
          {
              label: 'Выйти',
              icon: 'pi pi-sign-out'
          }
      ]
  }


}