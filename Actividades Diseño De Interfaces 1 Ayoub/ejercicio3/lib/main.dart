import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Libros',
      home: CatalogoScreen(),
    );
  }
}

class Libro {
  final String titulo;
  Libro(this.titulo);
}

final List<Libro> libros = [
  Libro('Libro 1'),
  Libro('Libro 2'),
  Libro('Libro 3'),
];

class TarjetaLibro extends StatelessWidget {
  const TarjetaLibro({
    super.key,
    required this.libro,
    required this.esFavorito,
    required this.onToggleFavorito,
  });

  final Libro libro;
  final bool esFavorito;
  final VoidCallback onToggleFavorito;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(libro.titulo),
      trailing: IconButton(
        icon: Icon(esFavorito ? Icons.favorite : Icons.favorite_border),
        onPressed: onToggleFavorito,
      ),
    );
  }
}

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  final Set<Libro> _favoritos = {};
  bool _mostrarSoloFavoritos = false;

  @override
  Widget build(BuildContext context) {
    final librosAMostrar = _mostrarSoloFavoritos
        ? libros.where((l) => _favoritos.contains(l)).toList()
        : libros;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos: ${_favoritos.length}'),
        actions: [
          Row(
            children: [
              const Text('Solo favoritos'),
              Switch(
                value: _mostrarSoloFavoritos,
                onChanged: (value) {
                  setState(() {
                    _mostrarSoloFavoritos = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final l in librosAMostrar)
            TarjetaLibro(
              libro: l,
              esFavorito: _favoritos.contains(l),
              onToggleFavorito: () {
                setState(() {
                  if (_favoritos.contains(l)) {
                    _favoritos.remove(l);
                  } else {
                    _favoritos.add(l);
                  }
                });
              },
            ),
        ],
      ),
    );
  }
}


//Repuestas Preguntas Ejercicio 3: 


//1. Explica por qué el contador no puede funcionar tal como está:


//Porque muestra siempre 0 porque la variable que controla si un libro
// es favorito (_favorito) se almacena de forma local e independiente dentro del estado de cada TarjetaLibro
// y el widget padre no tiene acceso ni es notificado de estos cambios para actualizarse.

//4. ¿qué pasaría con los favoritos al hacer scroll si la lista
// fuera muy larga y el estado siguiera en cada tarjeta?


// En Flutter, listas dinámicas como ListView destruyen los widgets
// que salen de la pantalla para optimizar el uso de memoria.
// Si el estado solo se guarda dentro de la tarjeta, se perderá al hacer scroll.
// Al volver a ver la tarjeta, esta se reconstruye con su valor inicial (_favorito = false),
// borrando así cualquier selección previa que el usuario haya hecho.