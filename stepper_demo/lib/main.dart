import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';
import 'l10n/generated/app_localizations.dart';

/// Punto de entrada de la aplicación.
void main() {
  runApp(const StepperDemoApp());
}

/// Aplicación principal de demostración con internacionalización.
class StepperDemoApp extends StatefulWidget {
  /// Crea la aplicación de demostración.
  const StepperDemoApp({super.key});

  @override
  State<StepperDemoApp> createState() => _StepperDemoAppState();
}

class _StepperDemoAppState extends State<StepperDemoApp> {
  Locale _locale = const Locale('es');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'es'
          ? const Locale('en')
          : const Locale('es');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper Demo',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),
      home: TicketPurchaseScreen(
        currentLocale: _locale,
        onToggleLocale: _toggleLocale,
      ),
    );
  }
}

/// Pantalla de compra de entradas internacionalizada.
class TicketPurchaseScreen extends StatefulWidget {
  /// Crea la pantalla de compra de entradas.
  const TicketPurchaseScreen({
    super.key,
    required this.currentLocale,
    required this.onToggleLocale,
  });

  /// El idioma actual seleccionado en la aplicación.
  final Locale currentLocale;
  
  /// Callback invocado para alternar entre los idiomas disponibles.
  final VoidCallback onToggleLocale;

  @override
  State<TicketPurchaseScreen> createState() => _TicketPurchaseScreenState();
}

class _TicketPurchaseScreenState extends State<TicketPurchaseScreen> {
  int _ticketCount = 1;
  int _eventRating = 4;
  final double _pricePerTicket = 4.50;
  final DateTime _eventDate = DateTime(2026, 11, 28, 20, 30);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalAmount = _ticketCount * _pricePerTicket;

    final numberFormat = NumberFormat.currency(
      locale: widget.currentLocale.languageCode,
      symbol: '€',
      decimalDigits: 2,
    );
    final formattedTotal = numberFormat.format(totalAmount);

    final dateFormat = DateFormat.yMMMMEEEEd(widget.currentLocale.languageCode);
    final formattedDate = dateFormat.format(_eventDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          TextButton.icon(
            key: const Key('toggle_language_button'),
            onPressed: widget.onToggleLocale,
            icon: const Icon(Icons.language),
            label: Text(
              widget.currentLocale.languageCode == 'es' ? 'EN' : 'ES',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            l10n.eventTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        InfoBadge(
                          label: widget.currentLocale.languageCode == 'es'
                              ? 'En venta'
                              : 'On sale',
                          icon: Icons.confirmation_number,
                          backgroundColor: Colors.deepPurple.shade100,
                          textColor: Colors.deepPurple.shade900,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${l10n.eventDateLabel}: $formattedDate',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.sell, size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          l10n.unitPriceLabel,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Text(
                      l10n.ticketCount(_ticketCount),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: QuantityStepper(
                        min: 1,
                        max: 8,
                        step: 1,
                        initialValue: _ticketCount,
                        semanticLabel: l10n.stepperSemanticLabel,
                        decrementTooltip: l10n.stepperDecrementTooltip,
                        incrementTooltip: l10n.stepperIncrementTooltip,
                        onChanged: (newCount) {
                          setState(() {
                            _ticketCount = newCount;
                          });
                        },
                        onLimitReached: (limit) {
                          final message = limit == StepperLimit.max
                              ? l10n.limitReachedMax
                              : l10n.limitReachedMin;

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.totalPrice(formattedTotal),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                          ),
                          Icon(
                            Icons.receipt_long,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 36),
                    Text(
                      l10n.rateEventPrompt,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: StarRating(
                        rating: _eventRating,
                        maxRating: 5,
                        starSize: 32,
                        activeColor: Colors.amber.shade700,
                        onRatingChanged: (rating) {
                          setState(() {
                            _eventRating = rating;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      key: const Key('buy_tickets_button'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${l10n.buyButton}: ${_ticketCount}x -> $formattedTotal',
                            ),
                            backgroundColor: Colors.green.shade700,
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(
                        l10n.buyButton,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}