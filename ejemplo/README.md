# Imagen de prueba

`imagen_de_prueba.png` es una **imagen sintética** (no es una fotografía de tiestos reales)
con figuras de dimensiones exactas conocidas. Sirve para dos cosas:

1. **Probar CeraMetric sin tener que fotografiar nada**, para conocer el flujo de trabajo.
2. **Verificar que la aplicación mide bien** después de tocar el código.

## Cómo usarla

1. Cargá `imagen_de_prueba.png` en CeraMetric.
2. Calibrá con la herramienta **Calibrar** haciendo clic en las dos marcas verticales de
   los extremos de la barra de escala (las más largas). Dejá **Medida real** en `5` cm.
   Tienen que salir **40 px/cm**.
3. En detección automática: **Aplicar** la sugerencia de Otsu (umbral 166), desenfoque 1,
   cierre 2, área mínima 0.5 cm². Apretá **Detectar**.
4. Van a aparecer **5 piezas**: las 4 figuras más la propia barra de escala. La barra es
   el falso positivo típico — borrala con la papelera. Se reconoce por la elongación alta
   (~5.5) y el color gris.

## Valores esperados

Medido con la app v1.2 y los parámetros de arriba:

| Figura | Métrica | Valor nominal | Medido | Diferencia |
|---|---|---|---|---|
| Rectángulo (rotado 30°) | **Largo rect.** | 8.50 cm | 8.53 cm | +0.03 |
| | **Ancho rect.** | 5.40 cm | 5.43 cm | +0.03 |
| | Largo *(diagonal)* | 10.07 cm | 10.06 cm | −0.01 |
| | Área | 45.90 cm² | 45.98 cm² | +0.2 % |
| Círculo ⌀ 4 cm | Largo · Ancho | 4.00 cm | 4.02 · 4.02 cm | +0.02 |
| | Área | 12.57 cm² | 12.56 cm² | −0.1 % |
| | Perímetro | 12.57 cm | 12.49 cm | −0.6 % |
| | Circularidad | 1.000 | 1.000 | 0.000 |
| Triángulo (base 6 × altura 4) | Área | 12.00 cm² | 11.94 cm² | −0.5 % |

> **Ojo con el rectángulo.** Su mayor distancia entre dos puntos es la diagonal, así que el
> par `Largo · Ancho` se va con ella y da 10.06 × 9.09. Es correcto para la definición,
> pero no son los lados. Para verificar la calibración con una figura de esquinas vivas hay
> que mirar **Largo rect.** y **Ancho rect.** Lo mismo pasa con la barra de escala
> (5.12 × 1.74 contra 5.08 × 0.93 del rectángulo). En un tiesto real, que es una forma
> redondeada, el par directo da exacto — es el caso para el que está pensado.

Las diferencias de centésimas vienen del suavizado de los bordes de la imagen: el umbral
corta a mitad del degradado del borde, así que sobran o faltan fracciones de píxel. Con
40 px/cm, un píxel son 0.25 mm.

**El rectángulo está rotado 30° a propósito.** Es la prueba de que el largo y el ancho no
dependen de la orientación de la pieza en la fotografía. Notá también que el Feret máximo
de esa figura (10.06 cm) es su **diagonal**, no su largo: por eso el largo y el ancho se
calculan con el rectángulo mínimo y el Feret se informa aparte.

**Los dos pares de medidas.** Estas figuras tienen esquinas vivas, así que son el caso malo
para el par directo y el bueno para el rectángulo mínimo. Con los tiestos pasa al revés:
son formas redondeadas, y ahí el rectángulo mínimo se queda corto en el largo mientras que
el par directo da exacto. Para verlo, trazá a mano con el **Lápiz** un polígono irregular y
más o menos redondo, y compará `Largo` con `Largo rect.` en la lista de resultados: la
diferencia puede pasar el 10 %. La nota metodológica del README principal explica cuál usar
en cada caso.

## Si los valores no dan

- Revisá que la calibración haya dado exactamente 40 px/cm. Si no, marcaste mal los
  extremos de la barra.
- Con un umbral muy distinto de 166 las figuras crecen o se achican y el área cambia.
