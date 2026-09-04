# Registro de cambios

Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/).

## [Sin publicar]

**Cambian la definición del largo y del ancho, y se van tres métricas.** El `Área` y el
`Perímetro` **no se tocaron**: verificado contra `ejemplo/imagen_de_prueba.png` con los
parámetros del instructivo, las cinco figuras dan exactamente los mismos números que en
v1.2, hasta el último decimal — áreas 45.98 / 12.56 / 25.76 / 11.94 / 2.05 cm² y perímetros
27.56 / 12.49 / 18.54 / 15.95 / 14.36 cm.

> **Los lotes medidos con v1.2 o antes no son comparables en largo y ancho con los medidos
> desde esta versión.** El área y el perímetro sí lo siguen siendo.

### Cambios en las métricas

- **Se va el color promedio.** El `Color hex` de cada tiesto salió de la ficha, del `.xlsx`,
  del CSV y del JSON, junto con el cálculo del promedio RGB. Era un dato relativo a la
  iluminación de cada foto, no comparable entre tomas, y en la lista de medidas se prestaba
  a confusión con el color con que la aplicación dibuja cada tiesto. Quedan `Área`,
  `Perímetro`, `Largo` y `Ancho`.

- **Un solo criterio para el largo y el ancho: cuerdas del tiesto.** Desaparece el selector
  *por caja* / *por contorno*, y con él las columnas dobles de la exportación y la opción de
  dibujar los dos pares para compararlos. El eje sigue saliendo del **lado largo del
  rectángulo de área mínima** —es la dirección propia de la pieza y no depende de cómo haya
  quedado girada en la foto—, pero **la caja ya no se mide**: el `Largo` es la **cuerda más
  larga** que el tiesto da en esa dirección y el `Ancho`, la **cuerda perpendicular que pasa
  por el punto medio del largo** (no la travesía más gruesa). Las cuatro puntas apoyan en el
  contorno de la cerámica. Un entrante no parte la cuerda: se mide del primer al último
  punto de cerámica que la recta encuentra, como cuando el calibre pasa sobre una muesca.

  | Figura de la imagen de prueba | v1.2 *por caja* | v1.2 *por contorno* | **v1.3** |
  |---|---|---|---|
  | Rectángulo 8.5 × 5.4 rotado 30° | 8.53 · 5.43 | 10.06 · 6.43 | **8.52 · 5.41** |
  | Círculo ⌀ 4 | 4.00 · 4.00 | 4.02 · 4.02 | **4.00 · 4.00** |
  | Polígono irregular | 5.78 · 5.68 | 6.38 · 5.65 | **5.75 · 5.54** |
  | Triángulo 6 × 4 | 5.93 · 3.98 | 5.96 · 3.97 | **5.93 · 2.68** |
  | Barra de escala 5 × 0.9 | 5.08 · 0.93 | 5.12 · 0.94 | **5.08 · 0.38** |

  El largo casi no se mueve —a lo sumo 0.03 cm en estas figuras—, porque el lado de la caja
  mide la *sombra* del tiesto sobre el eje y una cuerda tiene que vivir entera sobre una
  sola recta. Donde el cambio se nota es en el **ancho**, y es a propósito: en el triángulo
  baja de 3.98 a 2.68 cm porque su punta no cae sobre el medio de la base, y en la barra de
  escala de 0.93 a 0.38 porque sus marcas verticales largas ya no cuentan.

- **Se van `Circularidad`, `Elongación` y `Solidez`.** De la ficha de cada tiesto, del
  `.xlsx`, del CSV y del JSON. Quedan `Área`, `Perímetro`, `Largo`, `Ancho` y el color
  promedio. La solidez además venía mal: el casco convexo se calcula sobre centros de píxel,
  así que subestimaba, y el `Math.min(1, …)` clavaba en 1.000 toda pieza convexa.

- **El eje ya no depende del orden en que se recorrió el borde.** Un triángulo —y cualquier
  polígono regular— tiene varias orientaciones con exactamente la misma caja mínima, y
  quedarse con la primera hacía que el mismo tiesto trazado al revés diera otro largo. Ante
  un empate (1e-6 relativo) gana ahora el rectángulo más alargado.

- **Aviso de orientación al fotografiar.** En el paso 1 y en la ayuda del panel derecho:
  conviene apoyar cada tiesto con su parte más larga hacia arriba, para que el lote salga
  parejo. No es un requisito del cálculo — un tiesto torcido se mide igual, porque el eje
  sale de la pieza y no de la foto.

- **La caja punteada se sigue dibujando, pero cambió de significado**: ya no es de dónde
  salen las medidas, sino de dónde sale la **dirección** del eje. Desaparecen las líneas
  finas terminadas en punto que enlazaban una cota con el borde: ahora las cotas apoyan
  solas, por definición.

### Agregado

- **Interfaz bilingüe, español e inglés.** Un botón **ES · EN** en el encabezado cambia todo
  —paneles, ayudas, tooltips, mensajes de la barra, tarjetas de tiesto— sin recargar la
  página ni perder lo medido, y la elección se recuerda. Las exportaciones siguen el idioma:
  en inglés el `.xlsx` sale con las hojas *Sherds* y *Metadata* y las columnas *Code, Type,
  Area (cm²), Perimeter (cm), Length (cm), Width (cm)*.

  El inglés se aplica por **reemplazo de frases sobre el DOM ya armado**: un `TreeWalker`
  recorre los nodos de texto y cambia los que estén en el diccionario, y después se hace lo
  mismo con los `title` y los `placeholder`. Así no hubo que sembrar el HTML de claves y los
  `<b>`/`<code>`/`<kbd>` intercalados quedaron donde estaban. Lo que el JS escribe en vivo
  pasa por `tr()` — que se llama así, y no `t()`, porque `t` ya era nombre de parámetro en
  `dimLine`, `drawAxes`, `densifica` y `setTool`, donde habría tapado a la función.

- **Logo propio**, al lado del nombre: la vasija sobre la retícula hexagonal de dibujo
  técnico, con el perfil izquierdo lleno y el derecho punteado. Va como SVG en línea —la
  aplicación sigue siendo un archivo suelto— y también como favicon embebido, así que
  funciona sin conexión.

- **Se elige qué medidas se exportan, para el lote y tiesto por tiesto.** Arriba de la lista
  de resultados, el bloque *Medidas que van a la exportación* tilda o destilda `Área`,
  `Perímetro`, `Largo`, `Ancho` y `Color` para todo el lote. Y en la tarjeta de cada tiesto
  cada medida lleva su propia casilla: tocarla hace que **ese** tiesto se quede con una copia
  de la selección general y siga por su cuenta —queda marcado `medidas propias`, con un
  **↺** celeste para volver a seguirla—, sin que el resto del lote se entere. Resuelve el
  caso de cincuenta tiestos de los que solo interesa el área y uno del que además se quiere
  el largo y el ancho.

  En la planilla la columna aparece si **al menos un tiesto** la pidió, y en los que no la
  piden la **celda queda vacía**: sigue siendo una tabla con una fila por tiesto, sin hojas
  que después haya que cruzar. El JSON, que no es una tabla, le da a cada tiesto solo sus
  medidas y anota en `medidas_propias` a los que no siguen la general. La hoja *Metadatos*
  deja constancia de la selección y de qué tiesto lleva cuál.

  Dos cosas quedaron a propósito **fuera** de esto: la ficha en pantalla, que sigue mostrando
  las cuatro medidas —apagadas las que no se exportan— porque hay que poder mirar el número
  antes de decidir si entra; y las cotas sobre la imagen, que las sigue mandando la casilla
  *Ejes de medición sobre la imagen*, para que destildar una medida no cambie el dibujo.

  El bloque va **pegado a la lista de tiestos**, no arriba del panel: con las casillas
  generales y las de cada tarjeta a la vista al mismo tiempo se ve de un vistazo qué está
  tildado y qué no.

- **Zonas excluidas de la detección: marcar la escala.** Herramienta nueva (`X`, y botón
  **Marcar la escala** arriba del paso 2, antes de calibrar): se arrastra un rectángulo
  sobre la escala gráfica y la detección automática saltea todo lo que quede adentro. Una
  escala con colores, números o recuadros entraba si no como cuatro o cinco tiestos falsos
  —uno por cada mancha interna— que había que borrar de a uno con la papelera. La zona **no
  toca la calibración**: los dos clics de la escala se siguen haciendo adentro, y en cuanto
  la zona queda marcada la aplicación pasa sola a la herramienta **Calibrar**, que es el paso
  siguiente — sin eso uno se quedaba en modo excluir sin darse cuenta y los clics sobre la
  escala no calibraban nada. Se pueden marcar varias zonas —una etiqueta, una moneda, la
  mano— y cada una lleva una **×** en su esquina para quitarla: borrarlas con un clic en
  cualquier parte de la zona era una trampa, porque la zona cubre justo la escala y el primer
  clic que uno daba ahí para calibrar la hacía desaparecer.
  Un componente se descarta si queda **mayormente** adentro (por mayoría de píxeles, no por
  el centro ni por el solapamiento): así la escala se va entera y un tiesto que apenas roza
  el borde de la zona se conserva. La vista previa deja de pintar de verde adentro de la
  zona, la barra de estado informa cuántos se descartaron, y las zonas quedan anotadas en el
  JSON y en la hoja *Metadatos* del `.xlsx`. Las zonas se mueven y se recortan junto con la
  imagen al usar **Recortar**.
- **Cotas que se mueven a mano.** Una herramienta nueva en la barra (tecla `E`) pone nodos
  en las cuatro puntas del largo y el ancho de cada tiesto; arrastrando cualquiera de ellos
  la cota va a donde uno la lleve, sin quedar atada a la caja ni a la perpendicular. Sirve
  para medir algo puntual que ningún criterio automático da —el espesor de un labio, el
  arranque de un asa, la cuerda de un borde—. Con `Ctrl` la punta se pega al punto más
  cercano del contorno, que sobre una foto es la única forma de apoyarla en el borde sin
  acertar el píxel a pulso; funciona tanto con los píxeles del borde detectado como con los
  lados del polígono trazado a mano.
- **La cota movida manda, y se sabe cuál se movió.** Pasa a ser el `Largo` o el `Ancho` de
  la ficha y de la exportación, con la etiqueta *a mano* en la tarjeta y un botón **↺** para
  volver a la calculada. Nada se pierde: las columnas de caja y de contorno siguen enteras,
  aparecen las nuevas `Largo_mano_cm`/`Ancho_mano_cm`, y una columna `Editado a mano` dice
  fila por fila qué se tocó — `no`, `largo`, `ancho` o `largo y ancho`. En el `.xlsx` cada
  hoja suma `Largo/Ancho calculado` al lado de la medida que manda.
- **El largo y el ancho se editan por separado.** Al agarrar un nodo se copia **solo** esa
  cota. Si se copiara el par entero, la dimensión que uno no tocó perdería la corrección de
  +1 px de la detección automática y su número se movería solo —0.25 mm a 40 px/cm—, que en
  un instrumento de medida es inadmisible. Por eso puede haber un tiesto con el largo a mano
  y el ancho calculado, y la exportación lo dice.
- Las cotas a mano se guardan **en píxeles de la imagen**, igual que las calculadas, así que
  recalibrar la escala las re-deriva desde el original en vez de reescalar un valor ya
  redondeado.

### Corregido

- **Las cotas apoyan en el contorno del tiesto.** Se dibujaban por el centro geométrico de
  la caja y, como en un fragmento deforme los dos puntos de apoyo casi nunca están a la
  misma altura, las puntas quedaban flotando en el hueco entre la pieza y la caja. El número
  siempre había salido del borde, pero el dibujo no lo mostraba y hacía pensar que se estaba
  midiendo aire. Se resolvió corriendo la cota hasta la altura donde el tiesto toca, con
  líneas de referencia finas hacia el borde para la punta que no llegara, y decidiendo el
  apoyo contra el contorno real en vez del casco convexo.

  **El cambio de definición del largo y el ancho de esta misma versión dejó todo eso sin
  objeto**: una cuerda apoya en el contorno por construcción. Se fueron las líneas de
  referencia y la maquinaria de anclaje entera (`extL`/`extW`, `distPix`, `distPoly`). Queda
  anotado porque explica por qué el código ya no las tiene, y porque la lección vale igual:
  ante una queja sobre una medida, conviene distinguir primero si el problema es el número o
  su representación.

### Cambiado

- **Se sacó el campo «Código de registro».** Servía de prefijo para los IDs y quedaba anotado
  en la hoja *Metadatos* y en el JSON, pero se leía **una sola vez, en el instante de apretar
  Detectar**: escribirlo después no renombraba nada, y como el prefijo por omisión era `T`,
  un lote podía terminar con los tiestos llamados `T-01` aunque el campo tuviera el código de
  la unidad cargado. Los tiestos son ahora siempre `T-01`, `T-02`… y el lote se identifica
  por el nombre con que se guarde la exportación.

- **Los tiestos se numeran en orden de lectura**: por hileras de arriba hacia abajo y, dentro
  de cada hilera, de izquierda a derecha. La secuencia del `.xlsx` sigue así a la fotografía y
  se puede ir tiesto por tiesto sin buscarlos. Antes el número salía del barrido de píxeles
  —que recorre la imagen fila por fila y numeraba según dónde apareciera el **primer píxel**
  de cada pieza—, así que en una misma hilera bastaba que un tiesto asomara unos píxeles más
  arriba para que se numerara antes que el que estaba a su izquierda.

  Las hileras se arman por **solapamiento vertical**: un tiesto entra en la que se está
  armando si comparte con ella más de la mitad de su propia altura. Ese criterio aguanta
  piezas de tamaños muy distintos —un fragmento chico al lado de uno grande sigue en la misma
  hilera— y no encadena hileras separadas, porque para eso el solapamiento tendría que ser
  grande de verdad. Los tiestos trazados a mano conservan su ID y van después de los
  automáticos, en el orden en que se trazaron.

- La ayuda en pantalla, la leyenda de ejes y la nota metodológica del README decían que las
  cotas «pueden pasar por fuera de la pieza porque están midiendo la caja». Ahora explican
  que la medida sale de los dos puntos del borde que tocan los lados opuestos, y qué
  significa la línea fina de referencia.

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
