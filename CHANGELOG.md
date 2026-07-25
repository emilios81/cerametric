# Registro de cambios

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

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
