import 'package:flutter/material.dart';

/// Un componente presentacional (StatelessWidget) para mostrar etiquetas informativas.
///
/// A diferencia de los componentes interactivos de estado mutable, [InfoBadge]
/// es puramente presentacional: recibe sus propiedades de forma inmutable
/// y las dibuja sin almacenar ni modificar estado interno.
///
/// ```dart
/// const InfoBadge(
///   label: 'En stock',
///   icon: Icons.check_circle,
///   backgroundColor: Colors.green,
/// )
/// ```
class InfoBadge extends StatelessWidget {
  /// Crea una insignia o distintivo informativo inmutable.
  const InfoBadge({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  /// Texto que se muestra dentro de la insignia.
  final String label;

  /// Icono opcional que acompaña al texto.
  final IconData? icon;

  /// Color de fondo de la insignia.
  final Color? backgroundColor;

  /// Color del texto y del icono.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fg = textColor ?? theme.colorScheme.onPrimaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
