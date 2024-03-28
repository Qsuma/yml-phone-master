import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../models/movie.dart';
import '../models/route_animation.dart';
import '../providers/movie_providers.dart';
import '../screens/details_screens.dart';

class movieSearchDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => ClassLocalizations().buscarPelicula;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProviders>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    final Size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: Size.height * 0.5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return _EmptyContainer();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, int index) => SuggestionItems(
                  snapshot.data![index]), //snappshot.data es las pelis del json
            );
          }
        });
  }

  Widget _EmptyContainer() {
    return Container(
      color: const Color.fromARGB(67, 0, 0, 0),
      child: const Center(
        child: Icon(Icons.search, size: 100),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _EmptyContainer();
    final moviesProvider = Provider.of<MoviesProviders>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);
    return StreamBuilder(
        stream: moviesProvider.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) return _EmptyContainer();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, int index) {
              return SuggestionItems(snapshot.data![index]);
            }, //snappshot.data es las pelis del json
          );
        });
  }
}

class SuggestionItems extends StatelessWidget {
  final Movie movie;

  const SuggestionItems(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no_image.png'),
        image: MemoryImage(base64Decode(movie.backdropPath.split(',').last)),
        //image: NetworkImage(movie.posterPath),
        imageErrorBuilder: (context, error, stackTrace) => const Image(
          image: AssetImage('assets/icon.png'),
          fit: BoxFit.contain,
        ),
        width: 50,
        fit: BoxFit.contain,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.push(
        context,
        crearRuta(
            DetailsScreen(movie: movie), const Duration(milliseconds: 700)),
      ),
    );
  }
}
