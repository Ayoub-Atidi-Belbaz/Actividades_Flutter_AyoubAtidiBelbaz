// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Compra de Entradas';

  @override
  String get eventTitle => 'Festival de Música DAM 2026';

  @override
  String get eventDateLabel => 'Fecha del evento';

  @override
  String ticketCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entradas',
      one: '1 entrada',
    );
    return '$_temp0';
  }

  @override
  String get unitPriceLabel => 'Precio unitario: 4,50 €';

  @override
  String totalPrice(String total) {
    return 'Total: $total';
  }

  @override
  String get rateEventPrompt => 'Valora este evento:';

  @override
  String get buyButton => 'Confirmar Compra';

  @override
  String get limitReachedMax => 'Has llegado al máximo de 8 entradas';

  @override
  String get limitReachedMin => 'El mínimo es 1 entrada';

  @override
  String get stepperSemanticLabel => 'Cantidad de entradas';

  @override
  String get stepperDecrementTooltip => 'Restar entrada';

  @override
  String get stepperIncrementTooltip => 'Sumar entrada';

  @override
  String get switchLanguage => 'English';
}
