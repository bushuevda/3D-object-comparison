import { NgModule } from '@angular/core';
import { provideRouter, Routes, RouterModule } from "@angular/router";
import {AuthComponent} from "./auth/auth"
import { provideHttpClient } from "@angular/common/http";
import { AuthGuard }   from "./app.guard";
import { AuthService } from "./auth/auth.service";
import {MenuComponent} from "./menu/menu"
import { providePrimeNG } from 'primeng/config';
import {config_primeng} from "./app.primeng.config"
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { ApplicationConfig, provideBrowserGlobalErrorListeners, provideZoneChangeDetection } from '@angular/core';

import { appRoutes } from './app.route';

export const appConfig: ApplicationConfig = {
  providers: [
    provideAnimationsAsync(),
    provideBrowserGlobalErrorListeners(),
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(appRoutes),
     providePrimeNG({
      theme:{
        preset: config_primeng,
        options:{
          darkModeSelector: false || 'none'
        }
      }
    }),
    provideHttpClient(), 
    AuthService
  ]
};



