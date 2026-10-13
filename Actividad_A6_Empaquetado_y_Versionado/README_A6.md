# Actividad A6: Empaquetado y Publicación en Seco

## Enunciados Realizados:
1. Subida de la versión del paquete a `1.1.0` en `pubspec.yaml` y registro detallado en `CHANGELOG.md`.
2. Repositorio Git inicializado y etiqueta `v1.1.0` creada.
3. Configuración en la aplicación `stepper_demo` dependiente del paquete por Git con etiqueta fija:
   ```yaml
   ui_kit_dam:
     git:
       url: https://github.com/Ayoub-Atidi-Belbaz/ui_kit_dam.git
       ref: v1.1.0
   ```
4. Ejecución de `dart pub publish --dry-run` en el paquete: validado exitosamente con **0 advertencias (Package has 0 warnings)**.

## Archivos incluidos en este ejercicio:
- Carpeta `ui_kit_dam/`: Paquete completo listo para publicación.
- `captura_A6_pub_publish_dryrun.png`: Captura de consola de `flutter pub publish --dry-run` con 0 warnings y Git tag `v1.1.0`.
