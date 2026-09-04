# Imagen de prueba

`imagen_de_prueba.png` es una **imagen sintética** (no es una fotografía de tiestos reales)
con figuras de dimensiones exactas conocidas. Sirve para dos cosas:

1. **Probar CeraMetric sin tener que fotografiar nada**, para conocer el flujo de trabajo.
2. **Verificar que la aplicación mide bien** después de tocar el código.

## Cómo usarla

1. Cargá `imagen_de_prueba.png` en CeraMetric.
2. *(Opcional, pero es el flujo recomendado.)* Con **Marcar la escala** (`X`) arrastrá un
   rectángulo que encuadre la barra de escala. La detección la va a saltear, y la aplicación
   pasa sola a **Calibrar**. Para quitar la zona, clic en la **×** de su esquina.
3. Calibrá con la herramienta **Calibrar** haciendo clic en las dos marcas verticales de
   los extremos de la barra de escala (las más largas) — se puede adentro de la zona
   marcada. Dejá **Medida real** en `5` cm. Tienen que salir **40 px/cm**.
4. En detección automática: **Aplicar** la sugerencia de Otsu (umbral 166), desenfoque 1,
   cierre 2, área mínima 0.5 cm². Apretá **Detectar**.
5. Con la escala marcada aparecen **4 piezas** y la barra de estado avisa `1 descartado(s)
   por zona excluida`. Sin marcarla aparecen **5**: la barra de escala es el falso positivo
   típico y hay que borrarla con la papelera. Se reconoce por ser una barra larga y
   fina, de color gris.

## Valores esperados

Medido con la app **v1.3** y los parámetros de arriba:

| Figura | Métrica | Valor nominal | Medido | Diferencia |
|---|---|---|---|---|
| Rectángulo (rotado 30°) | Largo | 8.50 cm | 8.52 cm | +0.02 |
| | Ancho | 5.40 cm | 5.41 cm | +0.01 |
| | Área | 45.90 cm² | 45.98 cm² | +0.2 % |
| Círculo ⌀ 4 cm | Largo · Ancho | 4.00 cm | 4.00 · 4.00 cm | 0.00 |
| | Área | 12.57 cm² | 12.56 cm² | −0.1 % |
| | Perímetro | 12.57 cm | 12.49 cm | −0.6 % |
| Triángulo (base 6 × altura 4) | Área | 12.00 cm² | 11.94 cm² | −0.5 % |
| | Largo | 6.00 cm | 5.93 cm | −0.07 |
| | Ancho | *ver la nota* | 2.68 cm | — |

> **El largo y el ancho son cuerdas del tiesto**, no lados de una caja. El largo es la
> cuerda más larga en la dirección del eje de la pieza; el ancho, la perpendicular que pasa
> por el **punto medio** del largo. En el rectángulo eso da sus dos lados (8.52 × 5.41) y no
> la diagonal.
>
> **En el triángulo el ancho da 2.68 cm y no 4.00**, y está bien: su punta no cae sobre el
> medio de la base, así que la altura *en la parte media* es menor que la altura máxima. No
> es un error, es la definición — por eso un control de calibración tiene que ser
> **rectangular**, no triangular ni redondeado.

Las diferencias de centésimas vienen del suavizado de los bordes de la imagen: el umbral
corta a mitad del degradado del borde, así que sobran o faltan fracciones de píxel. Con
40 px/cm, un píxel son 0.25 mm.

**El rectángulo está rotado 30° a propósito.** Es la prueba de que el largo y el ancho no
dependen de la orientación de la pieza en la fotografía: el eje sale del lado largo de su
caja mínima, que gira junto con la pieza. Trazando a mano ese mismo rectángulo a 0°, 30° y
75°, la aplicación devuelve exactamente los mismos números.

## Si los valores no dan

- Revisá que la calibración haya dado exactamente 40 px/cm. Si no, marcaste mal los
  extremos de la barra.
- Con un umbral muy distinto de 166 las figuras crecen o se achican y el área cambia.
