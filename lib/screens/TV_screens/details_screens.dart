// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yml/models/generos.dart';
import 'package:yml/models/movie.dart';
import 'package:yml/providers/generos_provider.dart';
import 'package:yml/providers/movie_providers.dart';
import 'package:yml/screens/TV_screens/MyTvScreen.dart';
import 'package:yml/screens/TV_screens/Tv_widgets/movie_slider.dart';
import 'package:yml/src/preferencias_usuario.dart';
import 'package:yml/widgets/raw_listener.dart';
import 'package:yml/widgets/videowidgetlocal.dart';

final prefs = PreferenciasUsuario();
class TVDetailsScreen extends StatefulWidget {
final Movie movie;

const TVDetailsScreen({super.key, required this.movie});

@override
State<TVDetailsScreen> createState() => _TVDetailsScreenState();
}
class _TVDetailsScreenState extends State<TVDetailsScreen> {
  int i=0;
  FocusNode focusNode =FocusNode();
  FocusNode focusNode1 =FocusNode();
  FocusNode focusNode2 =FocusNode();
   _listener() {
   
  }
  @override
  void dispose() {
    focusNode.removeListener(_listener);
    focusNode1.removeListener(_listener);
    focusNode2.removeListener(_listener);
    focusNode.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    
    super.dispose();
  }
  @override
  void initState() {
    int i=0;
    focusNode.addListener(_listener);
    focusNode1.addListener(_listener);
    focusNode2.addListener(_listener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final generosProviders = Provider.of<GeneroProvider>(context);
    final moviesProviders = Provider.of<MoviesProviders>(context);
    return WillPopScope(
      onWillPop: () => _Bloquear_return(),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: //(prefs.ModoOscuro)
                const Color.fromARGB(255, 54, 53, 53).withOpacity(1),
            //  : const Color.fromARGB(255, 226, 226, 226).withOpacity(1),
            body: CustomScrollView(
              slivers: [
                _CustomAppBar(
                        widget.movie,focusNode,focusNode2
                      ),
    
                SliverList(
                    delegate: SliverChildListDelegate([
                  _PosterAndTitle(
                    widget.movie,focusNode1
                  ),
                  _Overview(
                    widget.movie,
                  ),
               
                       TVMovieSlider(
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
      ),
    );
  }

  Future<bool> _Bloquear_return() {
    setState(() {
      i++;
    });
    
return Future.value(
(i==1)
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
   final FocusNode focusNode;
   final FocusNode focusNode2;
  const _CustomAppBar(this.movie, this.focusNode, this.focusNode2);
  @override
  Widget build(BuildContext context) {
  //  final String backdropPath = movie.backdropPath.split(',').last;
    return SliverAppBar(
      leading: ShortcutController(
        focusNode: focusNode,
        
   widget:IconButton(

    focusNode: focusNode,
            splashRadius: 20,
                focusColor: const Color.fromARGB(134, 132, 132, 132),
                color: Colors.red,
    icon: const Icon(Icons.arrow_back),
    iconSize: 30,
    onPressed: () {
     Navigator.pop(context);
    },
  ),
        
      ),
      expandedHeight:MediaQuery.of(context).size.height*0.44,
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
         SizedBox(
          height: MediaQuery.of(context).size.height*0.43,
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
                              base64Decode(movie.backdropPath.split(',').last)),
                    fit: BoxFit.fill,
                  ),
                ),
         ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 0),
            child:  DecoratedBox(
            
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops:[0.22, 0.22],
                        begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                        colors: [Color.fromARGB(169, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)]))),
          ),
        ]),
      ),
    );
  }
}

  class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  final FocusNode focusNode1;

  const _PosterAndTitle(this.movie, this.focusNode1);

  @override
  Widget build(BuildContext context) {
    // final subtitlesProvider =
    // SubtitlesProvider(movie.id!, ClassLocalizations().idioma);
    
    final String posterPath= movie.posterPath.split(',').last;
    
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage(
              'assets/loading.gif',
        
            ),
            image: MemoryImage(
                    base64Decode(posterPath)),
            imageErrorBuilder: (context, error, stackTrace) => const Image(
              image: AssetImage('assets/icon.png'),
              fit: BoxFit.contain,
            ),
          ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth:  MediaQuery.of(context).size.width - 170),
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
              ShortcutController(
                focusNode: focusNode1,
                widget: IconButton(iconSize: 50,
                  splashRadius: 30,
                  focusColor: const Color.fromARGB(134, 132, 132, 132),
                focusNode: focusNode1,
                         
                  onPressed: () {
                    Navigator.push(
                      context,
                   MaterialPageRoute(builder: (context) =>MyTvScreen(url: movie.video.replaceAll('yml-live.com', 'yml-live.me')),
                      )
                      
                    );
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  color: (prefs.ModoOscuro) ? Colors.red : Colors.blue,
                ),
              ),],
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