import { provideRouter, Routes, RouterModule } from "@angular/router";
import {AuthComponent} from "./auth/auth"
import { menuRoutes } from "./menu/menu.route";
import { MenuComponent } from "./menu/menu";
export const appRoutes: Routes =[
    { 
      path: "", component: AuthComponent, pathMatch: "full"
    },
    { 
      path: "menu", component: MenuComponent,  children: menuRoutes, //canActivate: [AuthGuard]
    },
];

