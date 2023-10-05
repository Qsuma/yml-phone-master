import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/route_animation.dart';
import '../screens/details_screens.dart';

class CardSwiper extends StatelessWidget {
  final double width;
  final double height;

  final List<Movie> movies;

  const CardSwiper(
      {Key? key,
      required this.movies,
      required this.width,
      required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: Size.height * height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: Size.height * height, //0.5-0.8
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: Size.width * width, //0.6-0.4
        itemHeight: Size.height * height, //0.4-0.8
        itemBuilder: (_, int index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                crearRuta(DetailsScreen(movie: movie),
                    const Duration(milliseconds: 700)),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(movie.backdropPath),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
