import 'package:flutter/material.dart';

import '../models/movie.dart';

class movieHorizontal extends StatelessWidget {
  final List<Movie> lista;

  const movieHorizontal({super.key, required this.lista});

  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    if (lista.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: Size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SizedBox(
        height: 200,
        child: PageView(
          pageSnapping: false,
          controller: PageController(
            initialPage: 1,
            viewportFraction: 0.3,
          ),
          children: _tarjetas(),
        ),
      );
    }
  }

  List<Widget> _tarjetas() {
    return lista.map((Movie) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                height: 160,
                image: NetworkImage(Movie.backdropPath)),
            Text(
              Movie.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }).toList();
  }
}
