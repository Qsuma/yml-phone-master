import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:window_manager/window_manager.dart';
import 'package:yml/globals/globals.dart';
import 'package:yml/widgets/raw_listener.dart';
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
import 'dart:io' show Platform, exit;
import 'dart:convert';



class HomeSreen extends StatefulWidget {
  const HomeSreen({super.key});

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {

  final ScrollController scrollController =ScrollController();
  bool ismaximaced =false;
  String selectedGenreId = 'All';
  List<Movie> selectedGenderMovies = [];
 @override
  void initState() {
      
    super.initState();
  }
  
  @override
  void dispose() {
 
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 
    
    final moviesProviders = Provider.of<MoviesProviders>(context);
    final generosProviders = Provider.of<GeneroProvider>(context);
  
    List<Movie> selectedMovies = moviesProviders.Estrenos;
    List<Genero> generos = generosProviders.Gneroos;
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
          IconButton(
              
              splashRadius: 20,
              focusColor: Color.fromARGB(134, 132, 132, 132),
              icon: const Icon(Icons.search, color: Colors.red,),
              onPressed: () =>
                  showSearch(context: context, delegate: movieSearchDelegate())),
         
         Platform.isWindows? IconButton(
          splashRadius: 20,
          focusColor: Color.fromARGB(134, 132, 132, 132),
          onPressed:() {
          
          windowManager.minimize();
        }, icon: Icon(Icons.minimize)):Container(),
         
          Platform.isWindows? IconButton(
            splashRadius: 20,
            focusColor: Color.fromARGB(134, 132, 132, 132),
            onPressed:() {
         
          windowManager.setFullScreen(ismaximaced);
              setState(() {
                super.setState(() {
                  ismaximaced =!ismaximaced;
                });
  
            
          });
        }, icon: (ismaximaced)?Icon(Icons.fullscreen):Icon(Icons.fullscreen_exit)):Container(),
       Platform.isWindows? IconButton(
        splashRadius: 20,
            focusColor: Color.fromARGB(134, 132, 132, 132),
        onPressed:() {
        
         
          windowManager.close();
        }, icon: Icon(Icons.close)):Container(),] 
      )//:Container()
      ],
    );
    SliverAppBar sliverAppBar = SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.red),
     leading: Builder(
      builder: (context) {
        return  IconButton(
       
            splashRadius: 20,
              focusColor: Color.fromARGB(134, 132, 132, 132),
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
      }
    ),
      title:rowTittle,
      floating: false,
      pinned: true,
      snap: false,
      expandedHeight: 460,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(fit: StackFit.expand, children: [
          FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage(
              'assets/YML.png',
        
            ),
            image: (selectedMovies.isNotEmpty)
                ? MemoryImage(
                    base64Decode(selectedMovies[0].backdropPath.split(',').last))
                : const AssetImage('assets/YML.png') as ImageProvider,
            // image: AssetImage('assets/YML.png'),
            //NetworkImage(moviesProviders.Estrenos.first.posterPath),
            imageErrorBuilder: (context, error, stackTrace) => const Image(
              image: AssetImage('assets/YML.png'),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 0),
            child: DecoratedBox(
            
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: [0.1, 0.1],
                        begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                        colors:(Platform.isWindows)? [Color.fromARGB(204, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)]:[Color.fromARGB(169, 0, 0, 0), Color.fromARGB(0, 255, 255, 255)]))),
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
            drawer: const MenuDrawer(),
            body:  CustomScrollView(
              controller: scrollController,
    
                  slivers: [
                  
              sliverAppBar,
              SliverList(
                  delegate: SliverChildListDelegate([
                CarouselSlider(
                  options: CarouselOptions(height: 80.0),
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
                            child:  TextButton(
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
               (selectedGenreId=='All' )? MovieSlider(
                Page: 'Home',
                  onNextPage: (){
                    moviesProviders.getEstrenosMovies();
                  },
                  //(selectedGenreId !='All')? moviesProviders.Aumentar_Numero(selectedGenreId):moviesProviders.getEstrenosMovies(),
                  heroId: 'hometv',
                  movies: moviesProviders.Estrenos,
                  title: ClassLocalizations.of(context).estrenos,
                 // onNextPage: () => moviesProviders.Estrenos,
                ):Container(),
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
   
  }

 
}

class SliderVertical extends StatefulWidget {
  const SliderVertical({
    super.key,
    required this.selectedMovies,
    required this.onNextPage, required this.scrollController,
  });
  final ScrollController scrollController;
  final Function onNextPage;
  final List<Movie> selectedMovies;


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
                (context, index) => MoviePoster2(
                    //vacia, '23'
                    widget.selectedMovies[index],
                    // snapshot.data![index],
                    //moviesProviders.Estrenos.where((element) => element.genreId == selectedGenreId || selectedGenreId == 'All').first,
                    )),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (
                  MediaQuery.of(context).size.width <= 500)
              ? 0.70
              : 0.6,
          mainAxisSpacing: 2,
          crossAxisSpacing: (
                  MediaQuery.of(context).size.width <= 500)
              ? 2
              : 10,
          crossAxisCount:(Platform.isWindows)? 6     : (
                  MediaQuery.of(context).size.width <= 500)
              ? 2
              : 6,
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
    final Movie vacia = Movie(
        originalTitle: 'vacio',
        backdropPath:
            'https://th.bing.com/th/id/R.332ee537b18e9f5eb0eb43e72842b5ff?rik=vQg2K4%2fUzBGjEw&pid=ImgRaw&r=0',
        originalLanguage: 'ES_es',
        overview: 'ESTA VACIO',
        
        releaseDate: '23-3-4',
        title: 'VACIO',
        video: 'https://youtu.be/MB3YGQ-O1lk',
        genreId: '23',
        isDeleted: false,
        updatedAt: DateTime(2017));

    // ignore: unnecessary_null_comparison
    if (movie == null) {
      moviefinal = vacia;
    } else {
      moviefinal = movie;
    }

    return  TextButton(
        autofocus:  true,
       onPressed: () {
         Navigator.push(
                        context,
                        crearRuta(DetailsScreen(movie: moviefinal),
                            const Duration(milliseconds: 700)),
                      );
       },
        child: Center(
          child: SizedBox(
            width:(Platform.isWindows)? MediaQuery.of(context).size.width * 0.2  : MediaQuery.of(context).size.width * 0.45,
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
                        crearRuta(DetailsScreen(movie: moviefinal),
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
                          image: const AssetImage('assets/YML.png'),
                          height: 260,
                          width:(Platform.isWindows)? MediaQuery.of(context).size.width * 0.2  : MediaQuery.of(context).size.width * 0.45,
                          fit: BoxFit.contain,
                        ),
                        width: (Platform.isWindows)? MediaQuery.of(context).size.width * 0.2  : MediaQuery.of(context).size.width * 0.45,
                        height: (Platform.isWindows)? (MediaQuery.of(context).size.height<700)?170 :350  :(MediaQuery.of(context).size.width<600)?243 :190, //imagen
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
      );
  }
}
