# MEMORIA DE PRÁCTICA: UI KIT Y COMPONENTES EN FLUTTER

**Módulo:** Diseño de Interfaces (2º DAM)  
**Alumno:** Ayoub Atidi Belbaz  
**Curso Académico:** 2026/2027  
**Proyecto:** Desarrollo de UI Kit (`ui_kit_dam`), Componente `QuantityStepper`, Widgetbook, Internacionalización y Aplicación Demo (`stepper_demo`)  

---

## 1. Resumen Ejecutivo del Proyecto

En esta práctica se ha desarrollado un ecosistema completo de interfaz de usuario en Flutter compuesto por:
1. **`ui_kit_dam`**: Paquete desacoplado de componentes reutilizables con soporte de accesibilidad, validaciones de rango seguro en tiempo de compilación y ejecución, pruebas unitarias, de widget y de regresión visual (Golden tests), con una **cobertura de código del 100%** y documentación según estándares oficiales de Dart (`public_member_api_docs`).
2. **Catálogo interactivo (Widgetbook)**: Configuración en `lib/ui_kit_dam_widgetbook.dart` con casos "Por defecto" y "Configurable" mediante *knobs*.
3. **`stepper_demo`**: Aplicación consumidora que importa el paquete fijando la etiqueta Git `v1.1.0`, con soporte integral de internacionalización en español e inglés (`app_es.arb` y `app_en.arb`), plurales automáticos, formateo de fechas y moneda según localidad, y componentes interactivos para la compra de entradas a un evento.

---

## 2. Sección A1: Primer Componente y Catálogo

### 2.1 Creación del StatefulWidget (`lib/src/quantity_stepper.dart`)
Se implementó el componente `QuantityStepper` dentro del paquete `ui_kit_dam` bajo la estructura modular `lib/src/quantity_stepper.dart`. El componente renderiza una fila (`Row`) centrada compuesta por:
- Un botón `IconButton` con el icono `Icons.remove` para decrementar.
- Un widget de texto central (`Text`) que visualiza el valor numérico actual.
- Un botón `IconButton` con el icono `Icons.add` para incrementar.

### 2.2 Lógica de incremento y decremento
La lógica inicial actualiza el estado interno invocando `setState()` al pulsar cualquiera de los dos botones, provocando la reconstrucción reactiva del árbol de widgets.

### 2.3 Exportación en `lib/ui_kit_dam.dart`
Para mantener un encapsulamiento limpio, la carpeta `src/` contiene la implementación privada mientras que el archivo barril `lib/ui_kit_dam.dart` exporta las APIs públicas:
```dart
library;

export 'src/info_badge.dart';
export 'src/quantity_stepper.dart';
export 'src/star_rating.dart';
```

### 2.4 Catálogo Widgetbook - Caso "Por defecto"
En `lib/ui_kit_dam_widgetbook.dart` se estructuró el catálogo de componentes registrando `QuantityStepper`:
```dart
WidgetbookUseCase(
  name: 'Por defecto',
  builder: (context) => const Center(
    child: QuantityStepper(),
  ),
),
```

### 2.5 Cuestión Teórica para la Memoria: ¿Por qué este componente es un StatefulWidget e InfoBadge no?
> **Respuesta:**  
> **`QuantityStepper` es un `StatefulWidget`** porque su propósito fundamental implica la gestión de un **estado interno mutable** (`_value`) que evoluciona a lo largo del tiempo de vida del widget como respuesta a las interacciones directas del usuario (pulsaciones en los botones de suma y resta). Para reflejar visualmente este cambio en la pantalla sin depender de que un widget padre reconstruya todo el árbol externo, el objeto de estado asociado (`State<QuantityStepper>`) invoca `setState()`, lo que marca dicho elemento como "sucio" (*dirty*) y desencadena una nueva ejecución del método `build()`.
>
> Por el contrario, **`InfoBadge` es un `StatelessWidget`** debido a que es un componente **puramente presentacional e inmutable**. Recibe sus parámetros de configuración (`label`, `icon`, `backgroundColor`, etc.) a través de su constructor y los dibuja tal como fueron suministrados. `InfoBadge` no almacena variables internas que cambien tras ser instanciado ni necesita ciclo de vida interactivo propio; si sus datos cambian, es porque un ancestro en el árbol se reconstruyó y le proporcionó nuevas propiedades.

---

## 3. Sección A2: Propiedades y Valores por Defecto

### 3.1 Propiedades y validaciones en desarrollo (`assert`)
El constructor de `QuantityStepper` incorpora validaciones estrictas en desarrollo mediante aserciones (`assert`) que previenen configuraciones incoherentes:
- `min < max`: Garantiza que el rango tenga sentido lógico.
- `step > 0`: Evita pasos nulos o negativos que provocarían bucles o comportamientos erráticos.
- `(initialValue ?? min) >= min && (initialValue ?? min) <= max`: Asegura que el valor inicial esté contenido en el intervalo delimitado.

```dart
class QuantityStepper extends StatefulWidget {
  const QuantityStepper({
    super.key,
    this.min = 0,
    this.max = 10,
    this.step = 1,
    int? initialValue,
    this.semanticLabel = 'Cantidad',
    this.decrementTooltip = 'Restar',
    this.incrementTooltip = 'Sumar',
    this.onChanged,
    this.onLimitReached,
  })  : initialValue = initialValue ?? min,
        assert(min < max, 'min debe ser menor que max'),
        assert(step > 0, 'step debe ser mayor que 0'),
        assert(
          (initialValue ?? min) >= min && (initialValue ?? min) <= max,
          'initialValue debe estar entre min y max',
        );
```

### 3.2 Seguridad de rango en modo Release
En compilaciones de producción (`release`), las aserciones de Dart son omitidas por el compilador para optimizar el rendimiento. Para asegurar de forma infalible que el valor **nunca desborde** los límites permitidos en ningún entorno, se utiliza la función pura `nextStepperValue` que aplica el método `.clamp(widget.min, widget.max)`:
```dart
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  return (current + delta).clamp(min, max);
}
```

### 3.3 Desactivación condicional de botones en los extremos
En el método `build`, se calcula el estado de disponibilidad de cada botón:
```dart
final bool canDecrement = _value > widget.min;
final bool canIncrement = _value < widget.max;

IconButton(
  key: const Key('quantity_stepper_decrement'),
  icon: const Icon(Icons.remove),
  tooltip: widget.decrementTooltip,
  onPressed: canDecrement ? () => _updateValue(-widget.step) : null,
),
// ...
IconButton(
  key: const Key('quantity_stepper_increment'),
  icon: const Icon(Icons.add),
  tooltip: widget.incrementTooltip,
  onPressed: canIncrement ? () => _updateValue(widget.step) : null,
),
```
Cuando `canDecrement` o `canIncrement` es `false`, `onPressed` recibe `null`, lo que desactiva visual y funcionalmente el botón en Material Design.

### 3.4 Accesibilidad y Semántica
El componente envuelve su interfaz con el widget `Semantics`:
- Asigna la propiedad `semanticLabel` para lectores de pantalla como TalkBack o VoiceOver.
- Atribuye `tooltip` contextual tanto al botón de resta (`decrementTooltip`) como al botón de suma (`incrementTooltip`).

### 3.5 Caso "Configurable" con Knobs en Widgetbook
En `lib/ui_kit_dam_widgetbook.dart` se habilitó el caso con controles interactivos:
```dart
WidgetbookUseCase(
  name: 'Configurable',
  builder: (context) => Center(
    child: QuantityStepper(
      min: context.knobs.int.input(label: 'Min', initialValue: 0),
      max: context.knobs.int.input(label: 'Max', initialValue: 10),
      step: context.knobs.int.input(label: 'Step', initialValue: 1),
    ),
  ),
),
```

---

## 4. Sección A3: Eventos Propios

### 4.1 Definición de tipos y callbacks
Para notificar eventos hacia el exterior de forma desacoplada, se definieron los tipos correspondientes:
```dart
/// Límite alcanzado por el componente [QuantityStepper].
enum StepperLimit {
  /// Límite inferior alcanzado ([QuantityStepper.min]).
  min,

  /// Límite superior alcanzado ([QuantityStepper.max]).
  max,
}

/// Callback invocado cuando [QuantityStepper] alcanza su valor mínimo o máximo.
typedef LimitReached = void Function(StepperLimit limit);
```

### 4.2 Control de emisión estricto
Se diseñó el método `_updateValue` para evitar emisiones innecesarias:
1. Si el nuevo valor resultante coincide con el valor actual, la función retorna inmediatamente sin alterar el estado ni emitir callbacks.
2. Si cambia, se actualiza el estado interno con `setState()`.
3. Se invoca `widget.onChanged?.call(_value)`.
4. Si el nuevo valor coincide con `widget.min`, se emite `widget.onLimitReached?.call(StepperLimit.min)`.
5. Si el nuevo valor coincide con `widget.max`, se emite `widget.onLimitReached?.call(StepperLimit.max)`.

### 4.3 Demostración con SnackBar
En la aplicación demo y en las pruebas de widget, al dispararse `StepperLimit.max` se despliega un mensaje informativo flotante:
```dart
QuantityStepper(
  min: 1,
  max: 8,
  onLimitReached: (limit) {
    if (limit == StepperLimit.max) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Has llegado al máximo de 8 entradas')),
      );
    }
  },
)
```

---

## 5. Sección A4: Pruebas y Cobertura de Código

### 5.1 Pruebas unitarias de la función pura (`nextStepperValue`)
Se diseñaron cuatro pruebas unitarias en `test/quantity_stepper_test.dart`:
1. **Incremento normal:** Comprueba que `nextStepperValue(current: 3, delta: 1, min: 0, max: 10) == 4`.
2. **Decremento normal:** Comprueba que `nextStepperValue(current: 5, delta: -1, min: 0, max: 10) == 4`.
3. **Límite inferior:** Comprueba que `nextStepperValue(current: 0, delta: -2, min: 0, max: 10) == 0`.
4. **Límite superior:** Comprueba que `nextStepperValue(current: 10, delta: 3, min: 0, max: 10) == 10`.

### 5.2 Pruebas de widget
Se desarrollaron casos de prueba automatizados con `WidgetTester`:
1. Comprobación de que la pulsación del botón `+` incrementa el texto renderizado en pantalla y emite `onChanged` con el nuevo valor.
2. Comprobación de que en el valor mínimo el botón `-` queda inactivo (`removeButton.onPressed == null`).
3. Comprobación de que `onLimitReached` recibe `StepperLimit.max` al pulsar hasta el tope.
4. Comprobación de que `onLimitReached` recibe `StepperLimit.min` al decrementar hasta el valor base.
5. Comprobación del SnackBar informativo en pantalla.
6. Comprobación de reajuste dinámico mediante `didUpdateWidget`.
7. Pruebas de renderizado para `InfoBadge` y pulsación interactiva en `StarRating`.

### 5.3 Prueba de regresión visual (Golden Test)
Se incorporó el test Golden para asegurar que la apariencia del componente con valor 5 permanece visualmente idéntica ante futuras modificaciones:
```dart
testWidgets('QuantityStepper golden test con valor 5', (WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: QuantityStepper(
            min: 0,
            max: 10,
            initialValue: 5,
          ),
        ),
      ),
    ),
  );

  await expectLater(
    find.byType(QuantityStepper),
    matchesGoldenFile('goldens/quantity_stepper_5.png'),
  );
});
```
El archivo de referencia se generó exitosamente con `flutter test --update-goldens` y se almacena en `test/goldens/quantity_stepper_5.png`.

### 5.4 Métricas de Cobertura de Código (`flutter test --coverage`)
Tras ejecutar `flutter test --coverage`, la lectura de `coverage/lcov.info` arrojó las siguientes métricas exactas:
```text
SF:lib\src\quantity_stepper.dart | LF:49 | LH:49 (100.0% de cobertura)
SF:lib\src\info_badge.dart       | LF:15 | LH:15 (100.0% de cobertura)
SF:lib\src\star_rating.dart      | LF:15 | LH:15 (100.0% de cobertura)
```
**Resultado global:** **100% de líneas cubiertas por pruebas automatizadas.**

---

## 6. Sección A5: Documentación y Análisis Estático

### 6.1 Documentación con `///` y ejemplos
Todos los elementos públicos de la librería (clases, constructores, atributos, getters, funciones auxiliares, enums y typedefs) han sido documentados exhaustivamente con formato Markdown de Dartdoc, incluyendo bloques de código de ejemplo (`/// ```dart ... ````).

### 6.2 Regla `public_member_api_docs`
En `analysis_options.yaml` se habilitó formalmente la regla:
```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - public_member_api_docs
```
Al ejecutar `dart analyze`, el resultado es:
```text
Analyzing ui_kit_dam...
No issues found!
```

### 6.3 Generación de documentación HTML con `dartdoc`
Se ejecutó la herramienta `dartdoc` vinculando el SDK de Dart y Flutter, generando el sitio estático de documentación en `doc/api/`:
- Documentó 2 librerías públicas (`ui_kit_dam` y `ui_kit_dam_widgetbook`).
- Generó la página específica para el componente: `doc/api/ui_kit_dam/QuantityStepper-class.html`.
- Resultado del proceso: **0 warnings, 0 errors**.

### 6.4 Actualización de `README.md`
El archivo `README.md` incluye una guía de inicio rápido, tabla de propiedades, ejemplos funcionales en Dart, comandos de Widgetbook y guía de ejecución de tests.

---

## 7. Sección A6: Empaquetado y Publicación en Seco

### 7.1 Versión 1.1.0 y CHANGELOG.md
- Se actualizó `pubspec.yaml` a la versión `1.1.0`.
- Se redactó `CHANGELOG.md` documentando de forma estructurada todas las novedades (QuantityStepper, StarRating, InfoBadge, Widgetbook, Golden tests y accesibilidad).

### 7.2 Repositorio Git y Etiquetado de Versión
Se inicializó el repositorio Git en la carpeta del paquete y se fijó el release:
```bash
git init
git add .
git commit -m "feat: add QuantityStepper component v1.1.0"
git tag v1.1.0
git remote add origin https://github.com/Ayoub-Atidi-Belbaz/ui_kit_dam.git
```

### 7.3 Configuración en la aplicación `stepper_demo`
En `stepper_demo/pubspec.yaml`, se declaró la dependencia consumiendo directamente el repositorio Git y fijando la etiqueta de versión:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
  ui_kit_dam:
    git:
      url: ../ui_kit_dam
      ref: v1.1.0
```

### 7.4 Publicación en seco (`flutter pub publish --dry-run`)
Se ejecutó `flutter pub publish --dry-run` para validar las directrices oficiales de publicación en Pub.dev.
**Resultado obtenido:**
```text
Publishing ui_kit_dam 1.1.0 to https://pub.dev:
├── CHANGELOG.md (1 KB)
├── LICENSE (1 KB)
├── README.md (3 KB)
├── analysis_options.yaml (<1 KB)
├── lib
│   ├── src
│   │   ├── info_badge.dart (1 KB)
│   │   ├── quantity_stepper.dart (5 KB)
│   │   └── star_rating.dart (2 KB)
│   ├── ui_kit_dam.dart (<1 KB)
│   └── ui_kit_dam_widgetbook.dart (2 KB)
├── pubspec.yaml (<1 KB)
└── test
    ├── goldens
    │   └── quantity_stepper_5.png (3 KB)
    └── quantity_stepper_test.dart (7 KB)

Total compressed archive size: 8 KB.
Validating package...
Package has 0 warnings.
```
El paquete se validó con **0 avisos y 0 errores**, cumpliendo con todas las normas de licencia (MIT), descripción de metadatos, límites de tamaño y estructura recomendada.

---

## 8. Sección A7: Aplicación Internacionalizada (`stepper_demo`)

### 8.1 Configuración de Internacionalización (i18n)
Se creó `stepper_demo/l10n.yaml`:
```yaml
arb-dir: lib/l10n
template-arb-file: app_es.arb
output-localization-file: app_localizations.dart
output-dir: lib/l10n/generated
synthetic-package: false
```
Y se generaron los archivos de recursos en español e inglés:
- `lib/l10n/app_es.arb`: Idioma plantilla con traducciones al español.
- `lib/l10n/app_en.arb`: Traducción completa al inglés.

### 8.2 Pantalla de Compra de Entradas
Se diseñó una pantalla moderna con Material 3 en `stepper_demo/lib/main.dart` que integra:
1. **QuantityStepper:** Configurado con límite mínimo de 1 y máximo de 8 entradas (`min: 1`, `max: 8`).
2. **StarRating:** Componente de 5 estrellas interactivas para que el usuario valore el interés en el evento.
3. **InfoBadge:** Indicador visual de estado ("En venta" / "On sale").

### 8.3 Textos Traducidos, Formateo Plural y Moneda
- **Plurales en ARB:**
  ```arb
  "ticketCount": "{count, plural, =1{1 entrada} other{{count} entradas}}"
  ```
  En inglés:
  ```arb
  "ticketCount": "{count, plural, =1{1 ticket} other{{count} tickets}}"
  ```
- **Precio Total y Formato de Moneda:**
  El precio por entrada es de 4,50 €. Se calcula `total = _ticketCount * 4.50` y se formatea mediante `NumberFormat.currency(locale: locale.languageCode, symbol: '€')`.
- **Formateo de Fecha del Evento:**
  La fecha (`28 de noviembre de 2026`) se formatea dinámicamente con `DateFormat.yMMMMEEEEd(locale.languageCode)`.

### 8.4 Accesibilidad Integrada
Las propiedades semánticas y tooltips del stepper se vinculan directamente a los textos traducidos:
```dart
QuantityStepper(
  min: 1,
  max: 8,
  step: 1,
  initialValue: _ticketCount,
  semanticLabel: l10n.stepperSemanticLabel,
  decrementTooltip: l10n.stepperDecrementTooltip,
  incrementTooltip: l10n.stepperIncrementTooltip,
  onChanged: (newCount) => setState(() => _ticketCount = newCount),
  onLimitReached: (limit) {
    final message = limit == StepperLimit.max
        ? l10n.limitReachedMax
        : l10n.limitReachedMin;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  },
)
```

### 8.5 Selector Dinámico y Capturas de Pantalla
La aplicación cuenta con un botón en la AppBar para alternar entre Español (ES) e Inglés (EN) al instante.  
Se ejecutaron pruebas de regresión visual que capturaron la pantalla en ambos idiomas:
- **Español:** `stepper_demo/test/goldens/compra_entradas_es.png`
- **Inglés:** `stepper_demo/test/goldens/compra_entradas_en.png`

---

## 9. Instrucciones de Ejecución y Verificación

### 9.1 En el paquete `ui_kit_dam`:
```bash
cd "C:\Users\DAM2P\Downloads\Diseño de Interfaces\ui_kit_dam"

# 1. Comprobar linter y documentación estricta:
dart analyze

# 2. Ejecutar todas las pruebas unitarias, de widget y golden:
flutter test

# 3. Comprobar cobertura de código al 100%:
flutter test --coverage

# 4. Validar empaquetado pub con 0 avisos:
flutter pub publish --dry-run
```

### 9.2 En la aplicación `stepper_demo`:
```bash
cd "C:\Users\DAM2P\Downloads\Diseño de Interfaces\stepper_demo"

# 1. Regenerar localizaciones si se modifican los archivos .arb:
flutter gen-l10n

# 2. Ejecutar pruebas automatizadas de internacionalización y plurales:
flutter test

# 3. Lanzar la aplicación en Windows, Chrome o emulador Android:
flutter run
```

---
*Fin del documento de memoria.*
