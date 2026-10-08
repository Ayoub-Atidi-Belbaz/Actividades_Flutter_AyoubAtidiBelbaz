# GUÍA Y SOLUCIONES: UNIDAD 06 — ACTIVIDADES DE FIGMA (BiblioFP)

**Archivo en Figma:** `U06_AtidiBelbaz_Ayoub`  
**Enlace del proyecto:** `https://www.figma.com/design/fc60izbgVicViVcUqnt7DY/U06_AtidiBelbaz_Ayoub`  
**Alumno:** Ayoub Atidi Belbaz  
**Módulo:** Diseño de Interfaces (2º DAM)  

---

## Estructura de Páginas en Figma
Crea o verifica las 5 páginas en el panel izquierdo de Figma:
1. `A1_Mapa`
2. `A2_Wireframe`
3. `A3_Login`
4. `A4_Componentes`
5. `A5_Prototipo`

---

## Actividad 1 — Mapa de pantallas y flujo de usuario

### 1.1 Estructura del Mapa de Pantallas
Organiza las pantallas en rectángulos agrupados por secciones con color de fondo distinto:

- **Módulo 1: Autenticación (Color: Azul claro)**
  - `Screen_Login`
  - `Screen_LoginError`
  - `Modal_RecuperarPassword`
- **Módulo 2: Catálogo y Búsqueda (Color: Verde claro)**
  - `Screen_Inicio` (Novedades, recomendados, barra de búsqueda)
  - `Screen_Resultados` (Listado filtrado, estado con libros encontrados)
  - `Screen_Resultados_Vacio` (Estado vacío: "No se encontraron libros con ese término")
  - `Screen_Detalle` (Ficha técnica del libro)
- **Módulo 3: Reservas y Préstamos (Color: Naranja claro)**
  - `Modal_ConfirmarReserva` (Overlay modal)
  - `Screen_ReservaOK` (Feedback de éxito con código de recogida)
  - `Screen_MisPrestamos` (Libros activos y fechas de devolución)
- **Módulo 4: Perfil de Usuario (Color: Morado claro)**
  - `Screen_Perfil` (Datos del alumno, carnet digital y ajustes)

### 1.2 Flujo de Usuario: «Reservar un libro»
- **Flujo Ideal:** `Screen_Inicio` ➔ Escribir en buscador ➔ `Screen_Resultados` ➔ Tocar libro ➔ `Screen_Detalle` ➔ Botón «Reservar» ➔ `Modal_ConfirmarReserva` ➔ Botón «Confirmar» ➔ `Screen_ReservaOK`.
- **Flujo Alternativo:** `Screen_Inicio` ➔ Sección carrusel «Novedades» ➔ Tocar libro directamente (sin pasar por buscador) ➔ `Screen_Detalle` ➔ «Reservar».
- **Flujo de Error:** `Screen_Detalle` ➔ Pulsa «Reservar» ➔ El libro ya no tiene ejemplares disponibles o el usuario tiene sanciones pendientes ➔ Aparece diálogo de aviso `Modal_ReservaNoDisponible` con opción de «Añadir a lista de espera».

### 1.3 Texto para la Nota Obligatoria en A1 (Punto 5)
> **Tipo de organización:** **Jerárquica estricta con enlaces cruzados (árbol con navegación global).**  
> **Justificación:** Permite al usuario descender de forma predecible desde la pantalla raíz (`Screen_Inicio`) hacia niveles de mayor detalle (resultados y ficha del libro) en un máximo de 3 toques, garantizando un acceso rápido mientras la barra inferior mantiene accesibles las secciones principales en todo momento.

---

## Actividad 2 — Wireframe de baja fidelidad anotado

### 2.1 Configuración de Frames
- Crear 3 frames de **iPhone 14** (`390 × 844 px`):
  1. `Screen_Inicio`
  2. `Screen_Resultados`
  3. `Screen_Detalle`
- Activar **Layout Grid**: 4 columnas, márgenes laterales de `16 px`, gutter de `16 px`.
- Paleta monocromática: Fondo blanco `#FFFFFF`, negro `#111111`, y 3 grises (`#E5E7EB` gris claro para fondos/cajas, `#9CA3AF` gris medio para bordes/placeholders, `#4B5563` gris oscuro para textos secundarios).
- Tipografía: **Inter** regular y bold.
- Imágenes representadas como rectángulos con una «X» diagonal.

### 2.2 Regla de Truncado (Punto 5)
En `Screen_Resultados`:
- Colocar un título largo: *"Diseño de Interfaces de Usuario Avanzadas y Accesibilidad en Entornos Multiplataforma"*
- **Regla funcional:** Máximo 2 líneas de texto (`Line clamp: 2`). Si el título excede las 2 líneas, truncar con puntos suspensivos (`...`) y mantener el nombre del autor en una tercera línea fija.

### 2.3 Notas funcionales al margen para el desarrollador (Punto 6)
Pega estas notas en cajas de texto al lado de los frames:
1. **Nota Barra de Búsqueda (`Screen_Inicio` / `Screen_Resultados`):**
   - *Comportamiento:* El campo dispara la búsqueda con un *debounce* de 300 ms o al presionar Enter.
   - *Validación:* Mínimo 2 caracteres. Si está vacío o no hay coincidencias, mostrar pantalla vacía con sugerencias de géneros.
   - *Estados:* Inactivo (borde gris), Focus (borde negro + cursor activo), Con texto (aparece icono 'X' para limpiar contenido).
2. **Nota Botón de Acción «Reservar» (`Screen_Detalle`):**
   - *Comportamiento:* Fijo en la parte inferior (*sticky bottom*). Al pulsarlo abre el overlay centrado `Modal_ConfirmarReserva`.
   - *Estados:*
     - `Default`: Disponible, fondo negro, texto blanco.
     - `Disabled`: Si el alumno ya tiene el número máximo de préstamos activos (3), el botón se deshabilita (fondo `#E5E7EB`, texto `#9CA3AF`) con un texto explicativo: "Límite de préstamos alcanzado".

---

## Actividad 3 — Prototipo del flujo de login

### 3.1 Diseño en `A3_Login`
- 3 frames (`390 × 844 px`): `Screen_Login`, `Screen_LoginError`, `Screen_Inicio`.
- Estilo Mockup: Color primario (ej. Azul institucional `#2563EB` o Índigo `#4F46E5`), tipografía Inter, y logo vectorial de BiblioFP.
- **Campos en `Screen_Login`:**
  - Input: «Correo del centro» con placeholder `usuario@ies.es`.
  - Input: «Contraseña» con asteriscos `••••••••`.
  - Enlace: «¿Olvidaste tu contraseña?».
  - Botón: «Entrar» (color primario).
- **`Screen_LoginError`:**
  - Campo contraseña con borde rojo `#DC2626` y texto de error debajo: *"Contraseña incorrecta. Inténtalo de nuevo."*

### 3.2 Conexiones de Prototipado
- **Flujo Ideal:** Clic en botón «Entrar» ➔ Navega a `Screen_Inicio` (Animación: *Push* o *Smart Animate*, 300 ms, Ease-in-out).
- **Flujo de Error:** Clic sobre el campo de contraseña o botón de prueba ➔ Navega a `Screen_LoginError` con *Smart Animate* para que la sacudida o el texto de error aparezca de forma suave.
- **Flow Starting Point:** Selecciona `Screen_Login`, en la pestaña *Prototype* pulsa en `+ Flow starting point` y nómbralo `Flujo Login`.

### 3.3 Nota Obligatoria en A3 (Punto 7)
> **Diferencia entre fases de diseño:**  
> En la **A2 (Wireframe)** teníamos una estructura funcional estática en escala de grises centrada en jerarquía y layout. En la **A3 sin conexiones** se define la identidad visual (mockup con color, tipografía y diseño atómico final). Por último, **al añadir conexiones (prototipo interactivo)** la interfaz cobra vida funcional, permitiendo evaluar la navegación real, tiempos de transición y respuestas del sistema ante flujos válidos y situaciones de error.

---

## Actividad 4 — Componente botón con variants y microinteracciones

### 4.1 Creación de `Component_Button`
1. Crear un frame con Auto Layout (`Shift + A`).
2. Configurar:
   - Padding horizontal: `24 px`.
   - Padding vertical: `12 px`.
   - Alto fijo / mínimo: `48 px`.
   - Corner radius: `8 px` (o `12 px`).
   - Alineación: Centrada horizontal y verticalmente.
3. Convertir en componente: `Ctrl + Alt + K`.

### 4.2 Component Set y Propiedades
Crear variantes con dos propiedades:
- **`Type`:** `Primary`, `Secondary`.
- **`State`:** `Default`, `Hover`, `Pressed`, `Disabled`.

**Configuración visual sugerida:**
- **Primary:**
  - `Default`: Fondo `#4F46E5`, texto blanco.
  - `Hover`: Fondo `#4338CA` (más oscuro), texto blanco.
  - `Pressed`: Fondo `#3730A3` con escala ligera (98%).
  - `Disabled`: Fondo `#E5E7EB`, texto `#9CA3AF`.
- **Secondary:**
  - `Default`: Fondo transparente, borde `1.5 px` `#4F46E5`, texto `#4F46E5`.
  - `Hover`: Fondo `#EEF2FF`, borde `#4338CA`, texto `#4338CA`.
  - `Pressed`: Fondo `#E0E7FF`, borde `#3730A3`, texto `#3730A3`.
  - `Disabled`: Fondo transparente, borde `#E5E7EB`, texto `#9CA3AF`.

### 4.3 Microinteracciones (Pestaña Prototype)
En el Component Set:
- Desde la variante `Default` hacia `Hover`:
  - Disparador: **While hovering**.
  - Acción: **Change to** `State: Hover`.
  - Animación: **Smart Animate**, 150 ms, Ease-out.
- Desde la variante `Hover` hacia `Pressed`:
  - Disparador: **While pressing**.
  - Acción: **Change to** `State: Pressed`.
  - Animación: **Instant** o **Smart Animate** 100 ms.

---

## Actividad 5 — Scroll, overlay y test con usuarios

### 5.1 Configuración de `Screen_Detalle` y Scroll Fijo
- Dimensiones del frame: `390 × 1800 px`.
- Contenido largo: Portada grande, título, autor, metadatos, sinopsis completa de varios párrafos, ubicación en la biblioteca (Estantería 3, Pasillo B) y sección inferior con carrusel de libros relacionados.
- **Barra inferior y botón fijos:**
  - Agrupa la barra de navegación y el botón «Reservar».
  - En la pestaña *Prototype* (o pestaña *Design* en la sección *Constraints*), selecciona **Position: Fixed / Stay in place**.

### 5.2 Overlay `Modal_ConfirmarReserva`
- Frame independiente fuera de la pantalla de tamaño `300 × 220 px`, esquinas redondeadas (`16 px`), fondo blanco y sombra (*Drop shadow*).
- Contenido:
  - Título: "¿Confirmar reserva?"
  - Subtexto: "Tienes 48 horas para recoger el libro en el mostrador del instituto."
  - Botón «Confirmar» (Primary) y botón «Cancelar» (Secondary).
- **Conexiones del prototipo:**
  - Botón «Reservar» en `Screen_Detalle`:
    - Acción: **Open overlay**.
    - Destino: `Modal_ConfirmarReserva`.
    - Posición: **Centered**.
    - Opciones marcadas: **Close when clicking outside** y **Add background behind overlay** (color negro `#000000` al 50% de opacidad).
  - Botón «Cancelar»: **Close overlay**.
  - Botón «Confirmar»: **Navigate to** `Screen_ReservaOK`.

### 5.3 Tabla de Test con Usuarios (Punto 6 y 7)
Incluye esta tabla en una nota o en la entrega:

| Usuario | Problema detectado | Gravedad | Cambio aplicado (V1 ➔ V2) |
|---|---|---|---|
| **Usuario 1 (Alumno)** | Intentó pulsar sobre la portada del libro para confirmar la reserva en lugar del botón inferior. | Media | Se añadió un micro-tooltip y se aumentó el contraste del botón fijo inferior para mejorar su visibilidad inmediata. |
| **Usuario 2 (Profesora)** | Al abrir el modal de confirmación, dudó si la recogida era inmediata o tenía plazo de días. | **Alta (Más grave)** | **Se agregó al modal la fecha y plazo límite de recogida explícito: "Plazo de recogida: hasta el viernes a las 14:00h" y código QR preparatorio.** |
| **Usuario 3 (Alumno)** | No sabía cómo regresar a la búsqueda tras ver la pantalla de reserva confirmada (`Screen_ReservaOK`). | Media | Se incorporó un botón principal "Volver al inicio" y un botón secundario "Ver mis préstamos". |

### 5.4 Historial de Versiones en Figma
En Figma pulsa en el menú superior ➔ **File ➔ Version history** (o `Ctrl + Alt + S`):
- Guarda la versión actual como: `V1 - Prototipo inicial antes de test`.
- Tras aplicar la mejora del plazo en el modal de confirmación, guarda: `V2 - Prototipo iterado tras test con usuarios`.
