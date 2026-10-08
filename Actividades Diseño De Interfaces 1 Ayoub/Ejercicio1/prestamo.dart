import 'libro.dart';

class Prestamo {
  final Libro libro;
  final String alumno;
  final DateTime fechaPrestamo;
  final DateTime? fechaDevolucion;

  const Prestamo({
    required this.libro,
    required this.alumno,
    required this.fechaPrestamo,
    this.fechaDevolucion,
  });

  bool get devuelto => fechaDevolucion != null;

  int diasRetraso(DateTime hoy) {
    final fechaLimite = fechaPrestamo.add(const Duration(days: 15));
    final fechaComparar = fechaDevolucion ?? hoy;
    
    if (fechaComparar.isAfter(fechaLimite)) {
      return fechaComparar.difference(fechaLimite).inDays;
    }
    return 0;
  }
}