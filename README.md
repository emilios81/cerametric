# CeraMetric

**Análisis morfométrico de tiestos cerámicos desde fotografías, en el navegador.**

[![Versión](https://img.shields.io/badge/versi%C3%B3n-1.2-2C5F6F)](CHANGELOG.md)
[![Licencia](https://img.shields.io/badge/licencia-MIT-5BBFB0)](LICENSE)
[![Sin instalación](https://img.shields.io/badge/sin%20instalaci%C3%B3n-100%25%20navegador-8A9BA8)](#uso)

Desarrollada en el [LATDAA](https://latdaa.com.ar) — Laboratorio de Tecnologías Digitales Aplicadas a la Arqueología
Dr. Emilio A. Villafañez · Escuela de Arqueología · Universidad Nacional de Catamarca · Fundación de Historia Natural Félix de Azara · CONICET

### ▶ [Abrir CeraMetric](https://emilios81.github.io/cerametric/)

*Las imágenes no se suben a ningún servidor: todo el procesamiento ocurre en tu computadora.*

---

## ¿Qué es CeraMetric?

CeraMetric mide fragmentos cerámicos a partir de una fotografía con escala gráfica. Calibrás la escala con dos clics, la aplicación detecta los tiestos y devuelve área, largo, ancho, perímetro, color promedio y tres índices de forma, listos para exportar a Excel, CSV o JSON. El largo y el ancho son los lados de la caja rectangular más chica que contiene la pieza: lo mismo que se obtiene midiéndola con regla, sin que importe cómo esté girada en la foto.

Está pensada para reemplazar la medición manual con regla y calibre en el análisis de lotes cerámicos: en una sola foto se pueden medir decenas de tiestos con criterios uniformes y reproducibles.

## Uso

**Opción A — online:** entrá a **[emilios81.github.io/cerametric](https://emilios81.github.io/cerametric/)**. No requiere instalación ni registro.

**Opción B — offline (recomendada para trabajo de campo):**

1. Descargá el repositorio: botón verde **Code → Download ZIP**, o [descarga directa](https://github.com/emilios81/cerametric/archive/refs/heads/main.zip).
2. Descomprimí la carpeta.
3. Doble clic en **`CeraMetric.bat`** (Windows). También podés abrir `index.html` directamente con Chrome, Firefox o Edge.

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

### 4 · Leer las medidas sobre la imagen

Sobre cada tiesto se dibujan las **cotas** de las que salen sus medidas, con el mismo criterio que un plano: línea con marcas en los extremos, la letra y el valor.

El **color** dice qué dimensión es y el **trazo** con qué criterio se tomó:

| | Línea llena — método elegido | Línea punteada — el otro método |
|---|---|---|
| 🟠 **Ámbar** | `L` largo | `L caja` o `L cont` |
| 🔵 **Celeste** | `A` ancho | `A caja` o `A cont` |

Sirve para no confundir cuál número es cuál en piezas irregulares, y para ver de un vistazo cuánto se separan los dos criterios en cada tiesto (ver [Notas metodológicas](#notas-metodológicas)). Con el selector de abajo mostrás un par, el otro o los dos. Las cotas se apagan con la casilla **Ejes de medición sobre la imagen** y salen también en la imagen anotada que se exporta.

### 5 · Depurar y exportar

Cada tiesto de la lista de resultados tiene un ícono de papelera para borrarlo: usalo con la escala gráfica, las sombras o cualquier falso positivo que se haya colado.

Exportá en **Excel (.xlsx)**, **CSV**, **JSON** o como **imagen anotada** (la foto con los contornos y los IDs dibujados, para la ficha o la publicación).

El `.xlsx` trae **una hoja por método de medición** —*Por caja* y *Por contorno*—, cada una con la tabla completa y con el largo y el ancho de su criterio, más la hoja *Metadatos*. Primero va la del método elegido, que es la que se abre: si trabajás con un solo sistema de medidas, esa hoja ya es tu planilla, sin columnas de más que borrar. El CSV, que es un único archivo plano, sigue llevando los dos métodos en la misma tabla.

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
| **Largo** y **Ancho** (cm) | Según el **método** elegido, ver abajo |
| **Largo · Ancho caja** (cm) | Lados del rectángulo de área mínima que encierra la pieza (rotating calipers sobre el casco convexo) |
| **Largo · Ancho contorno** (cm) | Mayor distancia entre dos puntos del contorno (Feret máximo) y la travesía más larga perpendicular a ella |
| **Perímetro** (cm) | Contorno 8-conectado (vecindad de Moore) con corrección de Vossepoel–Smeulders |
| **Circularidad** | 4π·A / P² |
| **Elongación** | Largo / Ancho |
| **Solidez** | A / A del casco convexo |
| **Color** | Promedio RGB de todos los píxeles del tiesto, en hexadecimal |

### Notas metodológicas

**Dos métodos para el largo y el ancho.** El selector *Cómo se toman el largo y el ancho*, arriba de la lista de resultados, decide cuál de los dos manda. Los dos se calculan siempre y los dos se exportan —en el `.xlsx`, cada uno en su propia hoja—, y la exportación deja constancia de cuál usaste.

**Por caja.** Se encierra el tiesto en la **caja rectangular más chica que lo contenga**, probando todos los ángulos, y se miden los lados de esa caja. La caja se dibuja punteada alrededor de la pieza. En un objeto rectangular calza con la pieza y los lados son los reales; en un tiesto deforme, que no tiene lados claros, es la manera de decidir cuál es el largo.

> **Por qué a veces la cota se sale del tiesto.** Un fragmento irregular no llena su caja: la toca apenas en unos pocos puntos del borde, y entre esos puntos queda aire. La cota, que va por el medio y mide el lado completo, puede entonces pasar por fuera de la pieza en algún tramo. No es un error: está midiendo la caja. Con la caja dibujada se ve de dónde sale cada línea.

**Por contorno.** Se mide directamente entre puntos del borde, como con un calibre. El largo es la **mayor distancia entre dos puntos de la pieza**; el ancho, la **travesía más larga perpendicular** a esa. Las dos cotas apoyan sus puntas en el contorno, así que se ve exactamente por dónde pasan.

Ninguno de los dos es más correcto: responden a preguntas distintas. Medidos sobre las figuras de `ejemplo/imagen_de_prueba.png` y sobre un polígono irregular equidimensional:

| Figura | Largo · Ancho **caja** | Largo · Ancho **contorno** |
|---|---|---|
| Rectángulo 8.5 × 5.4 | **8.53 · 5.43** | 10.06 · 6.43 ⟵ *diagonal* |
| Círculo ⌀ 4 | 4.00 · 4.00 | 4.02 · 4.02 |
| Triángulo 6 × 4 | 5.93 · 3.98 | 5.96 · 3.97 |
| Barra fina 5 × 0.9 | 5.08 · 0.93 | 5.12 · 0.94 |
| Irregular equidimensional | 8.17 · 7.50 | **9.01** · 7.48 ⟵ *0.84 cm más* |

En un tiesto redondeado el largo por contorno suele dar **algo más** que el de la caja, porque la caja optimiza superficie y no longitud. En una pieza rectangular pasa al revés: el largo por contorno se va a la **diagonal**. Elegí un método y usalo para todo el lote.

> **¿Y la otra diagonal?** En un rectángulo las dos diagonales miden lo mismo, así que el largo por contorno ya es esa medida y no hay una segunda que informar. El ancho por contorno es la travesía más larga **perpendicular** a ella. En un **cuadrado** las dos diagonales sí son perpendiculares entre sí, y entonces el ancho por contorno da exactamente la otra diagonal: en uno de 2 × 2 cm, largo y ancho dan 2.83 los dos.

La **elongación** se calcula con el par del método elegido, así que también cambia al cambiarlo.

En la última fila el Feret máximo supera al largo por 0.84 cm. No es un error de ninguno de los dos: son dos preguntas distintas. El largo responde *cuánto mide la pieza*; el Feret máximo, *cuál es la mayor distancia entre dos de sus puntos*.

Los ejes dibujados sobre la imagen muestran de dónde sale cada número, y con el selector podés ver un par, el otro o los dos superpuestos.

**Perímetro.** Se traza el contorno del tiesto con vecindad de Moore (8-conectada) y se aplica la corrección de Vossepoel–Smeulders de tres parámetros: `0.980·(pasos rectos) + 1.406·(pasos diagonales) − 0.091·(esquinas)`. Compensa el efecto escalera de la rasterización, que sobreestima el perímetro de los bordes curvos.

**Color.** Es el promedio RGB de todos los píxeles del tiesto (en selección manual, de los interiores al polígono). Sirve para comparar dentro de un mismo lote fotografiado en las mismas condiciones; **no reemplaza a la carta Munsell** ni es comparable entre fotos con iluminación distinta.

**Recalibración.** Cada tiesto guarda sus medidas crudas en píxeles y los centímetros se derivan de la calibración vigente. Si cambiás la escala con tiestos ya medidos, las métricas se recalculan desde el original, sin acumular error: podés corregir la medida real las veces que haga falta.

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
- Los datos medidos con **v1.0 no son comparables** con los de v1.1 en adelante — ver [CHANGELOG.md](CHANGELOG.md). Si usaste v1.1 y corregiste la **medida real** de la escala *después* de medir, ese lote hay que volver a exportarlo con v1.2: había un error de redondeo que cuantizaba las métricas.

## Probar y verificar

La carpeta [`ejemplo/`](ejemplo/) trae una **imagen de prueba** con figuras de dimensiones exactas conocidas y una barra de escala de 5 cm. Sirve para recorrer el flujo de trabajo sin tener que fotografiar nada, y para comprobar que la aplicación mide bien: en [`ejemplo/README.md`](ejemplo/README.md) están los valores esperados de cada figura.

Con tus propias fotos, el control equivalente es incluir en la toma un objeto rectangular de dimensiones conocidas (una tarjeta de 8.5 × 5.4 cm sirve) y medirlo con la app.

El `Largo` y el `Ancho` tienen que coincidir con los reales dentro de un par de décimas de milímetro. Si no dan, revisá la calibración y la perpendicularidad de la cámara.

> Las columnas cruzadas, en cambio, van a dar otra cosa y está bien que así sea: en una tarjeta de 8.5 × 5.4 el `Feret máx` devuelve la **diagonal** (~10.1 cm) porque es la mayor distancia entre dos de sus puntos. No las uses para este control.

## Tecnologías

JavaScript puro sobre HTML5 Canvas, sin frameworks ni build. Un solo archivo (`index.html`) más [SheetJS](https://sheetjs.com/) (`xlsx.full.min.js`) para la exportación a Excel, incluido localmente. Tipografías Cormorant Garamond, DM Sans y DM Mono vía Google Fonts, con degradación a las del sistema si no hay conexión.

## Citación

> Villafañez, E.A. (2026). *CeraMetric v1.2: herramienta de análisis morfométrico de tiestos cerámicos*. LATDAA, Escuela de Arqueología, Universidad Nacional de Catamarca. https://github.com/emilios81/cerametric

El repositorio incluye un [CITATION.cff](CITATION.cff): GitHub genera la cita en BibTeX o APA desde el botón **Cite this repository**.

## Contribuir

Los reportes de error y las sugerencias van por [Issues](https://github.com/emilios81/cerametric/issues). Si reportás un problema de medición, incluí la foto (o una equivalente), el valor de px/cm de la calibración y lo que esperabas obtener.

## Licencia

[MIT](LICENSE) — uso, modificación y distribución libres, con atribución.
SheetJS se distribuye bajo su propia licencia; ver [THIRD-PARTY.md](THIRD-PARTY.md).

---

## English summary

**CeraMetric** is an offline-capable, browser-based tool for the morphometric analysis of ceramic sherds. From a single photograph containing a graphic scale, it measures area, length and width (sides of the minimum-area bounding rectangle, orientation-independent), the maximum Feret diameter and the longest chord perpendicular to it as a secondary pair showing how far the piece reaches beyond that box, perimeter (Moore-neighbourhood contour tracing with the three-parameter Vossepoel–Smeulders correction), circularity, elongation, solidity and mean RGB colour. Sherds can be segmented automatically (Gaussian blur, morphological closing, hole filling, Otsu-assisted thresholding) or outlined by hand. Measurement axes are drawn over each sherd as dimension lines — amber for length, blue for width, solid for the box sides and dashed for the crossing pair — so it is always clear which segment each figure comes from. Results export to XLSX, CSV, JSON and as an annotated image.

No installation, no server, no data upload — all processing happens in the browser. **[Launch the app](https://emilios81.github.io/cerametric/)** or download the repository and open `index.html` locally (keep `xlsx.full.min.js` in the same folder).

Developed at LATDAA (Laboratory of Digital Technologies Applied to Archaeology), School of Archaeology, National University of Catamarca, Argentina. Released under the MIT License; please cite as indicated above.

---

*LATDAA · Escuela de Arqueología · UNCa · CONICET · Fundación de Historia Natural Félix de Azara*
