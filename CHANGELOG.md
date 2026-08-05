# Registro de cambios

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

## [1.2] — 2026-08-05

> ⚠ **El `Largo` cambió de definición.** Antes era el lado mayor del rectángulo de área
> mínima; ahora es la mayor distancia entre dos puntos de la pieza, que es lo que se mide
> con un calibre. Los lotes de v1.0 y v1.1 **no son comparables columna a columna** con los
> nuevos. La definición vieja sigue disponible en la columna `Largo rect.`, así que un
> lote nuevo se puede comparar con uno viejo usando esa columna. El `Ancho` también cambió
> de definición, pero en la práctica los valores casi no se mueven (ver abajo). El área, el
> perímetro, la circularidad y el color no cambiaron.

### Cambiado

- **`Largo` y `Ancho` ahora son las medidas del calibre**, no los lados del rectángulo
  mínimo. `Largo` = mayor distancia entre dos puntos de la pieza, con el calibre abierto a
  fondo. `Ancho` = menor abertura con la que el calibre todavía la abraza, girándolo hasta
  la posición en que entra más justa. Son las dos medidas que se toman en gabinete y no
  dependen de cómo esté girada la pieza en la foto. Sus direcciones no son perpendiculares
  entre sí: son mediciones independientes.

  El motivo: el rectángulo de área mínima optimiza **superficie, no longitud**. En un
  tiesto poco alargado gira a una orientación donde su lado mayor queda **por debajo del
  largo real de la pieza**. En la figura irregular del ejemplo la diferencia es de 0.84 cm
  (10 %), y se detectó midiendo un tiesto real donde el largo informado era 6.73 cm cuando
  la pieza medía 7.8 cm de punta a punta.

- **Los lados del rectángulo mínimo siguen disponibles** como `Largo rect.` y `Ancho rect.`
  Son el par correcto en piezas rectangulares: en un rectángulo la mayor distancia entre
  dos puntos es la diagonal, así que ahí el `Largo` de calibre da la diagonal y no el lado.
  **La verificación con una tarjeta de dimensiones conocidas hay que hacerla contra estas
  dos columnas.**

- **`Elongación`** pasa a ser `Largo / Ancho` con las definiciones nuevas.

  Medido sobre `ejemplo/imagen_de_prueba.png`:

  | Figura | Largo | Ancho | Largo rect. | Ancho rect. |
  |---|---|---|---|---|
  | Rectángulo 8.5 × 5.4 | 10.06 *(diagonal)* | 5.43 | 8.53 | 5.43 |
  | Círculo ⌀ 4 | 4.02 | 4.00 | 4.00 | 4.00 |
  | Triángulo 6 × 4 | 5.96 | 3.97 | 5.93 | 3.98 |
  | Barra fina 5 × 0.9 | 5.12 | 0.93 | 5.08 | 0.93 |
  | Irregular equidimensional | 9.01 | 7.37 | 8.17 | 7.50 |

  Se cumple siempre que `Largo ≥ Largo rect.` y `Ancho ≤ Ancho rect.`

El área, el perímetro, la circularidad, la solidez y el color **no cambiaron**: verificado
contra la imagen de prueba, dan los mismos valores que en v1.1 hasta el último decimal.

### Agregado

- **Ejes de medición sobre la imagen.** Cada tiesto muestra ahora las cotas de las que
  salen sus medidas, dibujadas como en un plano: línea con marcas en los extremos, más la
  sigla y el valor. El **color** indica la dimensión (ámbar el largo, celeste el ancho) y
  el **trazo** el criterio (línea llena el calibre, punteada el rectángulo mínimo). En una
  pieza irregular no había forma de saber cuál de los dos números era cuál; ahora se ve
  entre qué puntos se tomó cada uno. Un selector permite superponer el rectángulo mínimo
  para comparar, o mostrarlo solo. Las cotas aparecen también en la **imagen anotada** que
  se exporta.
- **Nota metodológica sobre largo y ancho** en el README, con la tabla comparativa de los
  dos pares medidos sobre la imagen de prueba y la aclaración de contra qué columnas hay
  que verificar la calibración con una tarjeta.
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
- La columna `Feret_max_cm` **desaparece**: pasó a ser `Largo_cm`. En su lugar están
  `Rect_largo_cm` y `Rect_ancho_cm` (`rect_largo_cm` / `rect_ancho_cm` en el JSON), que son
  el par del rectángulo mínimo — o sea, el `Largo_cm` y el `Ancho_cm` de v1.1.
  El orden de columnas queda: `Código, Tipo, Area_cm2, Largo_cm, Ancho_cm, Perimetro_cm,
  Rect_largo_cm, Rect_ancho_cm, Circularidad, Elongacion, Solidez, Color_hex`.
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
