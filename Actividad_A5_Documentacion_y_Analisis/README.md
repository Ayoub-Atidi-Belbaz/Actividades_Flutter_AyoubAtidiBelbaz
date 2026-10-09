# UI Kit DAM

Biblioteca de componentes de interfaz de usuario para Flutter, desarrollada para el módulo de **Diseño de Interfaces (DAM)**. Proporciona componentes modulares, reactivos, accesibles y testeados.

---

## Componentes Disponibles

### 1. `QuantityStepper`

Un selector numérico reactivo que permite aumentar o disminuir un valor dentro de un rango predefinido con validaciones estrictas y soporte semántico para accesibilidad.

#### Ejemplo de uso básico

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

class ContadorEntradas extends StatelessWidget {
  const ContadorEntradas({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QuantityStepper(
        min: 1,
        max: 8,
        step: 1,
        initialValue: 1,
        semanticLabel: 'Número de entradas',
        decrementTooltip: 'Quitar entrada',
        incrementTooltip: 'Añadir entrada',
        onChanged: (nuevaCantidad) {
          debugPrint('Cantidad seleccionada: $nuevaCantidad');
        },
        onLimitReached: (limite) {
          if (limite == StepperLimit.max) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Has alcanzado el límite máximo de 8 entradas.')),
            );
          }
        },
      ),
    );
  }
}
```

#### Propiedades principales

| Propiedad | Tipo | Por defecto | Descripción |
|---|---|---|---|
| `min` | `int` | `0` | Límite inferior permitido. |
| `max` | `int` | `10` | Límite superior permitido. |
| `step` | `int` | `1` | Incremento/decremento por pulsación. |
| `initialValue` | `int?` | `min` | Valor inicial del contador. |
| `semanticLabel` | `String` | `'Cantidad'` | Etiqueta semántica para lectores de pantalla. |
| `decrementTooltip`| `String` | `'Restar'` | Mensaje contextual para el botón `-`. |
| `incrementTooltip`| `String` | `'Sumar'` | Mensaje contextual para el botón `+`. |
| `onChanged` | `ValueChanged<int>?` | `null` | Emite el nuevo valor únicamente si cambia. |
| `onLimitReached` | `LimitReached?` | `null` | Emite `StepperLimit.min` o `StepperLimit.max` al tocar límites. |

---

### 2. `InfoBadge`

Insignia informativa inmutable (`StatelessWidget`) para mostrar estados, etiquetas o categorías.

```dart
InfoBadge(
  label: 'En stock',
  icon: Icons.check_circle,
  backgroundColor: Colors.green.shade100,
  textColor: Colors.green.shade900,
)
```

---

### 3. `StarRating`

Control de valoración interactivo con estrellas (1 a 5) configurable.

```dart
StarRating(
  rating: 4,
  maxRating: 5,
  onRatingChanged: (nuevaNota) {
    debugPrint('Nueva valoración: $nuevaNota');
  },
)
```

---

## Catálogo de componentes (Widgetbook)

Para explorar interactivamente los componentes y ajustar sus propiedades con *knobs*, ejecuta:

```bash
flutter run lib/ui_kit_dam_widgetbook.dart
```

---

## Pruebas y Cobertura

Para ejecutar las pruebas unitarias, de widget y de regresión visual (Golden tests):

```bash
flutter test
```

Para actualizar los archivos Golden:

```bash
flutter test --update-goldens
```

Para generar el informe de cobertura:

```bash
flutter test --coverage
```
