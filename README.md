# CeraMetric v1.0

**Herramienta de análisis morfométrico de tiestos cerámicos**

Desarrollada en el [LATDAA](https://latdaa.com.ar) — Laboratorio de Tecnologías Digitales Aplicadas a la Arqueología  
Dr. Emilio A. Villafañez · Escuela de Arqueología · Universidad Nacional de Catamarca · Fundación de Historia Natural Félix de Azara · CONICET

---

## ¿Qué es CeraMetric?

CeraMetric es una aplicación web de código abierto que permite medir morfométricamente fragmentos cerámicos (tiestos) a partir de fotografías con escala gráfica. Funciona completamente en el navegador, sin necesidad de instalación ni conexión a internet.

## Funciones principales

- **Calibración de escala** — clic sobre la escala gráfica de la fotografía para establecer la relación px/cm
- **Detección automática** — segmentación por umbral con pre-procesamiento (blur gaussiano, cierre morfológico, relleno de agujeros, Otsu automático)
- **Selección manual** — trazado de polígonos a mano sobre cada tiesto
- **Herramienta de recorte** — recorte de la imagen directamente en la aplicación
- **Eliminación individual** — borrar tiestos detectados erróneamente (escala gráfica, sombras, etc.)
- **Zoom y navegación** — rueda del mouse, botones de zoom, modo mover
- **Métricas calculadas:**
  - Área (cm²) — conteo de píxeles / px·cm⁻²
  - Perímetro (cm) — aristas 4-conectadas entre foreground y fondo
  - Circularidad — 4π·A / P²
  - Elongación — L / W del bounding box
  - Solidez — A / A_bbox
  - Dimensiones del bounding box (cm)
  - Color promedio (hex)
- **Exportación** — CSV, JSON, Excel (.xlsx), imagen anotada

## Uso

1. Abrí `index.html` en cualquier navegador moderno (Chrome, Firefox, Edge)
2. Cargá una fotografía con escala gráfica y fondo neutro
3. Calibrá la escala haciendo clic en los dos extremos de la escala gráfica
4. Detectá automáticamente o trazá los tiestos a mano
5. Eliminá los falsos positivos con el ícono de papelera en cada tiesto
6. Exportá los datos

## Atajos de teclado

| Tecla | Función |
|-------|---------|
| `H` | Herramienta mover |
| `C` | Herramienta calibrar |
| `M` | Selección manual |
| `R` | Recortar imagen |
| `+` / `-` | Zoom |
| `Ctrl` | Fijar línea horizontal/vertical (durante calibración) |
| `Enter` | Confirmar recorte |
| `Esc` | Cancelar / volver a mover |

## Tecnologías

- HTML5 Canvas API (procesamiento de imagen)
- JavaScript puro (sin frameworks)
- [SheetJS](https://sheetjs.com/) para exportación Excel
- Tipografías: Cormorant Garamond, DM Sans, DM Mono (Google Fonts)

## Notas metodológicas

El **perímetro** se calcula contando aristas 4-conectadas entre píxeles de foreground y fondo (no píxeles borde), lo que da una medida geométricamente correcta para formas rasterizadas. El **área** se calcula por conteo directo de píxeles dividido por px·cm⁻².

Para mejores resultados, fotografiar los tiestos sobre fondo blanco o neutro, con iluminación uniforme sin sombras fuertes, y con la escala gráfica en el mismo plano focal que los tiestos.

## Citación

Si utilizás CeraMetric en tu investigación, por favor citalo como:

> Villafañez, E.A. (2025). *CeraMetric v1.0: herramienta de análisis morfométrico de tiestos cerámicos*. LATDAA, Escuela de Arqueología, Universidad Nacional de Catamarca. https://github.com/LATDAA/cerametric

## Licencia

MIT License — libre uso, modificación y distribución con atribución.

---

*LATDAA · Escuela de Arqueología · UNCa · CONICET · Fundación de Historia Natural Félix de Azara*
