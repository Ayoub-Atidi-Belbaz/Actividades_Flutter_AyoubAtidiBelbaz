import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  group('A4.1 Pruebas unitarias de nextStepperValue (Función pura)', () {
    test('Incremento normal calcula el siguiente valor correctamente', () {
      final result = nextStepperValue(
        current: 3,
        delta: 1,
        min: 0,
        max: 10,
      );
      expect(result, equals(4));
    });

    test('Decremento normal calcula el valor anterior correctamente', () {
      final result = nextStepperValue(
        current: 5,
        delta: -1,
        min: 0,
        max: 10,
      );
      expect(result, equals(4));
    });

    test('Límite inferior no desborda por debajo de min (clamp)', () {
      final result = nextStepperValue(
        current: 0,
        delta: -2,
        min: 0,
        max: 10,
      );
      expect(result, equals(0));
    });

    test('Límite superior no desborda por encima de max (clamp)', () {
      final result = nextStepperValue(
        current: 10,
        delta: 3,
        min: 0,
        max: 10,
      );
      expect(result, equals(10));
    });
  });

  group('A4.2 Pruebas de widget de QuantityStepper', () {
    testWidgets('Sumar incrementa el valor en pantalla y emite onChanged',
        (WidgetTester tester) async {
      int? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 2,
                onChanged: (val) {
                  changedValue = val;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('2'), findsOneWidget);

      final addButton = find.byKey(const Key('quantity_stepper_increment'));
      await tester.tap(addButton);
      await tester.pump();

      expect(find.text('3'), findsOneWidget);
      expect(changedValue, equals(3));
    });

    testWidgets('El botón - está desactivado en el valor mínimo',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 0,
              ),
            ),
          ),
        ),
      );

      final removeButton = tester.widget<IconButton>(
        find.byKey(const Key('quantity_stepper_decrement')),
      );

      expect(removeButton.onPressed, isNull);
    });

    testWidgets('onLimitReached recibe StepperLimit.max al alcanzar el límite superior',
        (WidgetTester tester) async {
      StepperLimit? reachedLimit;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 5,
                initialValue: 4,
                onLimitReached: (limit) {
                  reachedLimit = limit;
                },
              ),
            ),
          ),
        ),
      );

      final addButton = find.byKey(const Key('quantity_stepper_increment'));
      await tester.tap(addButton);
      await tester.pump();

      expect(find.text('5'), findsOneWidget);
      expect(reachedLimit, equals(StepperLimit.max));
    });

    testWidgets('onLimitReached recibe StepperLimit.min al decrementar hasta el límite inferior',
        (WidgetTester tester) async {
      StepperLimit? reachedLimit;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 5,
                initialValue: 1,
                onLimitReached: (limit) {
                  reachedLimit = limit;
                },
              ),
            ),
          ),
        ),
      );

      final removeButton = find.byKey(const Key('quantity_stepper_decrement'));
      await tester.tap(removeButton);
      await tester.pump();

      expect(find.text('0'), findsOneWidget);
      expect(reachedLimit, equals(StepperLimit.min));
    });

    testWidgets('Muestra SnackBar con "Has llegado al máximo" en pantalla de prueba',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: QuantityStepper(
                  min: 0,
                  max: 5,
                  initialValue: 4,
                  onLimitReached: (limit) {
                    if (limit == StepperLimit.max) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Has llegado al máximo')),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      );

      final addButton = find.byKey(const Key('quantity_stepper_increment'));
      await tester.tap(addButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Has llegado al máximo'), findsOneWidget);
    });

    testWidgets('didUpdateWidget reajusta el valor si el rango cambia',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 8,
              ),
            ),
          ),
        ),
      );

      expect(find.text('8'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 5,
                initialValue: 2,
              ),
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
    });
  });

  group('Pruebas de componentes InfoBadge y StarRating', () {
    testWidgets('InfoBadge renderiza etiqueta e icono correctamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoBadge(
              label: 'Disponible',
              icon: Icons.check,
            ),
          ),
        ),
      );

      expect(find.text('Disponible'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('StarRating permite seleccionar valoración mediante tap',
        (WidgetTester tester) async {
      int? selectedRating;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StarRating(
              rating: 3,
              onRatingChanged: (rating) {
                selectedRating = rating;
              },
            ),
          ),
        ),
      );

      final fourthStar = find.byKey(const Key('star_rating_4'));
      await tester.tap(fourthStar);
      await tester.pump();

      expect(selectedRating, equals(4));
    });
  });

  group('A4.3 Prueba Golden de QuantityStepper', () {
    testWidgets('QuantityStepper golden test con valor 5',
        (WidgetTester tester) async {
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

    testWidgets('QuantityStepper golden test con valor 0 (mínimo)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: QuantityStepper(
                min: 0,
                max: 10,
                initialValue: 0,
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(QuantityStepper),
        matchesGoldenFile('goldens/quantity_stepper_0_min.png'),
      );
    });

    testWidgets('QuantityStepper golden test con SnackBar al maximo',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: QuantityStepper(
                  min: 0,
                  max: 5,
                  initialValue: 4,
                  onLimitReached: (limit) {
                    if (limit == StepperLimit.max) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Has llegado al máximo'),
                          duration: Duration(seconds: 4),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      );

      final addButton = find.byKey(const Key('quantity_stepper_increment'));
      await tester.tap(addButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/quantity_stepper_snackbar_max.png'),
      );
    });
  });
}
