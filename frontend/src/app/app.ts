import { Component } from "@angular/core";
import { RouterOutlet } from "@angular/router";

@Component({
    selector: "app",
    standalone: true,
    templateUrl: './app.html',
    styleUrl: './app.css',
  imports: [RouterOutlet],
})
export class App { 
    name= "";
}