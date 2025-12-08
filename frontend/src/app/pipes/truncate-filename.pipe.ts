import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'truncateFilename'
})
export class TruncateFilenamePipe implements PipeTransform {

  transform(value: string, limit: number = 5, suffix: string = '  ...  '): string {
    if (!value) {
      return '';
    }
    if (value.length <= limit) {
      return value;
    }
    let index = value.lastIndexOf('.');
    return value.substring(0, limit) + suffix + value.substring(index);
  }
}