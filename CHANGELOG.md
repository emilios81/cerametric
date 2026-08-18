# Registro de cambios

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

## [1.2] — 2026-08-05

**Ninguna métrica cambió de definición: los datos de v1.1 son comparables con los de v1.2**,
salvo los lotes afectados por el primer error de abajo. Verificado contra
`ejemplo/imagen_de_prueba.png`: las cinco figuras dan los mismos valores que en v1.1, hasta
el último decimal.

`Largo` y `Ancho` siguen siendo los lados del **rectángulo de área mínima** — la caja más
chica que contiene la pieza, probando todos los ángulos —, medidos por el medio y no de
esquina a esquina.

### Agregado

- **Ejes de medición sobre la imagen.** Cada tiesto muestra ahora las cotas de las que
  salen sus medidas, dibujadas como en un plano: línea con marcas en los extremos, más la
  sigla y el valor. El **color** indica la dimensión (ámbar a lo largo, celeste a lo ancho)
  y el **trazo** el criterio (línea llena los lados de la caja, punteada las cruzadas). En
  una pieza irregular no había forma de saber cuál de los dos números era cuál; ahora se ve
  entre qué puntos se tomó cada uno. Un selector permite mostrar un par, el otro o los dos.
  Las cotas aparecen también en la **imagen anotada** que se exporta.
- **La caja de área mínima se dibuja alrededor de cada tiesto**, punteada, en el color de la
  pieza. Es el rectángulo del que salen el largo y el ancho, y verlo explica por qué esas
  cotas pueden pasar por fuera del fragmento: un tiesto irregular no llena su caja, la toca
  apenas en unos pocos puntos del borde. Reemplaza al rectángulo alineado a los ejes de la
  fotografía que se dibujaba antes, que no correspondía a ninguna medida informada y hacía
  pensar que el largo se tomaba en horizontal.
- **Dos métodos de medición, a elección.** Un selector decide cómo se toman el largo y el
  ancho:
  - **Por caja** — los lados del rectángulo de área mínima. Es el método de v1.0 a v1.1.
  - **Por contorno** — la mayor distancia entre dos puntos del borde y la travesía más
    larga perpendicular a ella, que es lo que se obtiene con un calibre.

  Los dos se calculan siempre y **los dos se exportan**: el `.xlsx` los separa en dos hojas
  —*Por caja* y *Por contorno*—, y el CSV y el JSON los llevan juntos en las columnas
  `Largo_caja_cm`, `Ancho_caja_cm`, `Largo_contorno_cm` y `Ancho_contorno_cm`, con el
  elegido además en `Largo_cm` y `Ancho_cm`. Una columna **`Metodo`** deja constancia en
  cada fila de cuál se usó, para que una planilla no quede ambigua. La `Elongación` se
  calcula con el par que corresponde. En la hoja *Metadatos* del `.xlsx` y en el JSON
  también queda registrado.

  En un tiesto redondeado el largo por contorno suele dar algo más que el de la caja
  — 0.84 cm en la figura irregular del ejemplo — porque la caja optimiza superficie y no
  longitud. En una pieza rectangular pasa al revés: el largo por contorno se va a la
  diagonal. Ninguno es más correcto; con el selector en *"los dos métodos"* se dibujan
  ambos superpuestos para comparar pieza por pieza.
- **Nota metodológica sobre largo y ancho** en el README, con la tabla comparativa de los
  dos pares medidos sobre la imagen de prueba.
- **Explicación dentro de la aplicación**, en el panel de resultados: qué se está midiendo,
  por qué las cotas terminan donde terminan y qué pasa en piezas con esquinas vivas. Se
  pliega con un clic para no empujar la lista de tiestos.

### Corregido en la interfaz

- **Contraste de los textos.** Los párrafos explicativos, las etiquetas de los campos y los
  nombres de las métricas usaban un azul grisado que daba **2.6:1** sobre el fondo oscuro,
  por debajo del mínimo legible de 4.5:1, y en cuerpos de 9 px en cursiva. Ahora están en
  **5.9:1** y sin cursiva.
- **`CeraMetric.bat`** para abrir la aplicación con doble clic en Windows, sin tener que
  buscar el `index.html`. Avisa si el archivo quedó separado de la carpeta o si falta
  `xlsx.full.min.js`.

### Corregido

- **El campo «Medida real (cm)» corrompía las métricas ya calculadas.** El campo reacciona
  a cada tecla, y cada pulsación reescalaba los valores *ya redondeados a dos decimales*
  en vez de recalcularlos. Al escribir `10` sobre el `5` que viene por defecto, el `1`
  intermedio dividía todo por cinco y lo redondeaba, y el `0` lo multiplicaba por diez: el
  resultado quedaba cuantizado a cm² enteros. En la imagen de prueba, un tiesto de
  8.20 cm² se exportaba como 8 cm² (−2.4 %) y uno de 50.24 cm² como 50 cm².
  Ahora cada tiesto guarda sus métricas crudas en píxeles y los centímetros se derivan de
  la calibración vigente, así que recalibrar re-deriva desde el original: escribir
  `10 → 5 → 12 → 10` devuelve exactamente los valores iniciales.
  **Si mediste un lote y después corregiste la medida real de la escala, volvé a exportarlo
  con v1.2** (basta con recargar la imagen y volver a detectar).
- **Códigos duplicados en la selección manual.** El ID automático se numeraba con la
  cantidad de tiestos manuales, así que después de borrar uno el siguiente reutilizaba un
  número ya usado: al borrar `M-01` el siguiente volvía a ser `M-02`. Ahora la numeración
  es correlativa y no reutiliza códigos. Si escribís un código a mano que ya está en uso,
  la barra de estado lo avisa.
- **El CSV no entrecomillaba los campos.** Un código de registro con una coma
  (`AMB-24, U3`) generaba filas con una columna de más y corría todos los datos al abrir el
  archivo. Ahora se entrecomilla según RFC 4180. Además, los campos de texto que empiezan
  con `=`, `+`, `-` o `@` se prefijan con un apóstrofo para que Excel no los interprete
  como fórmulas; los valores numéricos pasan intactos.

### Cambios en los archivos exportados

- Los archivos pasan a llamarse `cerametric_v12.xlsx` / `.csv` / `.json`, y la versión que
  figura en la hoja **Metadatos** y en el JSON es `CeraMetric v1.2`.
- **El `.xlsx` trae una hoja por método**: *Por caja* y *Por contorno*, cada una con la
  tabla completa —`Código, Tipo, Método, Área, Largo, Ancho, Perímetro, Circularidad,
  Elongación, Solidez, Color hex`— y con el largo y el ancho de **su** criterio. La
  `Elongación` de cada hoja sale del par de esa hoja. Primero va la del método elegido,
  que es la que Excel abre; la otra queda al lado por si se quiere comparar. Así, quien
  trabaja con un solo sistema de medidas se lleva su planilla sin columnas de más.
- **Columnas nuevas en el CSV**: `Metodo`, `Largo_caja_cm`, `Ancho_caja_cm`,
  `Largo_contorno_cm` y `Ancho_contorno_cm`. La columna `Feret_max_cm` de v1.1 pasa a
  llamarse `Largo_contorno_cm` — mismo valor, nombre coherente con el método al que
  pertenece. El CSV es un único archivo plano, así que ahí siguen conviviendo los dos
  métodos, en este orden: `Código, Tipo, Metodo, Area_cm2, Largo_cm, Ancho_cm,
  Perimetro_cm, Largo_caja_cm, Ancho_caja_cm, Largo_contorno_cm, Ancho_contorno_cm,
  Circularidad, Elongacion, Solidez, Color_hex`. El JSON también guarda los dos.
- Con el método **por caja** —el que viene por defecto— `Largo_cm`, `Ancho_cm` y
  `Elongacion` valen exactamente lo mismo que en v1.1, así que los lotes viejos siguen
  siendo comparables sin tocar nada.
- El CSV termina las filas con CRLF, como indica la norma.

## [1.1] — 2026-07-25

> ⚠ **Los datos medidos con v1.0 no son comparables con los de v1.1.** Cinco métricas
> cambiaron de definición o de método de cálculo. Si tenés lotes medidos con la versión
> anterior y necesitás compararlos con nuevos, hay que volver a medirlos con v1.1.

### Cambios en las métricas

- **Largo y ancho.** Ahora son los lados del **rectángulo de área mínima** (rotating
  calipers sobre el casco convexo). Antes eran los lados del *bounding box* alineado a
  los ejes de la imagen (`BBox L` / `BBox A`), que dependían de cómo estuviera orientado
  el tiesto en la fotografía: el mismo tiesto girado 45° daba valores distintos.
- **Diámetro máximo de Feret.** Nueva columna. Es la distancia máxima entre dos puntos
  del contorno; en piezas cuadrangulares corresponde a la diagonal, por eso se informa
  aparte del largo y no como largo.
- **Perímetro.** Ahora se calcula trazando el contorno con vecindad de Moore
  (8-conectada) y aplicando la corrección de Vossepoel–Smeulders de tres parámetros.
  Antes se contaban las aristas de los píxeles del borde, lo que sobreestimaba el
  perímetro alrededor de un 27 % en bordes curvos, con el consiguiente error en la
  circularidad.
- **Solidez.** Ahora es área / área del **casco convexo** (definición estándar en
  morfometría). Antes era área / área del *bounding box*.
- **Color.** Ahora es el **promedio RGB de todos los píxeles** del tiesto. Antes se
  tomaba el color de un único píxel, el del centro del *bounding box*, que podía caer
  sobre un reflejo, una mancha o incluso fuera de la pieza en tiestos cóncavos.

### Agregado

- **`xlsx.full.min.js` incluido en el repositorio.** En v1.0 faltaba, así que la
  exportación a Excel no funcionaba al clonar o descargar el proyecto.
- Campo **Medida real (cm)** vivo: al cambiarlo se recalcula la escala y se reescalan
  todas las métricas ya medidas, sin volver a marcar los puntos.
- Hoja **Metadatos** en el `.xlsx` exportado: versión, fecha, código de registro,
  dimensiones de la imagen, px/cm y parámetros de detección usados.
- Metadatos de sesión también en la exportación **JSON** (antes exportaba solo el
  arreglo de tiestos, sin contexto).
- **BOM UTF-8** en el CSV exportado, para que Excel muestre bien los acentos.
- Botón **Restaurar imagen original** después de un recorte.
- Carpeta `ejemplo/` con una imagen de prueba de dimensiones conocidas y los valores
  esperados de cada figura, para conocer el flujo de trabajo y verificar la medición.
- Documentación del repositorio: `LICENSE`, `CHANGELOG.md`, `CITATION.cff`,
  `THIRD-PARTY.md` y README ampliado con guía de uso, recomendaciones de fotografía,
  limitaciones y procedimiento de verificación.

### Cambios en los archivos exportados

- Los archivos pasan a llamarse `cerametric_v11.xlsx` / `.csv` / `.json`.
- Columnas del CSV/XLSX: se reemplazan `BBox_L_cm` y `BBox_A_cm` por `Largo_cm` y
  `Ancho_cm`, y se agrega `Feret_max_cm`.

## [1.0] — 2025

Primera versión pública: calibración de escala por dos puntos, detección automática por
umbral con pre-procesamiento (desenfoque gaussiano, cierre morfológico, relleno de
agujeros, sugerencia de Otsu), selección manual por polígonos, recorte de imagen,
eliminación individual de detecciones, y exportación a CSV, JSON, XLSX e imagen anotada.
