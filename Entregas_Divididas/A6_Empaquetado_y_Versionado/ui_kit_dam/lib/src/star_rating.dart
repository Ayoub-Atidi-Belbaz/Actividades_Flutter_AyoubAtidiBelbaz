import 'package:flutter/material.dart';

/// Componente para mostrar y seleccionar una puntuación mediante estrellas.
///
/// Permite visualizar una valoración de 1 a [maxRating] estrellas y emitir
/// un evento [onRatingChanged] cuando el usuario pulsa sobre cualquiera de ellas.
///
/// ```dart
/// StarRating(
///   rating: 4,
///   maxRating: 5,
///   onRatingChanged: (newRating) => print('Rating: $newRating'),
/// )
/// ```
class StarRating extends StatelessWidget {
  /// Crea un selector de valoración mediante estrellas.
  ///
  /// * [rating] indica el número actual de estrellas seleccionadas.
  /// * [maxRating] número total de estrellas (por defecto 5).
  /// * [starSize] tamaño en píxeles de cada estrella.
  /// * [activeColor] color de las estrellas marcadas.
  /// * [inactiveColor] color de las estrellas desmarcadas.
  /// * [onRatingChanged] callback ejecutado cuando el usuario selecciona una estrella.
  const StarRating({
    super.key,
    this.rating = 0,
    this.maxRating = 5,
    this.starSize = 28.0,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.onRatingChanged,
  })  : assert(rating >= 0 && rating <= maxRating, 'rating debe estar entre 0 y maxRating'),
        assert(maxRating > 0, 'maxRating debe ser mayor que 0');

  /// Valoración numérica actual (entre 0 y [maxRating]).
  final int rating;

  /// Número máximo de estrellas disponibles.
  final int maxRating;

  /// Tamaño en píxeles de cada icono de estrella.
  final double starSize;

  /// Color de relleno para las estrellas seleccionadas.
  final Color activeColor;

  /// Color de relleno para las estrellas no seleccionadas.
  final Color inactiveColor;

  /// Callback emitido cuando el usuario selecciona una puntuación.
  final ValueChanged<int>? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starIndex = index + 1;
        final isFilled = starIndex <= rating;

        return IconButton(
          key: Key('star_rating_$starIndex'),
          iconSize: starSize,
          padding: const EdgeInsets.all(2.0),
          constraints: const BoxConstraints(),
          icon: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: isFilled ? activeColor : inactiveColor,
          ),
          onPressed: onRatingChanged != null ? () => onRatingChanged!(starIndex) : null,
          tooltip: '$starIndex de $maxRating estrellas',
        );
      }),
    );
  }
}
