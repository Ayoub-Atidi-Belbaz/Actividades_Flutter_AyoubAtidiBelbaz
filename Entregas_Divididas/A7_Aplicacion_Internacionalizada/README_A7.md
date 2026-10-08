# Actividad A7: Aplicación Internacionalizada (stepper_demo)

## Enunciados Realizados:
1. Configuración de internacionalización (i18n) de `stepper_demo` en español (plantilla `app_es.arb`) e inglés (`app_en.arb`) con `l10n.yaml`.
2. Pantalla de compra de entradas con `QuantityStepper` (mínimo 1, máximo 8) y `StarRating` interactivo.
3. Textos traducidos dinámicos:
   - Título del evento ("Compra de Entradas" / "Ticket Purchase").
   - Plurales automáticos de entradas ("1 entrada" / "{count} entradas" - "1 ticket" / "{count} tickets").
   - Formato de moneda localizado (4,50 € / 4.50 €).
   - Formato de fecha localizado (sábado, 28 de noviembre de 2026 / Saturday, November 28, 2026).
4. Vinculación de `semanticLabel` y `decrementTooltip`/`incrementTooltip` a textos traducidos.
5. Capturas adjuntas en ambos idiomas demostrando el selector instantáneo de idioma.

## Archivos incluidos en este ejercicio:
- Carpeta `stepper_demo/`: Aplicación Flutter completa lista para ejecutar (`flutter run` o `flutter test`).
- `captura_A7_app_compra_entradas_ES.png`: Captura de pantalla de la app en Español.
- `captura_A7_app_compra_entradas_EN.png`: Captura de pantalla de la app en Inglés.
