// ignore_for_file: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yml/globals/globals.dart';
import 'package:yml/screens/TV_screens/Tv_widgets/menu_drawer.dart';
import 'package:yml/screens/TV_screens/Tv_widgets/movie_slider.dart';
import 'package:yml/screens/TV_screens/details_screens.dart';

import 'package:yml/widgets/raw_listener.dart';
import 'package:yml/widgets/videowidgetlocal.dart';
import '../../generated/l10n.dart';
import '../../models/generos.dart';
import '../../models/movie.dart';
import '../../models/route_animation.dart';
import '../../providers/generos_provider.dart';
import '../../providers/movie_providers.dart';
import '../../search/search_delegate.dart';
import '../../widgets/menu_drawer.dart';
import '../../widgets/movie_slider.dart';
import '../details_screens.dart';
import 'dart:convert';
import 'dart:typed_data';


class TVHomeSreen extends StatefulWidget {
  final String Usuario;
  const TVHomeSreen({super.key, required this.Usuario});

  @override
  TVHomeSreenState createState() => TVHomeSreenState();
}

class TVHomeSreenState extends State<TVHomeSreen> {
  final ScrollController scrollController =ScrollController();
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  bool ismaximaced =false;
  String selectedGenreId = 'All';
  List<Movie> selectedGenderMovies = [];
 @override
  void initState() {
    focusNode.addListener(_listener);
    focusNode1.addListener(_listener);
    focusNode2.addListener(_listener);
    focusNode3.addListener(_listener);
    super.initState();
  }
  _listener() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
  @override
  void dispose() {
  focusNode.removeListener(_listener);
  focusNode1.removeListener(_listener);
  focusNode2.removeListener(_listener);
  focusNode3.removeListener(_listener);
  
    focusNode.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 
    
    final moviesProviders = Provider.of<MoviesProviders>(context);
    final generosProviders = Provider.of<GeneroProvider>(context);
  
    List<Movie> selectedMovies = moviesProviders.Estrenos;
    final List<Genero> generos = generosProviders.Gneroos;
    if (selectedGenreId != 'All') {
      selectedMovies = selectedGenderMovies;
    }

    Row rowTittle = Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        SizedBox(
          width: 20,
          height: 35,
          child: Image.asset('assets/icon.png'),
        ),
       Row(
        children:[
          ShortcutController(
            focusNode: FocusNode(),
            widget: IconButton(
              splashRadius: 20,
              focusColor: const Color.fromARGB(134, 132, 132, 132),
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
                    );
                  },
                ),
          ),
          ShortcutController(
            focusNode: focusNode1,
            widget: IconButton(
              focusNode: focusNode1,
              splashRadius: 20,
              focusColor: const Color.fromARGB(134, 132, 132, 132),
              icon: const Icon(Icons.search, color: Colors.red,),
              onPressed: () =>
                  showSearch(context: context, delegate: movieSearchDelegate())),
          ),
       
         
      ] 
      )//:Container()
      ],
    );
    SliverAppBar sliverAppBar = SliverAppBar(
    
      iconTheme: const IconThemeData(color: Colors.red),
     leading: Builder(
      builder: (context) {
        return ShortcutController(
        focusNode: focusNode3,
        widget: IconButton(
          focusNode: focusNode3,
            splashRadius: 20,
              focusColor: const Color.fromARGB(134, 132, 132, 132),
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        );
      }
    ),
      title:rowTittle,
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight:MediaQuery.of(context).size.height*0.44,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(fit: StackFit.expand, children: [
          FadeInImage(
                fit: BoxFit.fill,
                placeholder: const AssetImage(
                  'assets/icon.png',
            
                ),
                image: AssetImage( 'assets/gif/${selectedGenreId}.gif'),
                  
                // image: AssetImage('assets/icon.png'),
                //NetworkImage(moviesProviders.Estrenos.first.posterPath),
                imageErrorBuilder: (context, error, stackTrace) =>  Image(
                  image:(selectedMovies.isNotEmpty)? MemoryImage(
                            base64Decode(selectedMovies.first.backdropPath.split(',').last)) as ImageProvider:AssetImage('assets/splash.gif'),
                  fit: BoxFit.fill,
                ),
              ),
          //VideoSelecter(genreID:selectedGenreId ),
          const Padding(
            padding: EdgeInsetsDirectional.only(top: 0),
            child: DecoratedBox(
            
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: [0.2, 0.2],
                        begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                        colors:[Color.fromARGB(169, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)]))),
          ),
        ]),
      ),
    );
    return WillPopScope(
       onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
        
            drawerScrimColor: const Color.fromARGB(39, 247, 246, 246),
            backgroundColor: const Color.fromARGB(0, 42, 41, 41).withOpacity(1),
            drawer:  TVMenuDrawer(Usuario: widget.Usuario,),
            body:  CustomScrollView(
              controller: scrollController,
    
                  slivers: [
                  
              sliverAppBar,
              SliverList(
                  delegate: SliverChildListDelegate([
                CarouselSlider(
                  options: CarouselOptions(    autoPlayCurve: Curves.bounceIn,height: 80.0),
                  items: generos.map((genre) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 125, 17, 17),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ShortcutController(
                              focusNode: FocusNode(),
                              widget: TextButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                color:
                                                    Color.fromARGB(179, 0, 0, 0))))),
                                child: Text(
                                  genre.genre,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedGenreId = genre.id;
                                    if (genre.id != 'All') {
                                      selectedGenderMovies = moviesProviders
                                          .Todo[generos.indexOf(genre)];
                                    }
                            
                                    // else selectedMovies = moviesProviders.Estrenos;
                                  });
                            
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ])),
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 10,
                ),
              //  (selectedGenreId=='All' )? TVMovieSlider(
              //   Page: 'Home',
                
              //     onNextPage: (){
              //       moviesProviders.getEstrenosMovies();
              //     },
              //     heroId: 'hometv',
              //     movies: moviesProviders.Estrenos,
              //     title: ClassLocalizations.of(context).estrenos,
              //   ):Container(),
                const SizedBox(
                  height: 30,
                )
              ])),
              SliderVertical(selectedMovies:(selectedGenreId=='All')?moviesProviders.Estrenos :
              moviesProviders.Todo[moviesProviders.posicion(selectedGenreId)],onNextPage:  (){(selectedGenreId=='All')?moviesProviders.getEstrenosMovies() :
              moviesProviders.Aumentar_Numero(selectedGenreId);}, scrollController: scrollController,)
      
            
            ])),
      ),
    );
    //  }
    //  return Center(child: const CircularProgressIndicator());
  }
  //)
  //  );
}

class SliderVertical extends StatefulWidget {
  const SliderVertical({
    super.key,
    required this.selectedMovies,
    required this.onNextPage, required this.scrollController,
  });
  
  final ScrollController scrollController;

  final VoidCallback onNextPage;
  final List<Movie> selectedMovies;
  
  //final String selectedGenreId;

  @override
  State<SliderVertical> createState() => _SliderVerticalState();
}

class _SliderVerticalState extends State<SliderVertical> {
 late bool _isLoading;
 int page =2;
  @override
  void initState() {
    super.initState();
    _isLoading =false;
    widget.scrollController.addListener(_listener);
  }
  _listener() async {
  
if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent && _isLoading ==false) {
             widget.onNextPage();  
            setState(() {
             _isLoading =true; 
            });
     
    
    // (widget.genderId=='All')? await _estrenos():widget.selectedMovies.addAll(await MoviesProviders().getGenderMovies(widget.genderId,page: page));
    setState(() {
    _isLoading =false;
    page++;
   
    });
    
        
      }
     
  }
@override
  void dispose() {
    super.dispose();
    widget.scrollController;
    widget.scrollController.removeListener(_listener);
    widget.selectedMovies.clear();
    }
  

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate:
            // ignore: unrelated_type_equality_checks
            SliverChildBuilderDelegate(
                childCount: widget.selectedMovies.length,
                // snapshot.data!.length,
                //moviesProviders.Estrenos.length,
                (context, index) =>  MoviePoster2(
                    //vacia, '23'
                    widget.selectedMovies[index],
                    // snapshot.data![index],
                    //moviesProviders.Estrenos.where((element) => element.genreId == selectedGenreId || selectedGenreId == 'All').first,
                    )),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          mainAxisSpacing:  2,
          crossAxisSpacing: 10,
          crossAxisCount:   6,
        ));
  }
}
//}

class MoviePoster2 extends StatelessWidget {
  final Movie movie;
  //final String selectedgenreid;

  const MoviePoster2(this.movie,  {super.key});

  Image imageFromBase64String(String base64String) {
    final byteImage = const Base64Decoder().convert(base64String);
    return Image.memory(byteImage);
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
  @override
  Widget build(BuildContext context) {
    late Movie moviefinal;
    


      moviefinal = movie;
  

    return ShortcutController(
      focusNode: FocusNode(),
    

      widget: TextButton(
        autofocus: false,
       onPressed: () {
         Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) => TVDetailsScreen(movie: moviefinal),)
                      );
       },
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            //130,
            //height: 500,
            // ignore: prefer_const_constructors
      
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        crearRuta(TVDetailsScreen(movie: moviefinal),
                            const Duration(milliseconds: 700)),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: MemoryImage(
                            base64Decode(moviefinal.backdropPath.split(',').last)),
                        //NetworkImage(moviefinal.posterPath),
                        imageErrorBuilder: (context, error, stackTrace) => Image(
                          image: const AssetImage('assets/icon.png'),
                          height: 260,
                          width: MediaQuery.of(context).size.width * 0.45,
                          fit: BoxFit.contain,
                        ),
                        width:  MediaQuery.of(context).size.width * 0.45,
                        height: 190, //imagen
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    moviefinal.title,
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
        ),
      ),
    );
  }
}
