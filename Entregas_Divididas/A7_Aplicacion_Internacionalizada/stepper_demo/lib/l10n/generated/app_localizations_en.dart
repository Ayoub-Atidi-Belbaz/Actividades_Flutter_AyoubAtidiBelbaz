// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ticket Purchase';

  @override
  String get eventTitle => 'DAM Music Festival 2026';

  @override
  String get eventDateLabel => 'Event Date';

  @override
  String ticketCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tickets',
      one: '1 ticket',
    );
    return '$_temp0';
  }

  @override
  String get unitPriceLabel => 'Unit price: €4.50';

  @override
  String totalPrice(String total) {
    return 'Total: $total';
  }

  @override
  String get rateEventPrompt => 'Rate this event:';

  @override
  String get buyButton => 'Confirm Purchase';

  @override
  String get limitReachedMax => 'You have reached the maximum of 8 tickets';

  @override
  String get limitReachedMin => 'The minimum is 1 ticket';

  @override
  String get stepperSemanticLabel => 'Ticket quantity';

  @override
  String get stepperDecrementTooltip => 'Remove ticket';

  @override
  String get stepperIncrementTooltip => 'Add ticket';

  @override
  String get switchLanguage => 'Español';
}
