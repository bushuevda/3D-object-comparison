import { Injectable, inject } from '@angular/core';
import { CanActivateFn, CanActivate, Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { AuthService } from './auth/auth.service';




export const AuthGuards : CanActivateFn = () => {

  let isauthenticated = inject(AuthService).isAuthenticated()
  let router = inject(Router)
      if (isauthenticated) {
        console.log("AUTH TRUE")
       return true;
     } else {        
      console.log("NAUTH TRUE")
       router.navigate(['/']);
       return false;
     }
 }
 


@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(private router: Router, private auth_service: AuthService) {}
  canActivate( route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean {
    if (this.auth_service.isAuthenticated()) {
      console.log("AUTH TRUE")
     return true;
   } else {        
    console.log("NAUTH TRUE")
     this.router.navigate(['/']);
     return false;
   }
  }


}