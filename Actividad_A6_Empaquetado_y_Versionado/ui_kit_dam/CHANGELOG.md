# Changelog

Todas las novedades y cambios de este paquete se documentan en este archivo.

## [1.1.0] - 2026-10-07

### Added
- Nuevo componente `QuantityStepper` con soporte para:
  - Valores mínimos y máximos seguros (`min`, `max`, `step`, `initialValue`).
  - Lógica pura determinista con `nextStepperValue` (protección en release con `clamp`).
  - Desactivación reactiva de botones en los extremos.
  - Eventos `onChanged` y `onLimitReached` (con enum `StepperLimit` y typedef `LimitReached`).
  - Accesibilidad completa con `semanticLabel`, `decrementTooltip` e `incrementTooltip`.
- Historias de Widgetbook para `QuantityStepper`:
  - Caso de uso `'Por defecto'`.
  - Caso de uso `'Configurable'` con knobs (`min`, `max`, `step`).
- Componentes auxiliares de catálogo:
  - `InfoBadge` (StatelessWidget de estado inmutable para insignias informativas).
  - `StarRating` (componente de valoración interactiva de 1 a 5 estrellas).
- Batería completa de pruebas unitarias, de widget y de regresión visual (Golden test).
- Cobertura de código y documentación de miembros públicos (`public_member_api_docs`).

## [1.0.0] - 2026-09-24

### Added
- Versión inicial del paquete de componentes para Diseño de Interfaces (DAM).
