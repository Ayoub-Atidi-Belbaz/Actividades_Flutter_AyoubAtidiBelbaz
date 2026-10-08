import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepper_demo/main.dart';

void main() {
  testWidgets('Pantalla de compra de entradas carga en español y calcula el total',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    // Verificaciones iniciales en Español
    expect(find.text('Compra de Entradas'), findsOneWidget);
    expect(find.text('1 entrada'), findsOneWidget);
    expect(find.textContaining('4,50'), findsWidgets);

    // Incrementar cantidad a 2 entradas
    final addButton = find.byKey(const Key('quantity_stepper_increment'));
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    // Verificación de plural y recálculo
    expect(find.text('2 entradas'), findsOneWidget);
    expect(find.textContaining('9,00'), findsOneWidget);
  });

  testWidgets('Cambio de idioma dinámico a inglés y formateo plural',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    // Cambiar a inglés
    final toggleButton = find.byKey(const Key('toggle_language_button'));
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();

    // Verificaciones en Inglés
    expect(find.text('Ticket Purchase'), findsOneWidget);
    expect(find.text('1 ticket'), findsOneWidget);
    expect(find.text('Confirm Purchase'), findsOneWidget);

    // Incrementar a 3 tickets
    final addButton = find.byKey(const Key('quantity_stepper_increment'));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('3 tickets'), findsOneWidget);
  });

  testWidgets('Límite máximo dispara SnackBar internacionalizado',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StepperDemoApp());
    await tester.pumpAndSettle();

    final addButton = find.byKey(const Key('quantity_stepper_increment'));

    // Incrementar hasta el máximo (8)
    for (int i = 1; i < 8; i++) {
      await tester.tap(addButton);
      await tester.pump();
    }
    await tester.pumpAndSettle();

    expect(find.text('8 entradas'), findsOneWidget);

    // Intentar subir más allá del máximo debe tener el botón inactivo
    final buttonWidget = tester.widget<IconButton>(addButton);
    expect(buttonWidget.onPressed, isNull);

    // Comprobar que apareció el SnackBar
    expect(find.text('Has llegado al máximo de 8 entradas'), findsOneWidget);
  });
}
