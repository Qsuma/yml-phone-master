import 'package:flutter/material.dart';
import 'package:yml/widgets/raw_listener.dart';

import '../models/movie.dart';
import '../models/route_animation.dart';
import '../screens/details_screens.dart';

import 'dart:convert';

import '../src/preferencias_usuario.dart';

final prefs = PreferenciasUsuario();

class MovieSlider extends StatefulWidget {
  final Function onNextPage;
  final String Page;

  final List<Movie> movies;
  final String? title;
  final String heroId;

  const MovieSlider({
    Key? key,
    required this.movies,
    this.title,
    required this.onNextPage,
    required this.heroId, required this.Page,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MovieSlider> createState() => _MovieSliderState(movies, heroId);
}

class _MovieSliderState extends State<MovieSlider> {
 
  

  final String heroId;

  final ScrollController scrollController = ScrollController();

  final List<Movie> movies;

  _MovieSliderState(this.movies, this.heroId);

  @override
  void dispose() {
  
    
    super.dispose();
  }
  @override
  void initState() {
   
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //llamara al provider
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final Size = MediaQuery.of(context).size;
    if (widget.movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: Size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 210, // tamanno total
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  textAlign: TextAlign.left,
                  widget.title!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                )),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount:(widget.movies.length>10)?10:widget.movies.length,
                itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: MoviePoster(widget.movies[index], Page: widget.Page,))),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {

  final String Page;
  final Movie movie;
  

  const MoviePoster(this.movie, {super.key, required this.Page, });
  @override
  Widget build(BuildContext context) {
    return TextButton(
        autofocus: true,
        onPressed:() {
           if(Page == 'Home'){
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>DetailsScreen(movie: movie) ,)
                    );
          }else {
             Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>DetailsScreen(movie: movie) ,)
                    );
           }
        },
        child: SizedBox(
          width: 130,
          //height: 190,
          // ignore: prefer_const_constructors
      
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 190, maxWidth: 130),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: MemoryImage(
                        base64Decode(movie.backdropPath.split(',').last)),
                    // image: NetworkImage(movie.posterPath),
                    imageErrorBuilder: (contextl, error, stackTrace) =>
                        const Image(
                      image: AssetImage('assets/icon.png'),
                      height: 140-16,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                    width: 120,
                    height: 144-16, //imagen
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
  }
}
