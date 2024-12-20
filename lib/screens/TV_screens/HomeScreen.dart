// ignore_for_file: file_names
import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yml/screens/TV_screens/Tv_widgets/menu_drawer.dart';
import 'package:yml/screens/TV_screens/details_screens.dart';
import 'package:string_validator/string_validator.dart';
import 'package:yml/widgets/raw_listener.dart';
import '../../globals/globals.dart';
import '../../models/generos.dart';
import '../../models/movie.dart';
import '../../models/route_animation.dart';
import '../../providers/generos_provider.dart';
import '../../providers/movie_providers.dart';
import '../../search/search_delegate.dart';
import 'dart:convert';



class TVHomeSreen extends StatefulWidget {
  final String Usuario;
  const TVHomeSreen({super.key, required this.Usuario});

  @override
  TVHomeSreenState createState() => TVHomeSreenState();
}

class TVHomeSreenState extends State<TVHomeSreen> {
  final CarouselController _carouselController = CarouselController();
  final ScrollController scrollController =ScrollController();
  final FocusNode focusNodeSliderPeticion = FocusNode();
  final FocusNode focusNodeHome = FocusNode();
  final FocusNode focusNodeSlider = FocusNode();
  final FocusNode focusNodeSearch = FocusNode();
  final FocusNode focusNodeDrawer = FocusNode();
  final FocusNode focusNodeGeneros = FocusNode();
  final FocusNode focusNodePeticion = FocusNode();
  final FocusNode focusNodeArriba=FocusNode();
  bool ismaximaced =false;
  int _currentIndex = 0;

  String selectedGenreId = 'All';
  List<Movie> selectedGenderMovies = [];
 @override
  void initState() {
    focusNodeSliderPeticion.addListener(_listener);
    focusNodeHome.addListener(_listenerHome);
    focusNodeSlider.addListener(_listener);
    focusNodeSearch.addListener(_listener);
    focusNodeDrawer.addListener(_listenerDawer);
    focusNodeGeneros.addListener(_listenerPelisToGeneros);
    focusNodePeticion.addListener(_listener);
    super.initState();
  }
  void requestFocus(BuildContext context,FocusNode focusN){
    FocusScope.of(context).requestFocus(focusN);
  }
  _listenerHome(){
    scrollController.animateTo(0, duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
  }
  _listenerDawer(){
    scrollController.animateTo(0, duration: const Duration(milliseconds: 50), curve: Curves.easeInOut);
  }
  _listener() {
// if (FocusScope.of(context).focusedChild == focusNodeGeneros) {
//     // Aquí puedes implementar la lógica para decidir a qué nodo de enfoque pasar.
//     // Por ejemplo, podrías tener una variable que determine a qué nodo pasar.
//     if (/* tu condición para pasar a focusNode3 */) {
//       requestFocus(context, focusNodeDrawer);
//     } else if (/* tu cond  ición para pasar a focusNode4 */) {
//       requestFocus(context, focusNodeSlider);
//     }
//  }
   // scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);

    }
  _listenerPelisToGeneros(){
   //PPrint('Lista de Pelis To generos ');
  }
   _animateToSelectedPage(int index)  {
     final Size screenSize = MediaQuery.of(context).size;
     // Obtener la posición horizontal del foco actual
     final double horizontalPosition = (screenSize.width / 2) ;
     var a=FocusScope.of(context).focusedChild?.offset.distance;
     //print(FocusScope.of(context).focusedChild?.offset.distance);
     if (a==null){}
     else if(a<screenSize.width / 3 && a<(screenSize.width/3* 2 )) {

       _carouselController.previousPage();
     }else if(a>(screenSize.width / 3)*2){

       _carouselController.nextPage();
     }
 }
  @override
  void dispose() {
    focusNodeHome.removeListener(_listenerHome);
  focusNodeSliderPeticion.removeListener(_listener);
  focusNodeSlider.removeListener(_listener);
  focusNodeSearch.removeListener(_listener);
  focusNodeDrawer.removeListener(_listenerDawer);
  focusNodeGeneros.removeListener(_listenerPelisToGeneros);
  focusNodePeticion.removeListener(_listener);
   
    focusNodeHome.dispose();
    focusNodeSliderPeticion.dispose();  
    focusNodeSlider.dispose();
    focusNodeSearch.dispose();
    focusNodeDrawer.dispose();
    focusNodeGeneros.dispose();
    focusNodePeticion.dispose();
    
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

            focusNode: focusNodeArriba,
            widget: IconButton(
              focusNode: focusNodeHome,
              splashRadius: 20,
              focusColor: Colors.red[100],
                  icon: const Icon(Icons.home),

              onPressed: () {

                  },
                ),
          ),
          ShortcutController(
            focusNode: focusNodeArriba,
            widget: IconButton(
              focusNode: focusNodeSearch,
              splashRadius: 20,
              focusColor:  Colors.red[100],
              icon: const Icon(Icons.search, color: Colors.red,),
              onPressed: () =>
                  showSearch(context: context, delegate: movieSearchDelegate())),
          ),
       
         
      ] 
      ),//:Container(),

      ],
    );
    SliverAppBar sliverAppBar = SliverAppBar(
    
      iconTheme: const IconThemeData(color: Colors.red),
     leading: Builder(
      builder: (context) {
        return ShortcutController(
        focusNode: focusNodeArriba,

          widget: IconButton(
            padding:const EdgeInsetsDirectional.only(start:15),
            focusNode: focusNodeDrawer,
            splashRadius: 10,
              focusColor: Colors.red[100],
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
                image: AssetImage( 'assets/gif/$selectedGenreId.gif'),
                  
                // image: AssetImage('assets/icon.png'),
                //NetworkImage(moviesProviders.Estrenos.first.posterPath),
                imageErrorBuilder: (context, error, stackTrace) =>  Image(
                  image:(selectedMovies.isNotEmpty)? MemoryImage(
                            base64Decode(selectedMovies.first.backdropPath.split(',').last)) as ImageProvider:const AssetImage('assets/splash.gif'),
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
    return PopScope(
       canPop:true,

      child: SafeArea(
        child: KeyboardListener(
          focusNode: focusNodePeticion,
          onKeyEvent: (event) async {
             if (event is KeyDownEvent) {

               //NODEGENEROS
               if (event.logicalKey.keyLabel=="Arrow Left" && focusNodeSearch.hasFocus) {

                 focusNodeHome.requestFocus();
               }

               if (event.logicalKey.keyLabel=="Arrow Right" && focusNodeDrawer.hasFocus) {

                    focusNodeHome.requestFocus();
                 }
                 if (event.logicalKey.keyLabel=="Arrow Left" && focusNodeHome.hasFocus) {

                    FocusScope.of(context).requestFocus(focusNodeDrawer.children.firstOrNull) ;


                 }
                 if (event.logicalKey.keyLabel=="Arrow Up" && focusNodeHome.hasFocus) {
                      scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.bounceInOut);

                 }
               if (event.logicalKey.keyLabel=="Arrow Up" && focusNodeDrawer.hasFocus) {
                 scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.bounceInOut);

               }
                 // if (event.logicalKey.keyLabel=="Arrow Down") {
                 //         //requestFocus(context, focusNodeSlider);
                 //       }

               //NODEDRAWER

               if(event.logicalKey.keyLabel=="Arrow Down" && scrollController.position.pixels >=scrollController.position.maxScrollExtent-100){
                  setState(() {
                    moviesProviders.getGenderMovies(selectedGenreId).then((_){
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 10),
                       curve: Curves.easeOut,
                      );
                    } );
                  });
                }}
          },
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    
                    child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                          enlargeCenterPage: true,

                          enlargeFactor: 0.20,

                          onPageChanged:(index,fn){
                            setState(() {
                              _currentIndex=index;

                            });
                      },
                    
                    
                        viewportFraction: 0.3333,
                          autoPlayCurve: Curves.bounceIn,height: 60.0),
                      items: generos.map((genre) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.333,
                                margin:  const EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 2),
                                decoration:  BoxDecoration(
                                    color: (genre.id==selectedGenreId)? const Color.fromARGB(255, 22, 0, 0):const Color.fromARGB(255, 125, 17, 17),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(20))),
                                child: ShortcutController(
                                  focusNode: focusNodeGeneros,
                                  widget: TextButton(
                                    autofocus: true,
                                    //focusNode: focusNodeGeneros,
                                    style: ButtonStyle(
                                     overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused)) {
                                return Colors.red; // Cambia esto al color que desees para el foco
                              }
                              return Colors.orange; // Usa el color predeterminado para otros estados
                                    },
                                  ),
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
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () {
                    
                                      setState(() {
                    
                                        selectedGenreId = genre.id;
                                        if (genre.id != 'All') {
                                          selectedGenderMovies = moviesProviders
                                              .Todo[generos.indexOf(genre)];
                                        }
                                       // _carouselController.animateToPage(_currentIndex) ;

                                        scrollController.animateTo(180, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
                                        // Centramos y seleciionamos
                                        setState(() {
                                          _animateToSelectedPage(_currentIndex);
                                        });

                                        //Focus.of(context).requestFocus(focusNodePeticion.children.last);

                                        //Toma foco primera
                                        //FocusScope.of(context).requestFocus(focusNode3);
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

                ])),
                 SliderVertical(
                  //focusNodePeticionSliderr: focusNodeSliderPeticion,
                  ///focusNodegGeneros: focusNodeGeneros,
                  //focusNodeslider: focusNodeSlider,
                    key: const Key("pelis"),
                    selectedMovies:(selectedGenreId=='All')?moviesProviders.Estrenos :
                  moviesProviders.Todo[moviesProviders.posicion(selectedGenreId)],onNextPage:  (){(selectedGenreId=='All')?moviesProviders.getEstrenosMovies() :
                  moviesProviders.Aumentar_Numero(selectedGenreId);}, scrollController: scrollController,),
                


              ])),
        ),
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
  //final FocusNode focusNodePeticionSliderr;
  //final FocusNode focusNodeslider;
  //final FocusNode focusNodegGeneros;
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
       
   if  (widget.scrollController.position.pixels >=
          widget.scrollController.position.maxScrollExtent-100
           && _isLoading ==false
           ) {
            // ignore: await_only_futures
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
    //widget.focusNodePeticionSliderr.dispose();
    //widget.focusNodeslider.dispose();
    //widget.focusNodegGeneros.dispose();
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
                  mainAxisSpacing:  8,
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
          //autofocus:true,
        style: ButtonStyle(
          
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return Colors.red; // Cambia esto al color que desees para el foco
        }
        return null; // Usa el color predeterminado para otros estados
      },
    ),
     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(
            color: Color.fromARGB(179, 0, 0, 0),
          ),
        ),
      ),
        ),

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

                      borderRadius: BorderRadius.zero,
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/icon.png'),
                        image: MemoryImage(
                            base64Decode(moviefinal.backdropPath.split(',').last)),
                        //NetworkImage(movie-final.posterPath),
                        imageErrorBuilder: (context, error, stackTrace) => Image(
                          image: const AssetImage('assets/icon.png'),
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.50,
                          fit: BoxFit.contain,
                        ),
                        width:  MediaQuery.of(context).size.width * 0.50,
                        height: 200, //imagen
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

  checkImage(Movie moviefinal) {
    PPrint (moviefinal);
    if (isBase64(moviefinal.backdropPath.split(',').last)){
     return MemoryImage(
            base64Decode(moviefinal.backdropPath.split(',').last));
    }else {
      return const AssetImage('assets/icon.png');
    }
  }

}
