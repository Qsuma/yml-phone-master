import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import '../models/generos.dart';

class MenuCarrusel extends StatelessWidget {
  final List<Genero> generos;
  const MenuCarrusel({super.key, required this.generos});

  @override
  Widget build(BuildContext context) {
    return InfiniteCarousel.builder(
      itemCount: generos.length,
      itemExtent: 200,
      itemBuilder: (_, itemIndex, realIndex) => BotonGenero(itemIndex),
    );
  }

  Widget BotonGenero(int index) {
    return TextButton(onPressed: () {}, child: Text(generos[index].genre));
  }
}
