import { Component, CUSTOM_ELEMENTS_SCHEMA, ChangeDetectionStrategy } from '@angular/core';

@Component({
  template: `
   <ngt-mesh>
     <ngt-box-geometry />
   </ngt-mesh>
  `,
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  changeDetection: ChangeDetectionStrategy.OnPush,
  standalone: true,
})
export class SceneGraph {}