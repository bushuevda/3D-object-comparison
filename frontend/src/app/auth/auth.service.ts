import { HttpClient} from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router} from "@angular/router";
import { of, map, catchError} from 'rxjs';

@Injectable({providedIn: 'root' })
export class AuthService {
    isLoggedIn: boolean = false;
    constructor(private http: HttpClient, private router: Router) {}
    
    loginIn(email: string, password: string){
        const body = {email: email, password: password};
        
        return this.http.post<{message: string}>("http://localhost:8000/auth", body).pipe(
            map(response => {
              if(response.message){
                localStorage.setItem('JWT_Token', response.message);
                this.isLoggedIn = true;
              } else {
                this.isLoggedIn = false;
              }
              return true;
            }),
            catchError(error => {
              console.log(error);
              this.isLoggedIn = false;
              return of(false);
            })
          ).subscribe(
            {
                next:() => {
                    this.router.navigateByUrl("/menu");
                },
                error: (err) => console.log(err, "subscr")
            }
          );
    }

    isAuthenticated(): boolean{
        return this.isLoggedIn;
    }
    
    loginOut(){
        localStorage.removeItem("JWT_Token");
        this.isLoggedIn = false;
        this.router.navigate(["/"])
    }


}