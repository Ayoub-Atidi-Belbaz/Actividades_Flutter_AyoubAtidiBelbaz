# Actividad A3: Eventos propios

## Enunciados Realizados:
1. Añade un evento `ValueChanged<int>? onChanged` que se emita con el nuevo valor cada vez que cambie.
2. Define un enum `StepperLimit { min, max }` y un typedef `LimitReached = void Function(StepperLimit limit);`.
3. Añade un evento `LimitReached? onLimitReached` que se emita cuando el valor llegue al mínimo o al máximo.
4. Ningún evento se emite si el valor no cambia (validación previa en `_updateValue`).
5. En una pantalla de prueba, muestra un SnackBar con el texto "Has llegado al máximo" al alcanzar el límite superior.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Definición del enum, typedef y lógica de emisión de eventos.
- `captura_A3_QuantityStepper_SnackBar_maximo.png`: Captura de pantalla verificando el SnackBar flotante al alcanzar el máximo.
