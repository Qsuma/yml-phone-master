import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yml/screens/TV_screens/details_screens.dart';
import 'package:yml/widgets/raw_listener.dart';
import 'package:yml/widgets/videowidgetlocal.dart';
import 'package:yml/widgets/videowidows.dart';



import '../models/generos.dart';
import '../models/movie.dart';
import '../models/route_animation.dart';
import '../providers/generos_provider.dart';
import '../providers/movie_providers.dart';
import '../src/preferencias_usuario.dart';
import '../widgets/movie_slider.dart';
import '../widgets/reproductor/Modulo_Stream.dart';
import '../widgets/reproductor/Modulo_Stream_Windows.dart';
import 'screens/HomeScreen.dart';



final prefs = PreferenciasUsuario();

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
 
  
  @override
  void dispose() {
   
    
    super.dispose();
  }
  @override
  void initState() {
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final generosProviders = Provider.of<GeneroProvider>(context);
    final moviesProviders = Provider.of<MoviesProviders>(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: //(prefs.ModoOscuro)
              const Color.fromARGB(255, 54, 53, 53).withOpacity(1),
          //  : const Color.fromARGB(255, 226, 226, 226).withOpacity(1),
          body: CustomScrollView(
            slivers: [
              _CustomAppBar(
                     widget.movie
                    ),

              SliverList(
                  delegate: SliverChildListDelegate([
                _PosterAndTitle(
                  widget.movie
                ),
                _Overview(
                  widget.movie,
                ),
             
                     MovieSlider(
                      Page: 'Details',
                      onNextPage:  (){
                     
                      },
                      // moviesProviders.Aumentar_Numero(movie.genreId),
                        heroId: 'detailtv',
                        movies: moviesProviders.Todo[_posicion(generosProviders.Gneroos,widget.movie.genreId)],
                        title: 'Similares',
                       // onNextPage: () =>
                       //     moviesProviders.getGenderMovies(movie.genreId),
                      )
                   
              ]))
            ],
          )),
    );
  }

  int  _posicion(List<Genero> generos,String Idgenero){
    List<String> IdGeneros=[];
    for(int i=0;i<generos.length;i++){
      IdGeneros.add(generos[i].id) ;
    } 

    return IdGeneros.indexOf(Idgenero);
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
 

  const _CustomAppBar(this.movie,);
  @override
  Widget build(BuildContext context) {
    final String backdropPath = movie.backdropPath.split(',').last;
    return SliverAppBar(
      leading: IconButton(
            splashRadius: 20,
                focusColor:  Colors.red,
                color: Colors.red,
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
     Navigator.pop(context);
    },
  ),
      expandedHeight: (Platform.isWindows)?MediaQuery.of(context).size.height*0.43:MediaQuery.of(context).size.height*0.2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
            child: Container()),
        background:Stack(fit: StackFit.expand, children: [
        (Platform.isAndroid)?  Container(
          
          child: FadeInImage(
                fit: BoxFit.fill,
                placeholder: const AssetImage(
                  'assets/icon.png',
            
                ),
                image: AssetImage( 'assets/gif/${movie.genreId}.gif'),
                  
                // image: AssetImage('assets/icon.png'),
                //NetworkImage(moviesProviders.Estrenos.first.posterPath),
                imageErrorBuilder: (context, error, stackTrace) =>  Image(
                  image: MemoryImage(
                            base64Decode(movie.backdropPath.split(',').last)) as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),):FadeInImage(
                fit: BoxFit.fill,
                placeholder: const AssetImage(
                  'assets/icon.png',
            
                ),
                image: AssetImage( 'assets/gif/${movie.genreId}.gif'),
                  
                // image: AssetImage('assets/icon.png'),
                //NetworkImage(moviesProviders.Estrenos.first.posterPath),
                imageErrorBuilder: (context, error, stackTrace) =>  Image(
                  image: MemoryImage(
                            base64Decode(movie.backdropPath.split(',').last)) as ImageProvider,
                  fit: BoxFit.contain,
                ),
              ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 0),
            child:  DecoratedBox(
            
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops:(Platform.isWindows)? [0.1, 0.1]:[0.22, 0.22],
                        begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                        colors: const [Color.fromARGB(169, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)]))),
          ),
        ]),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;


  const _PosterAndTitle(this.movie,);

  @override
  Widget build(BuildContext context) {
    // final subtitlesProvider =
    // SubtitlesProvider(movie.id!, ClassLocalizations().idioma);
    final size = MediaQuery.of(context).size;
    final String posterPath= movie.backdropPath.split(',').last;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/icon.png'),
              image:
                  MemoryImage(base64Decode(posterPath)),
              // image: NetworkImage(movie.posterPath),
              imageErrorBuilder: (context, error, stackTrace) => const Image(
                image: AssetImage('assets/icon.png'),
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
            
              height: 150,
              width: 100,
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 230),
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    movie.originalTitle,
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                 
                  
                 
                ],
              ),
            ),
          ),
              IconButton(iconSize: 50,
                          splashRadius: 20,
                  onPressed: () {
                    Navigator.push(
                      context,
                      crearRuta(
                      //  ReproductorScreen(movie: movie),
                         Platform.isWindows?DartVLCExample(movie: movie,)          : 
                         ChewiePlayer(
                           
                             movie: movie),
                          const Duration(milliseconds: 300)),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  color: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
                ),
             ],
         ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16, color: Colors.white70),
      ),
    );
  }
}

////class SubsState extends StatelessWidget {
////  final Movie movie;
////  final int id;
////  final List<String>? linksubt;

  //const SubsState(
  //    {super.key, required this.id, required this.movie, this.linksubt});

//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
 //     providers: [
 //       //  ChangeNotifierProvider(create: ((_) => SubtitlesProvider(id))),
 //     ],
 //     child: PelisAppPlayer(
 //         //subs: linksubt,
 //         movie: movie),
 //   );
 // }
//}
