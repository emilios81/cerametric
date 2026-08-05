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

CeraMetric mide fragmentos cerámicos a partir de una fotografía con escala gráfica. Calibrás la escala con dos clics, la aplicación detecta los tiestos y devuelve área, largo, ancho, perímetro, color promedio y tres índices de forma, listos para exportar a Excel, CSV o JSON. El largo y el ancho son los que se toman con calibre: la mayor distancia entre dos puntos de la pieza y la menor abertura que todavía la abraza.

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

| | Línea llena — calibre | Línea punteada — rectángulo mínimo |
|---|---|---|
| 🟠 **Ámbar** | `L` largo | `Lr` largo rect. |
| 🔵 **Celeste** | `A` ancho | `Ar` ancho rect. |

Sirve para no confundir cuál número es cuál en piezas irregulares, y para ver de un vistazo cuánto se separan los dos criterios en cada tiesto (ver [Notas metodológicas](#notas-metodológicas)). Con el selector de abajo mostrás un par, el otro o los dos. Las cotas se apagan con la casilla **Ejes de medición sobre la imagen** y salen también en la imagen anotada que se exporta.

### 5 · Depurar y exportar

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
| **Largo** (cm) | Mayor distancia entre dos puntos de la pieza — el calibre abierto todo lo que da (diámetro de Feret máximo) |
| **Ancho** (cm) | Menor abertura con la que el calibre todavía abraza la pieza, probando todas las orientaciones (Feret mínimo) |
| **Largo rect.** y **Ancho rect.** (cm) | Lados del rectángulo de área mínima que encierra la pieza (rotating calipers sobre el casco convexo) |
| **Perímetro** (cm) | Contorno 8-conectado (vecindad de Moore) con corrección de Vossepoel–Smeulders |
| **Circularidad** | 4π·A / P² |
| **Elongación** | Largo / Ancho |
| **Solidez** | A / A del casco convexo |
| **Color** | Promedio RGB de todos los píxeles del tiesto, en hexadecimal |

### Notas metodológicas

**Largo y ancho: son las medidas del calibre.** El largo es la **mayor distancia entre dos puntos de la pieza**: el calibre abierto todo lo que da, apoyado en los dos extremos. El ancho es la **menor abertura con la que el calibre todavía la abraza**, girándolo hasta encontrar la posición en que entra más justa. Es la medición que se hace en gabinete, y ninguna de las dos depende de cómo esté girado el tiesto en la fotografía.

Sus dos direcciones **no son perpendiculares entre sí**: son mediciones independientes, igual que cuando medís a mano.

La aplicación informa además un segundo par, **Largo rect. · Ancho rect.**, que son los lados del rectángulo de área mínima que encierra la pieza. El algoritmo prueba todas las orientaciones y se queda con aquella cuyo rectángulo tiene **el área más chica** — criterio que optimiza superficie, no longitud. Sirve para dos cosas:

- En piezas **rectangulares** es el par correcto. En un rectángulo, la mayor distancia entre dos puntos es la diagonal, así que ahí el *Largo* de calibre da la diagonal y no el lado. Para verificar la medición con una tarjeta de dimensiones conocidas hay que mirar *Largo rect. · Ancho rect.*
- La diferencia entre los dos pares es un dato en sí mismo: cuánto se aparta la pieza de una forma rectangular.

Medidos sobre `ejemplo/imagen_de_prueba.png`:

| Figura | Largo | Ancho | Largo rect. | Ancho rect. |
|---|---|---|---|---|
| Rectángulo 8.5 × 5.4 | 10.06 ⟵ *diagonal* | 5.43 | **8.53** | **5.43** |
| Círculo ⌀ 4 | 4.02 | 4.00 | 4.00 | 4.00 |
| Triángulo 6 × 4 | 5.96 | 3.97 | 5.93 | 3.98 |
| Barra fina 5 × 0.9 | 5.12 | 0.93 | 5.08 | 0.93 |
| Irregular equidimensional | **9.01** | 7.37 | 8.17 ⟵ *0.84 cm menos* | 7.50 |

Fijate en la última fila, que es el caso de un tiesto real poco alargado: el rectángulo mínimo gira a una orientación donde su lado mayor queda **por debajo del largo real de la pieza**. Por eso el largo se informa con el criterio del calibre. Se cumple siempre que `Largo ≥ Largo rect.` y `Ancho ≤ Ancho rect.`

Los ejes dibujados sobre la imagen muestran de dónde sale cada número, y con el selector podés superponer el rectángulo mínimo para ver cuánto se separan en cada pieza.

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
- **El `Largo` cambió de definición en v1.2** (antes era el lado del rectángulo mínimo, ahora el del calibre). Los lotes medidos con v1.0 o v1.1 no son comparables columna a columna con los nuevos — ver [CHANGELOG.md](CHANGELOG.md). El `Largo` viejo sigue disponible como `Largo rect.` Si además usaste v1.1 y corregiste la **medida real** de la escala *después* de medir, ese lote hay que volver a exportarlo: había un error de redondeo que cuantizaba las métricas.

## Probar y verificar

La carpeta [`ejemplo/`](ejemplo/) trae una **imagen de prueba** con figuras de dimensiones exactas conocidas y una barra de escala de 5 cm. Sirve para recorrer el flujo de trabajo sin tener que fotografiar nada, y para comprobar que la aplicación mide bien: en [`ejemplo/README.md`](ejemplo/README.md) están los valores esperados de cada figura.

Con tus propias fotos, el control equivalente es incluir en la toma un objeto rectangular de dimensiones conocidas (una tarjeta de 8.5 × 5.4 cm sirve) y medirlo con la app.

> **Ojo con qué columna mirás en ese control.** Como el objeto es un rectángulo, su mayor distancia entre dos puntos es la **diagonal**: el `Largo` va a dar ~10.1 cm, que es correcto pero no es el lado. Para verificar la calibración compará contra **`Largo rect.` y `Ancho rect.`**, que tienen que coincidir con los 8.5 × 5.4 reales dentro de un par de décimas de milímetro. El `Ancho` de calibre también da bien (5.4), porque en un rectángulo la menor abertura del calibre es el lado corto.

Si `Largo rect.` y `Ancho rect.` no dan, revisá la calibración y la perpendicularidad de la cámara.

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

**CeraMetric** is an offline-capable, browser-based tool for the morphometric analysis of ceramic sherds. From a single photograph containing a graphic scale, it measures area, length and width as taken with callipers (maximum and minimum Feret diameters, orientation-independent), the sides of the minimum-area bounding rectangle as a secondary pair, perimeter (Moore-neighbourhood contour tracing with the three-parameter Vossepoel–Smeulders correction), circularity, elongation, solidity and mean RGB colour. Sherds can be segmented automatically (Gaussian blur, morphological closing, hole filling, Otsu-assisted thresholding) or outlined by hand. Measurement axes are drawn over each sherd as dimension lines — amber for length, blue for width, solid for the calliper pair and dashed for the rectangle — so it is always clear which segment each figure comes from. Results export to XLSX, CSV, JSON and as an annotated image.

No installation, no server, no data upload — all processing happens in the browser. **[Launch the app](https://emilios81.github.io/cerametric/)** or download the repository and open `index.html` locally (keep `xlsx.full.min.js` in the same folder).

Developed at LATDAA (Laboratory of Digital Technologies Applied to Archaeology), School of Archaeology, National University of Catamarca, Argentina. Released under the MIT License; please cite as indicated above.

---

*LATDAA · Escuela de Arqueología · UNCa · CONICET · Fundación de Historia Natural Félix de Azara*
