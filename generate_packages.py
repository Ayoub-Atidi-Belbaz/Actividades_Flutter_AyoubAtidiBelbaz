import os
import shutil
import zipfile

base_dir = r"C:\Users\DAM2P\Downloads\Diseño de Interfaces"
dist_dir = os.path.join(base_dir, "Entregas_Divididas")

if os.path.exists(dist_dir):
    shutil.rmtree(dist_dir)
os.makedirs(dist_dir, exist_ok=True)

def create_zip(folder_name, zip_name):
    folder_path = os.path.join(dist_dir, folder_name)
    zip_path = os.path.join(dist_dir, zip_name)
    with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
        for root, _, files in os.walk(folder_path):
            for file in files:
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, folder_path)
                zf.write(full_path, rel_path)
    print(f"Creado: {zip_name} ({os.path.getsize(zip_path)} bytes)")

# ==========================================
# A1: Primer componente y catálogo
# ==========================================
a1_dir = os.path.join(dist_dir, "A1_Primer_Componente_y_Catalogo")
os.makedirs(os.path.join(a1_dir, "lib", "src"), exist_ok=True)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "src", "quantity_stepper.dart"), os.path.join(a1_dir, "lib", "src"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "ui_kit_dam.dart"), os.path.join(a1_dir, "lib"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "ui_kit_dam_widgetbook.dart"), os.path.join(a1_dir, "lib"))
shutil.copy(os.path.join(base_dir, "captura_A1_QuantityStepper_inicial.png"), a1_dir)

with open(os.path.join(a1_dir, "README_A1.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A1: Primer componente y catálogo

## Enunciados Realizados:
1. En `lib/src/quantity_stepper.dart` crea un `StatefulWidget` llamado `QuantityStepper` que muestre en una fila un `IconButton` con `Icons.remove`, el valor actual (empieza en 0) y un `IconButton` con `Icons.add`.
2. Al pulsar `+` el valor sube 1; al pulsar `−` baja 1.
3. Expórtalo desde `lib/ui_kit_dam.dart`.
4. Añade en Widgetbook un componente `QuantityStepper` con el caso de uso "Por defecto".
5. Responde en tu memoria: ¿por qué este componente es un `StatefulWidget` y `InfoBadge` no?

## Respuesta a la Cuestión Teórica (Punto 5):
> **`QuantityStepper` es un `StatefulWidget`** porque necesita gestionar un **estado mutable interno** (`_value`) que cambia reactivamente con la interacción del usuario (pulsaciones en `+` y `−`). Al llamar a `setState()`, el framework reconstruye la interfaz mostrando el nuevo número sin necesidad de que el padre intervenga.
> 
> En cambio, **`InfoBadge` es un `StatelessWidget`** porque es puramente **inmutable y presentacional**. Recibe sus datos (`label`, `icon`, color) mediante el constructor y no mantiene ninguna variable que cambie con el tiempo tras ser renderizado.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación del componente.
- `lib/ui_kit_dam.dart`: Archivo barril con exportación pública.
- `lib/ui_kit_dam_widgetbook.dart`: Catálogo Widgetbook con caso de uso "Por defecto".
- `captura_A1_QuantityStepper_inicial.png`: Captura del componente en estado inicial.
""")

create_zip("A1_Primer_Componente_y_Catalogo", "Actividad_A1_Primer_Componente_y_Catalogo.zip")

# ==========================================
# A2: Propiedades y valores por defecto
# ==========================================
a2_dir = os.path.join(dist_dir, "A2_Propiedades_y_Valores_Defecto")
os.makedirs(os.path.join(a2_dir, "lib", "src"), exist_ok=True)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "src", "quantity_stepper.dart"), os.path.join(a2_dir, "lib", "src"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "ui_kit_dam_widgetbook.dart"), os.path.join(a2_dir, "lib"))
shutil.copy(os.path.join(base_dir, "captura_A2_QuantityStepper_minimo_desactivado.png"), a2_dir)

with open(os.path.join(a2_dir, "README_A2.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A2: Propiedades y valores por defecto

## Enunciados Realizados:
1. Añade las propiedades `min` (por defecto 0), `max` (por defecto 10), `step` (por defecto 1) e `initialValue` (por defecto, igual a `min`).
2. Valida con `assert` que `min < max`, que `step > 0` y que `initialValue` está entre `min` y `max`.
3. El valor nunca puede salir del rango, ni siquiera en modo release (resuelto mediante `.clamp(min, max)` en la función pura `nextStepperValue`).
4. Desactiva el botón `−` en el mínimo y el botón `+` en el máximo (`onPressed: canDecrement ? () => ... : null`).
5. Añade las propiedades de texto `semanticLabel` (por defecto 'Cantidad'), `decrementTooltip` ('Restar') e `incrementTooltip` ('Sumar').
6. Añade en Widgetbook un caso "Configurable" con knobs para `min`, `max` y `step`.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación con aserciones, clamps de release, accesibilidad y tooltips.
- `lib/ui_kit_dam_widgetbook.dart`: Catálogo interactivo con knobs para min, max y step.
- `captura_A2_QuantityStepper_minimo_desactivado.png`: Captura demostrando el botón de resta desactivado en el mínimo.
""")

create_zip("A2_Propiedades_y_Valores_Defecto", "Actividad_A2_Propiedades_y_Valores_Defecto.zip")

# ==========================================
# A3: Eventos propios
# ==========================================
a3_dir = os.path.join(dist_dir, "A3_Eventos_Propios")
os.makedirs(os.path.join(a3_dir, "lib", "src"), exist_ok=True)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "src", "quantity_stepper.dart"), os.path.join(a3_dir, "lib", "src"))
shutil.copy(os.path.join(base_dir, "captura_A3_QuantityStepper_SnackBar_maximo.png"), a3_dir)

with open(os.path.join(a3_dir, "README_A3.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A3: Eventos propios

## Enunciados Realizados:
1. Añade un evento `ValueChanged<int>? onChanged` que se emita con el nuevo valor cada vez que cambie.
2. Define un enum `StepperLimit { min, max }` y un typedef `LimitReached = void Function(StepperLimit limit);`.
3. Añade un evento `LimitReached? onLimitReached` que se emita cuando el valor llegue al mínimo o al máximo.
4. Ningún evento se emite si el valor no cambia (validación previa en `_updateValue`).
5. En una pantalla de prueba, muestra un SnackBar con el texto "Has llegado al máximo" al alcanzar el límite superior.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Definición del enum, typedef y lógica de emisión de eventos.
- `captura_A3_QuantityStepper_SnackBar_maximo.png`: Captura de pantalla verificando el SnackBar flotante al alcanzar el máximo.
""")

create_zip("A3_Eventos_Propios", "Actividad_A3_Eventos_Propios.zip")

# ==========================================
# A4: Pruebas
# ==========================================
a4_dir = os.path.join(dist_dir, "A4_Pruebas_y_Cobertura")
os.makedirs(os.path.join(a4_dir, "test", "goldens"), exist_ok=True)
os.makedirs(os.path.join(a4_dir, "lib", "src"), exist_ok=True)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "src", "quantity_stepper.dart"), os.path.join(a4_dir, "lib", "src"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "test", "quantity_stepper_test.dart"), os.path.join(a4_dir, "test"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "test", "goldens", "quantity_stepper_5.png"), os.path.join(a4_dir, "test", "goldens"))
shutil.copy(os.path.join(base_dir, "captura_A4_cobertura_y_tests.png"), a4_dir)
shutil.copy(os.path.join(base_dir, "captura_A4_QuantityStepper_golden_5.png"), a4_dir)

with open(os.path.join(a4_dir, "README_A4.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A4: Pruebas y Cobertura de Código

## Enunciados Realizados:
1. Función pura `nextStepperValue({required int current, required int delta, required int min, required int max})` con 4 pruebas unitarias (incremento, decremento, límite inferior y límite superior).
2. Pruebas de widget:
   - Sumar muestra el nuevo valor y emite `onChanged`.
   - Botón `−` desactivado en el mínimo.
   - `onLimitReached` recibe `StepperLimit.max`.
   - `onLimitReached` recibe `StepperLimit.min`.
   - SnackBar informativo en pantalla.
3. Prueba golden del componente con valor 5 (`goldens/quantity_stepper_5.png`).
4. Cobertura de código al 100% de `quantity_stepper.dart` verificada mediante `flutter test --coverage`.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Implementación y función pura `nextStepperValue`.
- `test/quantity_stepper_test.dart`: Suite completa de 15 pruebas automatizadas.
- `test/goldens/quantity_stepper_5.png`: Archivo de referencia Golden con valor 5.
- `captura_A4_cobertura_y_tests.png`: Captura de consola mostrando 15/15 tests pasados y 100% de cobertura.
- `captura_A4_QuantityStepper_golden_5.png`: Renderizado exacto del Golden test.
""")

create_zip("A4_Pruebas_y_Cobertura", "Actividad_A4_Pruebas_y_Cobertura.zip")

# ==========================================
# A5: Documentación
# ==========================================
a5_dir = os.path.join(dist_dir, "A5_Documentacion_y_Analisis")
os.makedirs(os.path.join(a5_dir, "lib", "src"), exist_ok=True)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "lib", "src", "quantity_stepper.dart"), os.path.join(a5_dir, "lib", "src"))
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "analysis_options.yaml"), a5_dir)
shutil.copy(os.path.join(base_dir, "ui_kit_dam", "README.md"), a5_dir)
shutil.copy(os.path.join(base_dir, "captura_A5_dartdoc_QuantityStepper.png"), a5_dir)
shutil.copy(os.path.join(base_dir, "captura_A5_dart_analyze.png"), a5_dir)

with open(os.path.join(a5_dir, "README_A5.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A5: Documentación y Análisis Estático

## Enunciados Realizados:
1. Documentación con `///` de la clase, todas las propiedades públicas, eventos, enum y typedef, incluyendo ejemplo de uso con código Dart.
2. Regla `public_member_api_docs` activada en `analysis_options.yaml` dejando `dart analyze` con 0 avisos.
3. Generación de documentación HTML con `dart doc` (captura incluida de la página de `QuantityStepper`).
4. Actualización de `README.md` del paquete con la sección para `QuantityStepper`.

## Archivos incluidos en este ejercicio:
- `lib/src/quantity_stepper.dart`: Código con documentación `///` exhaustiva.
- `analysis_options.yaml`: Configuración de linter con regla `public_member_api_docs`.
- `README.md`: Documentación completa del paquete.
- `captura_A5_dartdoc_QuantityStepper.png`: Captura de pantalla del sitio web generado por DartDoc para la clase `QuantityStepper`.
- `captura_A5_dart_analyze.png`: Captura de `dart analyze` sin ningún aviso (No issues found).
""")

create_zip("A5_Documentacion_y_Analisis", "Actividad_A5_Documentacion_y_Analisis.zip")

# ==========================================
# A6: Empaquetado
# ==========================================
a6_dir = os.path.join(dist_dir, "A6_Empaquetado_y_Versionado")
shutil.copytree(
    os.path.join(base_dir, "ui_kit_dam"),
    os.path.join(a6_dir, "ui_kit_dam"),
    ignore=shutil.ignore_patterns(".git", ".dart_tool", "build")
)
shutil.copy(os.path.join(base_dir, "captura_A6_pub_publish_dryrun.png"), a6_dir)

with open(os.path.join(a6_dir, "README_A6.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A6: Empaquetado y Publicación en Seco

## Enunciados Realizados:
1. Subida de la versión del paquete a `1.1.0` en `pubspec.yaml` y registro detallado en `CHANGELOG.md`.
2. Repositorio Git inicializado y etiqueta `v1.1.0` creada.
3. Configuración en la aplicación `stepper_demo` dependiente del paquete por Git con etiqueta fija:
   ```yaml
   ui_kit_dam:
     git:
       url: ../ui_kit_dam
       ref: v1.1.0
   ```
4. Ejecución de `flutter pub publish --dry-run` en el paquete: validado exitosamente con **0 advertencias (Package has 0 warnings)**.

## Archivos incluidos en este ejercicio:
- Carpeta `ui_kit_dam/`: Paquete completo listo para publicación.
- `captura_A6_pub_publish_dryrun.png`: Captura de consola de `flutter pub publish --dry-run` con 0 warnings y Git tag `v1.1.0`.
""")

create_zip("A6_Empaquetado_y_Versionado", "Actividad_A6_Empaquetado_y_Versionado.zip")

# ==========================================
# A7: Aplicación internacionalizada
# ==========================================
a7_dir = os.path.join(dist_dir, "A7_Aplicacion_Internacionalizada")
shutil.copytree(
    os.path.join(base_dir, "stepper_demo"),
    os.path.join(a7_dir, "stepper_demo"),
    ignore=shutil.ignore_patterns(".git", ".dart_tool", "build")
)
shutil.copy(os.path.join(base_dir, "captura_A7_app_compra_entradas_ES.png"), a7_dir)
shutil.copy(os.path.join(base_dir, "captura_A7_app_compra_entradas_EN.png"), a7_dir)

with open(os.path.join(a7_dir, "README_A7.md"), "w", encoding="utf-8") as f:
    f.write("""# Actividad A7: Aplicación Internacionalizada (stepper_demo)

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
""")

create_zip("A7_Aplicacion_Internacionalizada", "Actividad_A7_Aplicacion_Internacionalizada.zip")

# ==========================================
# PAQUETE MASTER CONSOLIDADO
# ==========================================
shutil.copy(os.path.join(base_dir, "MEMORIA_PRACTICA_FLUTTER_UI_KIT.md"), dist_dir)
shutil.copy(os.path.join(base_dir, "MEMORIA_PRACTICA_FLUTTER_UI_KIT.html"), dist_dir)

# Create a master zip
master_zip_path = os.path.join(base_dir, "Entrega_Actividades_Flutter_Ayoub_Atidi.zip")
with zipfile.ZipFile(master_zip_path, 'w', zipfile.ZIP_DEFLATED) as zf:
    for root, _, files in os.walk(dist_dir):
        for file in files:
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, dist_dir)
            zf.write(full_path, os.path.join("Entrega_Actividades_Flutter_Ayoub_Atidi", rel_path))

print(f"Creado Master ZIP: Entrega_Actividades_Flutter_Ayoub_Atidi.zip ({os.path.getsize(master_zip_path)} bytes)")
print("¡Todos los paquetes han sido creados satisfactoriamente!")
