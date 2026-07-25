# CeraMetric

**Análisis morfométrico de tiestos cerámicos desde fotografías, en el navegador.**

[![Versión](https://img.shields.io/badge/versi%C3%B3n-1.1-2C5F6F)](CHANGELOG.md)
[![Licencia](https://img.shields.io/badge/licencia-MIT-5BBFB0)](LICENSE)
[![Sin instalación](https://img.shields.io/badge/sin%20instalaci%C3%B3n-100%25%20navegador-8A9BA8)](#uso)

Desarrollada en el [LATDAA](https://latdaa.com.ar) — Laboratorio de Tecnologías Digitales Aplicadas a la Arqueología
Dr. Emilio A. Villafañez · Escuela de Arqueología · Universidad Nacional de Catamarca · Fundación de Historia Natural Félix de Azara · CONICET

### ▶ [Abrir CeraMetric](https://emilios81.github.io/cerametric/)

*Las imágenes no se suben a ningún servidor: todo el procesamiento ocurre en tu computadora.*

---

## ¿Qué es CeraMetric?

CeraMetric mide fragmentos cerámicos a partir de una fotografía con escala gráfica. Calibrás la escala con dos clics, la aplicación detecta los tiestos y devuelve área, largo, ancho, perímetro, diámetro de Feret, color promedio y tres índices de forma, listos para exportar a Excel, CSV o JSON.

Está pensada para reemplazar la medición manual con regla y calibre en el análisis de lotes cerámicos: en una sola foto se pueden medir decenas de tiestos con criterios uniformes y reproducibles.

## Uso

**Opción A — online:** entrá a **[emilios81.github.io/cerametric](https://emilios81.github.io/cerametric/)**. No requiere instalación ni registro.

**Opción B — offline (recomendada para trabajo de campo):**

1. Descargá el repositorio: botón verde **Code → Download ZIP**, o [descarga directa](https://github.com/emilios81/cerametric/archive/refs/heads/main.zip).
2. Descomprimí la carpeta.
3. Abrí `index.html` con doble clic (Chrome, Firefox o Edge).

> **Importante:** `index.html` y `xlsx.full.min.js` tienen que quedar **en la misma carpeta**. Si separás los archivos, la exportación a Excel deja de funcionar (CSV y JSON siguen andando). Sin conexión a internet la app funciona igual; solo cambian las tipografías por las del sistema.

## Guía rápida

> ¿Primera vez? Empezá con [`ejemplo/imagen_de_prueba.png`](ejemplo/): trae una escala de 5 cm y figuras de medidas conocidas, así podés seguir estos pasos y comparar con los valores esperados.

### 1 · Cargar la imagen

JPG o PNG con una escala gráfica visible. Ingresá el **código de registro** del lote (ej. `AMB-24-U3-T12`): se usa como prefijo de los IDs de cada tiesto (`AMB-24-U3-T12-01`, `-02`, …).

Si la foto tiene mucho margen sobrante, usá la herramienta **Recortar** (`R`), arrastrá el área y `Enter`. La calibración se conserva al recortar.

### 2 · Calibrar la escala

Con la herramienta **Calibrar** (`C`), hacé clic en los dos extremos de la escala gráfica. Mantené `Ctrl` para forzar una línea perfectamente horizontal o vertical.

Escribí en **Medida real (cm)** la distancia entre esos dos puntos. Es un campo vivo: si lo cambiás después de medir, la escala y todas las métricas ya calculadas se reescalan solas. Para volver a marcar los puntos, usá **Recalibrar**.

La barra de estado muestra los px/cm resultantes. Anotalos: es el dato que permite verificar la medición después.

### 3 · Detectar los tiestos

Dos caminos, combinables en la misma imagen:

**Detección automática.** Ajustá los parámetros y apretá **Detectar**:

| Parámetro | Para qué sirve |
|---|---|
| **Desenfoque gaussiano** | Suaviza el ruido de la foto antes de umbralizar. Subilo si el fondo tiene textura o grano. |
| **Cierre morfológico** | Cierra huecos y grietas finas del contorno. Subilo si un tiesto sale partido en dos. |
| **Umbral de binarización** | Separa tiesto de fondo. Usá **Aplicar** en la sugerencia de Otsu como punto de partida. |
| **Tipo de fondo** | Claro (blanco/beige) u oscuro, según la tela o cartulina que usaste. |
| **Área mínima (cm²)** | Descarta manchas chicas: sombras, motas, ruido. |

Apretá **Prevista** antes de detectar: pinta en verde lo que la app considera tiesto. Ajustá hasta que cada pieza quede sólida y separada de las vecinas.

**Selección manual.** Herramienta **Lápiz** (`M`): un clic por vértice, doble clic (o clic sobre el primer punto) para cerrar el polígono. Útil para tiestos que se tocan entre sí, superficies con reflejo o piezas sobre fondo complicado.

### 4 · Depurar y exportar

Cada tiesto de la lista de resultados tiene un ícono de papelera para borrarlo: usalo con la escala gráfica, las sombras o cualquier falso positivo que se haya colado.

Exportá en **Excel (.xlsx)**, **CSV**, **JSON** o como **imagen anotada** (la foto con los contornos y los IDs dibujados, para la ficha o la publicación).

### Atajos de teclado

| Tecla | Función |
|---|---|
| `H` | Mover |
| `C` | Calibrar |
| `M` | Selección manual |
| `R` | Recortar |
| `+` / `-` | Zoom |
| `Ctrl` | Fijar línea horizontal/vertical (durante la calibración) |
| `Enter` | Confirmar recorte |
| `Esc` | Cancelar / volver a mover |

## Métricas

| Métrica | Definición |
|---|---|
| **Área** (cm²) | Conteo de píxeles del tiesto / px·cm⁻² |
| **Largo** y **Ancho** (cm) | Lados del rectángulo de área mínima que encierra la pieza (rotating calipers sobre el casco convexo) |
| **Feret máximo** (cm) | Distancia máxima entre dos puntos del contorno |
| **Perímetro** (cm) | Contorno 8-conectado (vecindad de Moore) con corrección de Vossepoel–Smeulders |
| **Circularidad** | 4π·A / P² |
| **Elongación** | Largo / Ancho |
| **Solidez** | A / A del casco convexo |
| **Color** | Promedio RGB de todos los píxeles del tiesto, en hexadecimal |

### Notas metodológicas

**Largo y ancho.** Son los lados del rectángulo de área mínima, es decir lo mismo que se obtiene midiendo la pieza con regla, y no dependen de cómo esté orientada en la fotografía. No son el diámetro de Feret: en una pieza cuadrangular el Feret máximo devuelve la diagonal, no el lado. Por eso el Feret se informa en una columna aparte.

**Perímetro.** Se traza el contorno del tiesto con vecindad de Moore (8-conectada) y se aplica la corrección de Vossepoel–Smeulders de tres parámetros: `0.980·(pasos rectos) + 1.406·(pasos diagonales) − 0.091·(esquinas)`. Compensa el efecto escalera de la rasterización, que sobreestima el perímetro de los bordes curvos.

**Color.** Es el promedio RGB de todos los píxeles del tiesto (en selección manual, de los interiores al polígono). Sirve para comparar dentro de un mismo lote fotografiado en las mismas condiciones; **no reemplaza a la carta Munsell** ni es comparable entre fotos con iluminación distinta.

**Recalibración.** Si cambiás la escala con tiestos ya medidos, las métricas se reescalan automáticamente a la nueva calibración.

## Cómo fotografiar

Casi todos los problemas de medición vienen de la foto, no del software:

- **Cámara perpendicular** al plano de los tiestos. Una foto en ángulo introduce error de perspectiva que la aplicación no corrige.
- **Escala gráfica en el mismo plano focal** que los tiestos, no debajo ni sobre un apoyo más alto.
- **Fondo neutro y contrastante**: cartulina blanca para cerámicas oscuras, negra para las claras.
- **Iluminación difusa y pareja**, sin sombras duras ni reflejos especulares sobre engobes o vidriados.
- **Tiestos separados** entre sí: si se tocan, la detección automática los une en una sola pieza (o usá selección manual).
- Una escala larga se calibra con menos error relativo que una corta.

## Limitaciones

- Mide **proyecciones en 2D**: no calcula espesor, curvatura ni volumen.
- **No corrige la perspectiva.** La precisión depende de que la cámara esté perpendicular.
- La detección automática **no separa tiestos en contacto**; para esos casos está la selección manual.
- El color es **relativo a las condiciones de captura**, no un valor colorimétrico absoluto.
- Los datos medidos con **v1.0 no son comparables** con los de v1.1 — ver [CHANGELOG.md](CHANGELOG.md).

## Probar y verificar

La carpeta [`ejemplo/`](ejemplo/) trae una **imagen de prueba** con figuras de dimensiones exactas conocidas y una barra de escala de 5 cm. Sirve para recorrer el flujo de trabajo sin tener que fotografiar nada, y para comprobar que la aplicación mide bien: en [`ejemplo/README.md`](ejemplo/README.md) están los valores esperados de cada figura.

Con tus propias fotos, el control equivalente es incluir en la toma un objeto rectangular de dimensiones conocidas (una tarjeta de 8.5 × 5.4 cm sirve) y medirlo con la app. El largo y el ancho tienen que coincidir con los reales dentro de un par de décimas de milímetro; el Feret máximo, en cambio, va a devolver la diagonal (~10.1 cm en ese ejemplo). Si el largo y el ancho no dan, revisá la calibración y la perpendicularidad de la cámara.

## Tecnologías

JavaScript puro sobre HTML5 Canvas, sin frameworks ni build. Un solo archivo (`index.html`) más [SheetJS](https://sheetjs.com/) (`xlsx.full.min.js`) para la exportación a Excel, incluido localmente. Tipografías Cormorant Garamond, DM Sans y DM Mono vía Google Fonts, con degradación a las del sistema si no hay conexión.

## Citación

> Villafañez, E.A. (2026). *CeraMetric v1.1: herramienta de análisis morfométrico de tiestos cerámicos*. LATDAA, Escuela de Arqueología, Universidad Nacional de Catamarca. https://github.com/emilios81/cerametric

El repositorio incluye un [CITATION.cff](CITATION.cff): GitHub genera la cita en BibTeX o APA desde el botón **Cite this repository**.

## Contribuir

Los reportes de error y las sugerencias van por [Issues](https://github.com/emilios81/cerametric/issues). Si reportás un problema de medición, incluí la foto (o una equivalente), el valor de px/cm de la calibración y lo que esperabas obtener.

## Licencia

[MIT](LICENSE) — uso, modificación y distribución libres, con atribución.
SheetJS se distribuye bajo su propia licencia; ver [THIRD-PARTY.md](THIRD-PARTY.md).

---

## English summary

**CeraMetric** is an offline-capable, browser-based tool for the morphometric analysis of ceramic sherds. From a single photograph containing a graphic scale, it measures area, length and width (sides of the minimum-area bounding rectangle, orientation-independent), maximum Feret diameter, perimeter (Moore-neighbourhood contour tracing with the three-parameter Vossepoel–Smeulders correction), circularity, elongation, solidity and mean RGB colour. Sherds can be segmented automatically (Gaussian blur, morphological closing, hole filling, Otsu-assisted thresholding) or outlined by hand. Results export to XLSX, CSV, JSON and as an annotated image.

No installation, no server, no data upload — all processing happens in the browser. **[Launch the app](https://emilios81.github.io/cerametric/)** or download the repository and open `index.html` locally (keep `xlsx.full.min.js` in the same folder).

Developed at LATDAA (Laboratory of Digital Technologies Applied to Archaeology), School of Archaeology, National University of Catamarca, Argentina. Released under the MIT License; please cite as indicated above.

---

*LATDAA · Escuela de Arqueología · UNCa · CONICET · Fundación de Historia Natural Félix de Azara*
