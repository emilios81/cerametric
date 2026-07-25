# Componentes de terceros

CeraMetric se distribuye bajo licencia MIT (ver [LICENSE](LICENSE)). El repositorio
incluye además el siguiente componente, con su propia licencia:

## SheetJS (`xlsx.full.min.js`)

- **Proyecto:** SheetJS Community Edition — https://sheetjs.com
- **Versión incluida:** 0.18.5
- **Copyright:** (C) 2013-presente SheetJS LLC
- **Licencia:** Apache License 2.0 — https://www.apache.org/licenses/LICENSE-2.0
- **Uso en CeraMetric:** generación de los archivos `.xlsx` en la exportación a Excel.

El archivo se incluye en el repositorio, sin modificaciones, para que la aplicación
funcione sin conexión a internet. Si preferís no distribuirlo, la aplicación sigue
funcionando: solo se desactiva la exportación a Excel y quedan disponibles CSV y JSON.

## Tipografías

Cormorant Garamond, DM Sans y DM Mono se cargan desde Google Fonts bajo
[SIL Open Font License 1.1](https://openfontlicense.org/). No están incluidas en el
repositorio; sin conexión, la aplicación usa las tipografías del sistema.
