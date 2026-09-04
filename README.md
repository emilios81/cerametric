# CeraMetric

**Análisis morfométrico de tiestos cerámicos desde fotografías, en el navegador.**

[![Versión](https://img.shields.io/badge/versi%C3%B3n-1.3-2C5F6F)](CHANGELOG.md)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22312909.svg)](https://doi.org/10.5281/zenodo.22312909)
[![Licencia](https://img.shields.io/badge/licencia-MIT-5BBFB0)](LICENSE)
[![Sin instalación](https://img.shields.io/badge/sin%20instalaci%C3%B3n-100%25%20navegador-8A9BA8)](#uso)

Desarrollada en el [LATDAA](https://latdaa.com.ar) — Laboratorio de Tecnologías Digitales Aplicadas a la Arqueología
Dr. Emilio A. Villafañez · Escuela de Arqueología · Universidad Nacional de Catamarca · Fundación de Historia Natural Félix de Azara · CONICET

### ▶ [Abrir CeraMetric](https://emilios81.github.io/cerametric/)

*Las imágenes no se suben a ningún servidor: todo el procesamiento ocurre en tu computadora.*

---

## ¿Qué es CeraMetric?

CeraMetric mide fragmentos cerámicos a partir de una fotografía con escala gráfica. Calibrás la escala con dos clics, la aplicación detecta los tiestos y devuelve **área, perímetro, largo y ancho**, listos para exportar a Excel, CSV o JSON. El largo y el ancho son **cuerdas de la propia pieza**: el eje sale del lado largo de la caja rectangular más chica que la contiene —así que no importa cómo esté girada en la foto—, el largo es la cuerda más larga en esa dirección y el ancho, la perpendicular por su punto medio, con las cuatro puntas apoyadas en el contorno. La interfaz está en español e inglés.

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

JPG o PNG con una escala gráfica visible. Los tiestos detectados se identifican como `T-01`, `T-02`… en orden de lectura; el lote se identifica por el nombre con que guardes la exportación.

Si la foto tiene mucho margen sobrante, usá la herramienta **Recortar** (`R`), arrastrá el área y `Enter`. La calibración se conserva al recortar.

### 2 · Marcar y calibrar la escala

**Primero, marcá la escala.** Con **Marcar la escala** (`X`), arrastrá un rectángulo que la encuadre. La detección automática va a ignorar todo lo que quede adentro: una escala con colores, números o recuadros se cuela si no como cuatro o cinco tiestos falsos, uno por cada mancha interna, y hay que borrarlos de a uno. Encuadrarla lleva un arrastre y resuelve el problema de entrada.

Al marcarla, la aplicación pasa sola a **Calibrar**, que es el paso siguiente. La zona **no toca la calibración**: los dos clics de la escala se hacen adentro, igual que siempre. Podés marcar más de una zona —una etiqueta, una moneda, la mano que sostiene la pieza— y cada una lleva una **×** en su esquina para quitarla. Un tiesto que apenas roce el borde de la zona se conserva: solo se descarta lo que queda mayormente adentro. Las zonas usadas quedan anotadas en el JSON y en la hoja *Metadatos* del Excel.

**Después, calibrá.** Con la herramienta **Calibrar** (`C`), hacé clic en los dos extremos de la escala gráfica. Mantené `Ctrl` para forzar una línea perfectamente horizontal o vertical.

Escribí en **Medida real (cm)** la distancia entre esos dos puntos. Es un campo vivo: si lo cambiás después de medir, la escala y todas las métricas ya calculadas se reescalan solas. Para volver a marcar los puntos, usá **Recalibrar**.

La barra de estado muestra los px/cm resultantes. Anotalos: es el dato que permite verificar la medición después.

### 3 · Detectar los tiestos

Dos caminos, combinables en la misma imagen:

> **Cómo se numeran.** Los tiestos detectados se numeran **en orden de lectura**: por hileras de arriba hacia abajo y, dentro de cada hilera, de izquierda a derecha. La secuencia del `.xlsx` sigue a la fotografía, así que se puede ir tiesto por tiesto sin buscarlos. Los trazados a mano conservan el ID que les pusiste y van después, en el orden en que los trazaste.

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

El **color** dice qué dimensión es y el **trazo** de dónde salió el número:

| | Línea llena | Línea punteada |
|---|---|---|
| 🟠 **Ámbar** | `L` largo — la medida que va a la ficha | `L calc` — la calculada, solo si moviste el largo a mano |
| 🔵 **Celeste** | `A` ancho — la medida que va a la ficha | `A calc` — la calculada, solo si moviste el ancho a mano |

Las cuatro puntas de las cotas apoyan en el contorno de la cerámica, así que se ve exactamente por dónde pasa cada medida. Una cota con las **puntas redondas** es una que moviste a mano; las **marcas perpendiculares** son de una calculada. La caja punteada alrededor del tiesto no es una medida: muestra en qué **dirección** se tomaron el largo y el ancho.

**Mover una cota a mano.** La herramienta de **cotas** (`E`) pone nodos en las cuatro puntas del largo y el ancho de cada tiesto. Arrastrás el que quieras y la cota va a donde la lleves —sin quedar atada a la caja ni a la perpendicular—, para medir algo puntual que ningún criterio automático da: el espesor de un labio, el arranque de un asa, la cuerda de un borde. Con `Ctrl` la punta se pega al punto más cercano del contorno.

El largo y el ancho se editan **por separado**: mover uno no toca al otro. La cota movida pasa a mandar —es el `Largo` o el `Ancho` de la ficha y de la exportación— y la calculada queda entera en sus propias columnas, con una columna `Editado a mano` que dice fila por fila qué se movió (`no`, `largo`, `ancho` o `largo y ancho`). El botón **↺** de la tarjeta devuelve el tiesto a su medida calculada. Las cotas a mano se guardan en píxeles de la imagen, así que recalibrar la escala las recalcula igual que a las automáticas.

Sirve para no confundir cuál número es cuál en piezas irregulares y para ver de dónde sale cada medida (ver [Notas metodológicas](#notas-metodológicas)). Las cotas se apagan con la casilla **Ejes de medición sobre la imagen** y salen también en la imagen anotada que se exporta.

### 5 · Depurar y exportar

Cada tiesto de la lista de resultados tiene un ícono de papelera para borrarlo: usalo con las sombras o cualquier falso positivo que se haya colado. Si lo que se coló es la escala gráfica, conviene marcarla como zona excluida (paso 2) y volver a detectar: se va entera de una vez, con todas sus manchas internas.

Exportá en **Excel (.xlsx)**, **CSV**, **JSON** o como **imagen anotada** (la foto con los contornos y los IDs dibujados, para la ficha o la publicación).

**Qué medidas se exportan.** Arriba de la lista de resultados, el bloque *Medidas que van a la exportación* decide qué columnas salen: `Área`, `Perímetro`, `Largo` y `Ancho`, cada una con su casilla. Vale para todo el lote. El bloque está justo encima de la lista de tiestos, para tener a la vista al mismo tiempo lo que se tilda y lo que se mide.

En la tarjeta de cada tiesto, además, **cada medida lleva su propia casilla**. Tildarla o destildarla ahí hace que **ese** tiesto lleve su propia selección —queda marcado `medidas propias`— sin tocar al resto del lote: es para el caso de cincuenta tiestos de los que solo interesa el área y uno del que además se quiere el largo y el ancho. El **↺** celeste de la tarjeta lo devuelve a la selección general.

En la planilla una columna aparece si **al menos un tiesto** la pidió, y en los que no la piden la **celda queda vacía**, así sigue siendo una tabla con una fila por tiesto. El JSON, que no es una tabla, le da a cada tiesto solo sus medidas y anota cuáles no siguen la selección general.

La selección **no cambia lo que ves**: en la ficha seguís viendo las cuatro medidas —apagadas las que no se exportan—, porque hay que poder mirar el número antes de decidir si entra; y las cotas sobre la imagen las sigue mandando la casilla *Ejes de medición sobre la imagen*.

El `.xlsx` trae una hoja **Tiestos** con esa tabla y una hoja **Metadatos** con los parámetros de la corrida, incluida la selección de medidas y la lista de los tiestos que llevan la suya. `Largo`/`Ancho` traen la medida que manda para cada tiesto —la movida a mano cuando la hay— y al lado quedan `Largo calculado`/`Ancho calculado` si algún tiesto tiene una cota movida, con `Editado a mano` diciendo fila por fila qué se movió. El CSV lleva las mismas columnas.

### Idioma

El botón **ES · EN** del encabezado cambia toda la interfaz —paneles, ayudas, mensajes y tarjetas— entre español e inglés, sin recargar ni perder lo medido. Los encabezados de las exportaciones siguen el idioma elegido: en inglés el `.xlsx` sale con las hojas *Sherds* y *Metadata* y las columnas *Code, Type, Area (cm²)…*. La elección se recuerda para la próxima vez.

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
| **Perímetro** (cm) | Contorno 8-conectado (vecindad de Moore) con corrección de Vossepoel–Smeulders |
| **Largo** (cm) | La cuerda más larga del tiesto en la dirección de su eje — ver abajo |
| **Ancho** (cm) | La cuerda perpendicular al eje que pasa por el punto medio del largo |
| **Largo · Ancho calculado** (cm) | Los dos anteriores tal como los calculó la aplicación, aunque hayas movido la cota a mano |
| **Largo · Ancho a mano** (cm) | Longitud de la cota que moviste con la herramienta `E`, si moviste alguna. Manda sobre la calculada en `Largo`/`Ancho` |

Todas se calculan siempre y se ven siempre en la ficha. Cuáles de ellas **se exportan** lo decidís vos, para el lote entero o tiesto por tiesto — ver [Depurar y exportar](#5--depurar-y-exportar).

### Notas metodológicas

**El largo y el ancho son cuerdas del tiesto.** Desde v1.3 hay un solo criterio, en tres pasos:

1. **El eje.** Se encierra el tiesto en la caja rectangular más chica que lo contenga, probando todos los ángulos, y se toma la **dirección de su lado largo**. Es la dirección propia de la pieza: no depende de cómo haya quedado girada en la foto. La caja se sigue dibujando punteada, pero **ya no se mide** — está para que se vea de dónde salió el eje.
2. **El largo** es la **cuerda más larga** que el tiesto da en esa dirección: la mayor distancia que se puede recorrer sobre una misma línea paralela al eje, con las dos puntas apoyadas en el contorno.
3. **El ancho** es la cuerda **perpendicular al eje que pasa por el punto medio del largo**. No es la travesía más gruesa: es la medida *de la parte media*, que es la que se toma con el calibre sobre la mesa.

Un entrante no parte la cuerda: se mide del primer al último punto de cerámica que la recta encuentra, igual que cuando el calibre pasa por encima de una muesca.

> **Por qué una cuerda y no el lado de la caja.** El lado de la caja mide la *sombra* del tiesto sobre el eje, y una sombra junta puntos que están a distinta altura: sus dos extremos pueden pertenecer a partes de la pieza que no se encuentran sobre ninguna línea. Una cuerda, en cambio, tiene que vivir entera sobre una sola recta, así que siempre corresponde a algo que se puede apoyar contra un calibre.

> **Empates del eje.** Un triángulo —y cualquier polígono regular— tiene varias orientaciones con exactamente la misma caja mínima. Ante un empate gana el rectángulo más alargado, para que el eje no dependa del orden en que se recorrió el borde: el mismo tiesto trazado al revés da el mismo largo.

Los ejes dibujados sobre la imagen muestran de dónde sale cada número.

**Perímetro.** Se traza el contorno del tiesto con vecindad de Moore (8-conectada) y se aplica la corrección de Vossepoel–Smeulders de tres parámetros: `0.980·(pasos rectos) + 1.406·(pasos diagonales) − 0.091·(esquinas)`. Compensa el efecto escalera de la rasterización, que sobreestima el perímetro de los bordes curvos.

**Recalibración.** Cada tiesto guarda sus medidas crudas en píxeles y los centímetros se derivan de la calibración vigente. Si cambiás la escala con tiestos ya medidos, las métricas se recalculan desde el original, sin acumular error: podés corregir la medida real las veces que haga falta.

## Cómo fotografiar

Casi todos los problemas de medición vienen de la foto, no del software:

- **Parte más larga hacia arriba.** Apoyá cada tiesto con su dimensión mayor en vertical. No es obligatorio —el eje lo busca la aplicación a partir de la pieza, no de la foto, así que un tiesto torcido se mide igual—, pero con el lote entero orientado del mismo modo las cotas salen parejas y la lámina se lee de un vistazo.
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
- El **largo** y el **ancho** medidos con **v1.2 o antes no son comparables** con los de v1.3 — el detalle está en el [CHANGELOG](CHANGELOG.md). El área y el perímetro sí siguen siendo comparables.
- Los datos medidos con **v1.0 no son comparables** con los de v1.1 en adelante — ver [CHANGELOG.md](CHANGELOG.md). Si usaste v1.1 y corregiste la **medida real** de la escala *después* de medir, ese lote hay que volver a exportarlo con v1.2: había un error de redondeo que cuantizaba las métricas.

## Probar y verificar

La carpeta [`ejemplo/`](ejemplo/) trae una **imagen de prueba** con figuras de dimensiones exactas conocidas y una barra de escala de 5 cm. Sirve para recorrer el flujo de trabajo sin tener que fotografiar nada, y para comprobar que la aplicación mide bien: en [`ejemplo/README.md`](ejemplo/README.md) están los valores esperados de cada figura.

Con tus propias fotos, el control equivalente es incluir en la toma un objeto rectangular de dimensiones conocidas (una tarjeta de 8.5 × 5.4 cm sirve) y medirlo con la app.

El `Largo` y el `Ancho` tienen que coincidir con los reales dentro de un par de décimas de milímetro: en una pieza de lados rectos la cuerda más larga *es* el lado, y la del medio *es* el ancho. Si no dan, revisá la calibración y la perpendicularidad de la cámara.

> Un control **redondo o triangular no sirve** para esto. En una figura que se afina hacia las puntas, el ancho se toma en la parte media y por eso da bastante menos que su dimensión mayor — no es un error, es la definición. Usá siempre un rectángulo.

## Tecnologías

JavaScript puro sobre HTML5 Canvas, sin frameworks ni build. Un solo archivo (`index.html`) más [SheetJS](https://sheetjs.com/) (`xlsx.full.min.js`) para la exportación a Excel, incluido localmente. Tipografías Cormorant Garamond, DM Sans y DM Mono vía Google Fonts, con degradación a las del sistema si no hay conexión.

## Citación

> Villafañez, E.A. (2026). *CeraMetric v1.3: herramienta de análisis morfométrico de tiestos cerámicos*. LATDAA, Escuela de Arqueología, Universidad Nacional de Catamarca. Zenodo. https://doi.org/10.5281/zenodo.22312910

Ese DOI es el de **esta versión**. Para un trabajo donde importa la reproducibilidad conviene citarlo así, porque garantiza que quien lo consulte vea exactamente el programa con el que se midió — y desde v1.3 el largo y el ancho no son comparables con los de versiones anteriores.

Si en cambio querés apuntar siempre a la última versión publicada, cualquiera sea, usá el **DOI de concepto**: [10.5281/zenodo.22312909](https://doi.org/10.5281/zenodo.22312909).

El repositorio incluye un [CITATION.cff](CITATION.cff): GitHub genera la cita en BibTeX o APA desde el botón **Cite this repository**.

## Contribuir

Los reportes de error y las sugerencias van por [Issues](https://github.com/emilios81/cerametric/issues). Si reportás un problema de medición, incluí la foto (o una equivalente), el valor de px/cm de la calibración y lo que esperabas obtener.

## Licencia

[MIT](LICENSE) — uso, modificación y distribución libres, con atribución.
SheetJS se distribuye bajo su propia licencia; ver [THIRD-PARTY.md](THIRD-PARTY.md).

---

## English summary

**CeraMetric** is an offline-capable, browser-based tool for the morphometric analysis of ceramic sherds. From a single photograph containing a graphic scale, it measures area, perimeter (Moore-neighbourhood contour tracing with the three-parameter Vossepoel-Smeulders correction), length and width. Length and width are chords of the sherd itself: the axis is the long side of the minimum-area bounding rectangle, so it is orientation-independent; length is the longest chord parallel to that axis, and width the perpendicular chord through the midpoint of the length. Both endpoints of each dimension rest on the outline. Sherds can be segmented automatically (Gaussian blur, morphological closing, hole filling, Otsu-assisted thresholding) or outlined by hand. Measurement axes are drawn over each sherd as dimension lines — amber for length, blue for width — so it is always clear which segment each figure comes from. Length and width measured with v1.2 or earlier are not comparable with v1.3; area and perimeter are unchanged. Which measurements reach the export is chosen for the whole batch and, if needed, sherd by sherd. The interface is bilingual (Spanish / English). Results export to XLSX, CSV, JSON and as an annotated image.

No installation, no server, no data upload — all processing happens in the browser. **[Launch the app](https://emilios81.github.io/cerametric/)** or download the repository and open `index.html` locally (keep `xlsx.full.min.js` in the same folder).

Developed at LATDAA (Laboratory of Digital Technologies Applied to Archaeology), School of Archaeology, National University of Catamarca, Argentina. Released under the MIT License; please cite as indicated above.

---

*LATDAA · Escuela de Arqueología · UNCa · CONICET · Fundación de Historia Natural Félix de Azara*
