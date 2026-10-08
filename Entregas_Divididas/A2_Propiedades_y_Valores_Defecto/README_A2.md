# Actividad A2: Propiedades y valores por defecto

## Enunciados Realizados:
1. Añade las propiedades `min` (por defecto 0), `max` (por defecto 10), `step` (por defecto 1) e `initialValue` (por defecto, igual a `min`).
2. Valida con `assert` que `min < max`, que `step > 0` y que `initialValue` está entre `min` y `max`.
3. El valor nunca puede salir del rango, ni siquiera en modo release (resuelto mediante `.clamp(min, max)` en la función pura `nextStepperValue`).
4. Desactiva el botón `−` en el mínimo y el botón `+` en el máximo (`onPressed: canDecrement ? () => ... : null`).
5. Añade las propiedades de texto `semanticLabel` (por defecto 'Cantidad'), `decrementTooltip` ('Restar') e `incrementTooltip` ('Sumar').
6. Añade en Widgetbook un caso "Configurable" con knobs para `min`, `max` y `step`.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación con aserciones, clamps de release, accesibilidad y tooltips.
- `lib/ui_kit_dam_widgetbook.dart`: Catálogo interactivo con knobs para min, max y step.
- `captura_A2_QuantityStepper_minimo_desactivado.png`: Captura demostrando el botón de resta desactivado en el mínimo.
