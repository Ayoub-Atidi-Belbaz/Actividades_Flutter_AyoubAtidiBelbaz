import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepper_demo/main.dart';

void main() {
  testWidgets('Captura de pantalla en Español (Compra de entradas)',
      (WidgetTester tester) async {
    // Definir tamaño de ventana tipo móvil/tablet
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/compra_entradas_es.png'),
    );
  });

  testWidgets('Captura de pantalla en Inglés (Ticket purchase)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    // Cambiar a inglés
    final toggleButton = find.byKey(const Key('toggle_language_button'));
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();

    // Incrementar a 3 tickets para mostrar plural en inglés
    final addButton = find.byKey(const Key('quantity_stepper_increment'));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/compra_entradas_en.png'),
    );
  });
}
