import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import '../globals/globals.dart';
import '../helpers/debouncer.dart';
import '../models/generos.dart';
import '../models/listar_peliculas.dart';
import '../models/movie.dart';
import '../models/search_response.dart';
import '../src/preferencias_usuario.dart';
import 'generos_provider.dart';

class MoviesProviders extends ChangeNotifier {
  //http://app-b4b84fdd-2d5f-4011-bad7-5b43052f49df.cleverapps.io/movies/google/video/6431763d47b2a4a091b0418b
  final prefs = PreferenciasUsuario();
 

  final String _baseURL = 'yml-live.com:3003';

  List<List<Movie>> Todo = [];
  List<Movie> Estrenos = [];
  List<int> Paginas=[];
  
  List<Movie> GenderMovies = [];
  List<Genero>gener = [];
  int GeneroPage =0;
  int TodasPage = 0;
  

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;
  MoviesProviders() {
   // getEstrenosMovies();
    //getGenderMovies('644f6e78925b5b5f003b44c1');
   // getTodo();
  }
// agrupar por generos segun me caigan
  // BuildContext get context => context;

  //ESTABLECER Q IDIOMA VA A MANDAR DEPENDIENDO DEL IDIOMA
  Future<String> _getJsonData(String endpoint, int page) async {
    //Locale locale = Localizations.of(context, String);
    final url = Uri.http(_baseURL, endpoint, {
      //'language': prefs.Idioma,
      'page': '$page',
      'limit': '10'
    });

    final response =  await http.get(url, headers: {
      'auth-token': prefs.Token
      
      // ignore: prefer_const_constructors
      }).timeout(Duration(seconds: 45),onTimeout: () {
    // Time has run out, do what you wanted to do.
    return http.Response('Error', 408); // Request Timeout response status code
  } );
    

    return response.body;
  }

  getEstrenosMovies() async {
   TodasPage++;
    final jsonData = await _getJsonData('/movies/list', TodasPage);
  
    final nowPlayingResponse = ListaPeliculas.fromJson(jsonData);

    Estrenos.addAll(nowPlayingResponse.results);
    notifyListeners();
    if(TodasPage ==1){ await getTodo();
   }
    return nowPlayingResponse.results;
  }

  Future<List<List<Movie>>> getTodo() async {

   

       List<Genero> generos = await GeneroProvider().getGneroos();
        gener = generos;
    
  
    

    if (generos.isNotEmpty) {
      for (int i = 0; i < generos.length; i++) {
        Paginas.add(0);
        if (generos[i].id != 'All') {
          Todo.add(await getGenderMovies(generos[i].id));
        }

     
      }
     
    }
   

    notifyListeners();
    return Todo;
  }
  Aumentar_Numero(String genderId) async {
        Todo[_posicion(genderId)].addAll(await getGenderMovies(genderId));
  }
  Future<List<Movie>> getGenderMovies(String genderId) async {
      Paginas.insert(_posicion(genderId), Paginas[_posicion(genderId)]+1);


    final jsonData =
        await _getJsonData('/movies/filter/$genderId',Paginas[_posicion(genderId)]);
    final GenreResponse = ListaPeliculas.fromJson(jsonData);
  

    //notifyListeners();
    return GenreResponse.results;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.http(
      _baseURL,
      '/movies/search/$query',
    );
    final response = await http.get(url, headers: {'auth-token': prefs.Token});

    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String SearchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = SearchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
    int  _posicion(String Idgenero){
    List<String> IdGeneros=[];
    for(int i=0;i<gener.length;i++){
      IdGeneros.add(gener[i].id) ;
    } 

    return IdGeneros.indexOf(Idgenero);
  }

}
