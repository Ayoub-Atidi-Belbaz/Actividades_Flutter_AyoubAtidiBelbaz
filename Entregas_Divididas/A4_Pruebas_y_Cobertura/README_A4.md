# Actividad A4: Pruebas y Cobertura de Código

## Enunciados Realizados:
1. Función pura `nextStepperValue({required int current, required int delta, required int min, required int max})` con 4 pruebas unitarias (incremento, decremento, límite inferior y límite superior).
2. Pruebas de widget:
   - Sumar muestra el nuevo valor y emite `onChanged`.
   - Botón `−` desactivado en el mínimo.
   - `onLimitReached` recibe `StepperLimit.max`.
   - `onLimitReached` recibe `StepperLimit.min`.
   - SnackBar informativo en pantalla.
3. Prueba golden del componente con valor 5 (`goldens/quantity_stepper_5.png`).
4. Cobertura de código al 100% de `quantity_stepper.dart` verificada mediante `flutter test --coverage`.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación y función pura `nextStepperValue`.
- `test/quantity_stepper_test.dart`: Suite completa de 15 pruebas automatizadas.
- `test/goldens/quantity_stepper_5.png`: Archivo de referencia Golden con valor 5.
- `captura_A4_cobertura_y_tests.png`: Captura de consola mostrando 15/15 tests pasados y 100% de cobertura.
- `captura_A4_QuantityStepper_golden_5.png`: Renderizado exacto del Golden test.
