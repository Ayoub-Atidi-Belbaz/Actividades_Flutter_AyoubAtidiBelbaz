import 'libro.dart';
import 'prestamo.dart';

void main() {
  final libroOriginal = Libro(
    isbn: '978-84-376-0494-7',
    titulo: 'Cien años de soledad',
    autor: 'Gabriel García Márquez',
    anio: 1967,
    genero: Genero.novela,
  );

  print('--- PRUEBA LIBRO ---');
  print('Título: ${libroOriginal.titulo}');
  print('Género: ${libroOriginal.genero.etiqueta}');

  final libroCopia = libroOriginal.copyWith(
    titulo: 'El coronel no tiene quien le escriba',
    anio: 1961,
  );

  print('\nPRUEBA COPYWITH ');
  print('Nuevo título: ${libroCopia.titulo}');
  print('Autor conservado: ${libroCopia.autor}');
  print('Nuevo año: ${libroCopia.anio}');

  final prestamoActivo = Prestamo(
    libro: libroOriginal,
    alumno: 'María',
    fechaPrestamo: DateTime(2023, 10, 1),
  );

  print('\nPRUEBA PRÉSTAMO ');
  print('¿Está devuelto?: ${prestamoActivo.devuelto}');

  final fechaSinRetraso = DateTime(2023, 10, 10);
  final fechaConRetraso = DateTime(2023, 10, 20);

  print(
    'Días de retraso al 10/Oct: ${prestamoActivo.diasRetraso(fechaSinRetraso)}',
  );
  print(
    'Días de retraso al 20/Oct: ${prestamoActivo.diasRetraso(fechaConRetraso)}',
  );
}
