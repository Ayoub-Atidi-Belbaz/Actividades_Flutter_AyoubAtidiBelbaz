import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

/// Punto de entrada del catálogo de componentes interactivo con Widgetbook.
void main() {
  runApp(const WidgetbookApp());
}

/// Aplicación principal de catálogo y visualización de componentes con Widgetbook.
class WidgetbookApp extends StatelessWidget {
  /// Crea una instancia del catálogo Widgetbook.
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookFolder(
          name: 'Componentes UI',
          children: [
            WidgetbookComponent(
              name: 'QuantityStepper',
              useCases: [
                WidgetbookUseCase(
                  name: 'Por defecto',
                  builder: (context) => const Center(
                    child: QuantityStepper(),
                  ),
                ),
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
              ],
            ),
            WidgetbookComponent(
              name: 'InfoBadge',
              useCases: [
                WidgetbookUseCase(
                  name: 'Por defecto',
                  builder: (context) => const Center(
                    child: InfoBadge(
                      label: 'Disponible',
                      icon: Icons.check_circle,
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'StarRating',
              useCases: [
                WidgetbookUseCase(
                  name: 'Por defecto',
                  builder: (context) => Center(
                    child: StarRating(
                      rating: 4,
                      onRatingChanged: (_) {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
