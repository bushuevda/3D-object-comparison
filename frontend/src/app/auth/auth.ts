import { Component } from '@angular/core';
import {AuthService} from './auth.service'

import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ButtonModule } from 'primeng/button'; 
import { FloatLabelModule } from 'primeng/floatlabel';

class User{
  constructor(public email: string, public password: string){}
}

@Component({
  standalone: true,
  selector: 'auth',
  templateUrl: './auth.html',
  imports: [CommonModule, FormsModule, ButtonModule, FloatLabelModule],
  styleUrl: './auth.css',
  styles: `
  .alert{ color:red}
  div {margin: 5px 0;}
`,
})
export class AuthComponent {
  user: User = new User("", "")
  sucess: boolean = true;  
  interval: any;
  
  constructor(private authService: AuthService){}

  onSubmit(){
      this.authService.loginIn(this.user.email, this.user.password)
      setTimeout(() => {
          if(!this.authService.isAuthenticated())
            this.sucess = false;
          else
            this.sucess = true;
      }, 1100)

  }
   
}
