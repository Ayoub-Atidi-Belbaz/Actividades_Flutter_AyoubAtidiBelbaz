import 'package:flutter/material.dart';

/// Límite alcanzado por el componente [QuantityStepper].
enum StepperLimit {
  /// Límite inferior alcanzado ([QuantityStepper.min]).
  min,

  /// Límite superior alcanzado ([QuantityStepper.max]).
  max,
}

/// Callback invocado cuando [QuantityStepper] alcanza su valor mínimo o máximo.
typedef LimitReached = void Function(StepperLimit limit);

/// Calcula el siguiente valor dentro de los límites estrictos [min] y [max].
///
/// La función es pura, inmutable y determinista, garantizando que el resultado
/// nunca sobrepase los límites, incluso en modo release.
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  return (current + delta).clamp(min, max);
}

/// Un componente interactivo para seleccionar y modificar una cantidad numérica.
///
/// Dispone de dos botones de acción (restar y sumar) y un valor textual central.
/// Desactiva automáticamente las acciones que superarían los límites permitidos
/// y notifica los cambios mediante eventos desacoplados.
///
/// ```dart
/// QuantityStepper(
///   min: 0,
///   max: 10,
///   step: 1,
///   initialValue: 2,
///   onChanged: (val) => print('Nuevo valor: $val'),
///   onLimitReached: (limit) => print('Límite alcanzado: $limit'),
/// )
/// ```
class QuantityStepper extends StatefulWidget {
  /// Crea un selector de cantidad numérico.
  ///
  /// * [min] define el límite inferior permitido (por defecto `0`).
  /// * [max] define el límite superior permitido (por defecto `10`).
  /// * [step] define el incremento o decremento por pulsación (por defecto `1`).
  /// * [initialValue] define el valor de inicio (por defecto igual a [min]).
  /// * [semanticLabel] etiqueta de accesibilidad del valor central.
  /// * [decrementTooltip] texto de ayuda para el botón de resta.
  /// * [incrementTooltip] texto de ayuda para el botón de suma.
  /// * [onChanged] callback ejecutado cuando el valor numérico cambia.
  /// * [onLimitReached] callback ejecutado al alcanzar el límite inferior o superior.
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

  /// Límite inferior permitido.
  final int min;

  /// Límite superior permitido.
  final int max;

  /// Cantidad que se suma o resta en cada pulsación.
  final int step;

  /// Valor inicial con el que arranca el selector.
  final int initialValue;

  /// Etiqueta semántica de accesibilidad para lectores de pantalla.
  final String semanticLabel;

  /// Texto explicativo (tooltip) para el botón de decrementar.
  final String decrementTooltip;

  /// Texto explicativo (tooltip) para el botón de incrementar.
  final String incrementTooltip;

  /// Callback invocado cuando el valor numérico cambia de manera efectiva.
  final ValueChanged<int>? onChanged;

  /// Callback invocado al alcanzar el valor mínimo o el valor máximo.
  final LimitReached? onLimitReached;

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(widget.min, widget.max);
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.min != oldWidget.min || widget.max != oldWidget.max) {
      final clamped = _value.clamp(widget.min, widget.max);
      if (clamped != _value) {
        _value = clamped;
      }
    }
  }

  void _updateValue(int delta) {
    final newValue = nextStepperValue(
      current: _value,
      delta: delta,
      min: widget.min,
      max: widget.max,
    );

    if (newValue == _value) {
      return;
    }

    setState(() {
      _value = newValue;
    });

    widget.onChanged?.call(_value);

    if (_value == widget.min) {
      widget.onLimitReached?.call(StepperLimit.min);
    } else if (_value == widget.max) {
      widget.onLimitReached?.call(StepperLimit.max);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = _value > widget.min;
    final bool canIncrement = _value < widget.max;

    final theme = Theme.of(context);

    return Semantics(
      label: widget.semanticLabel,
      value: '$_value',
      container: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            key: const Key('quantity_stepper_decrement'),
            icon: const Icon(Icons.remove),
            tooltip: widget.decrementTooltip,
            onPressed: canDecrement ? () => _updateValue(-widget.step) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_value',
              key: const Key('quantity_stepper_value'),
              style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ) ??
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            key: const Key('quantity_stepper_increment'),
            icon: const Icon(Icons.add),
            tooltip: widget.incrementTooltip,
            onPressed: canIncrement ? () => _updateValue(widget.step) : null,
          ),
        ],
      ),
    );
  }
}
