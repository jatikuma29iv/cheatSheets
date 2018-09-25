# Angular 5

## 6 Best Practices & Pro Tips when using Angular CLI

[6 Best Practices & Pro Tips when using Angular CLI](https://medium.com/@tomastrajan/6-best-practices-pro-tips-for-angular-cli-better-developer-experience-7b328bc9db81)

## The complete guide to Angular Material Themes

[The complete guide to Angular Material Themes](https://medium.com/@tomastrajan/the-complete-guide-to-angular-material-themes-4d165a9d24d1)

## How To Style Angular Application Loading With Angular CLI Like a Boss

Loader

[How To Style Angular Application Loading With Angular CLI Like a Boss](https://medium.com/@tomastrajan/how-to-style-angular-application-loading-with-angular-cli-like-a-boss-cdd4f5358554)

## How to put Hook into Angular’s Initialization Process

https://hackernoon.com/hook-into-angular-initialization-process-add41a6b7e

eg. configure services/components based on settings read from server

_**This article originally appeared on dormoshe.io**_

Sometimes you need to hook into internal processes. Sometimes you need to run your code before the application is being loaded. Sometimes you need to configure parts of the application before the page is being rendered. Sometimes you want to suspend the initialization until some restriction is being done. In Angular v4 you can do this with the __APP_INITIALIZER__ token.

## Custom Modules

- Create

```bash
$ ng g m MyModule
```

- add component to custom module

```bash
$ ng g c MyModule/MyComponent --module=MyModule
```

- export `MyComponent` from `MyModule`

```typescript
import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CustomerComponent } from './customer.component';
import { NewItemDirective } from './new-item.directive';
import { OrdersPipe } from './orders.pipe';

@NgModule({
   imports:      [ CommonModule ],
    declarations: [ CustomerComponent, NewItemDirective, OrdersPipe ],
     exports:      [ CustomerComponent, NewItemDirective, OrdersPipe,
                      CommonModule, FormsModule ]
})
export class SharedModule { }
```

Note the following:

  * It imports the `CommonModule` because the module's component needs common directives.
  * It declares and exports the utility pipe, directive, and component classes.
  * It re-exports the `CommonModule` and `FormsModule`.

By re-exporting `CommonModule` and `FormsModule`, any other module that imports this `SharedModule`, gets access to directives like `NgIf` and `NgFor` from `CommonModule` and can bind to component properties with `[(ngModel)]`, a directive in the `FormsModule`.

ref: _[Sharing NgModules](https://angular.io/guide/sharing-ngmodules)_

- Configure module for refrence

Edit `tsconfig.json`

```json
{
  "compilerOptions": {
    "paths": {
      "@MyModule/*": ["./app/MyComponent/*"]
    }
  }
}
```
