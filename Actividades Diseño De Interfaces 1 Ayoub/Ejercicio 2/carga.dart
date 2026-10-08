import 'dart:async';
import 'dart:math';

final random = Random();

class Libro {
  final String titulo;
  Libro(this.titulo);
}

Future<List<Libro>> descargarCatalogo() async {
  int tiempoDeCarga = random.nextInt(3) + 1;
  await Future.delayed(Duration(seconds: tiempoDeCarga));

  if (random.nextBool()) {
    throw Exception('Error simulado de conexión');
  }

  return [Libro('Dart para principiantes'), Libro('Flutter Avanzado')];
}

Future<List<Libro>> cargarconReintentos() async {
  const int maximoDeIntentos = 3;

  for (int intento = 1; intento <= maximoDeIntentos; intento++) {
    try {
      final resultado = await descargarCatalogo().timeout(
        const Duration(seconds: 2),
      );

      return resultado;
    } catch (e) {
      if (intento == maximoDeIntentos) {
        throw Exception(
          'Fallaron los $maximoDeIntentos intentos de descarga: $e',
        );
      }

      await Future.delayed(Duration(seconds: intento));
    }
  }

  throw Exception('No fue posible cargar el catalogo.');
}

Future<void> main() async {
  try {
    final libros = await cargarconReintentos();
    print('Se cargaron ${libros.length} libros en total.');
  } catch (e) {
    print('Error final crítico: $e');
  }
}
