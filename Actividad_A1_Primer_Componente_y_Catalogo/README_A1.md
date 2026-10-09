# Actividad A1: Primer componente y catálogo

## Enunciados Realizados:
1. En `lib/src/quantity_stepper.dart` crea un `StatefulWidget` llamado `QuantityStepper` que muestre en una fila un `IconButton` con `Icons.remove`, el valor actual (empieza en 0) y un `IconButton` con `Icons.add`.
2. Al pulsar `+` el valor sube 1; al pulsar `−` baja 1.
3. Expórtalo desde `lib/ui_kit_dam.dart`.
4. Añade en Widgetbook un componente `QuantityStepper` con el caso de uso "Por defecto".
5. Responde en tu memoria: ¿por qué este componente es un `StatefulWidget` y `InfoBadge` no?

## Respuesta a la Cuestión Teórica (Punto 5):
> **`QuantityStepper` es un `StatefulWidget`** porque necesita gestionar un **estado mutable interno** (`_value`) que cambia reactivamente con la interacción del usuario (pulsaciones en `+` y `−`). Al llamar a `setState()`, el framework reconstruye la interfaz mostrando el nuevo número sin necesidad de que el padre intervenga.
> 
> En cambio, **`InfoBadge` es un `StatelessWidget`** porque es puramente **inmutable y presentacional**. Recibe sus datos (`label`, `icon`, color) mediante el constructor y no mantiene ninguna variable que cambie con el tiempo tras ser renderizado.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación del componente.
- `lib/ui_kit_dam.dart`: Archivo barril con exportación pública.
- `lib/ui_kit_dam_widgetbook.dart`: Catálogo Widgetbook con caso de uso "Por defecto".
- `captura_A1_QuantityStepper_inicial.png`: Captura del componente en estado inicial.
