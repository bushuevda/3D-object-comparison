import { Routes } from "@angular/router";
import { MenuComponent } from "./menu";
import { FilesComponent } from "../files/files";
import { DirectoryComponent } from "../directory/directory";
import { GuideComponent } from "../guide/guide";
import { AnalyticalComponent } from "../analytical/analytical";
import { PerceptronComponent } from "../perceptron/perceptron";

export const menuRoutes: Routes =[
    {
        path: "files", component: FilesComponent, pathMatch: "prefix" //canActivate: [AuthGuard]
    },
    {
        path: "directory", component: DirectoryComponent, //canActivate: [AuthGuard]
    },
    {
        path: "guide", component: GuideComponent, //canActivate: [AuthGuard]
    },
    {
        path: "analytical", component: AnalyticalComponent, //canActivate: [AuthGuard]
    },
    {
        path: "perceptron", component: PerceptronComponent, //canActivate: [AuthGuard]
    },
];