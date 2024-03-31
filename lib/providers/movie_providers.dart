// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:yml/globals/globals.dart';



import '../helpers/debouncer.dart';
import '../models/generos.dart';
import '../models/listar_peliculas.dart';
import '../models/movie.dart';
import '../models/search_response.dart';
import '../src/preferencias_usuario.dart';
import 'generos_provider.dart';

class MoviesProviders extends ChangeNotifier {
 
  final prefs = PreferenciasUsuario();
 

  final String _baseURL = 'yml-live.me:3003';

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
  MoviesProviders();

  Future<String> _getJsonData(String endpoint, int page) async {
   
    final url = Uri.http(_baseURL, endpoint, {
      
      'page': '$page',
      'limit': '6'
    });
 PPrint(url);
    final response =  await http.get(url, headers: {
      'auth-token': prefs.Token
      
      
      }).timeout(Duration(seconds: 45),onTimeout: () {
   
    return http.Response('Error', 408); 
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
   PPrint('GET ESTENOS Y LA PAGINA ES $TodasPage');
     notifyListeners();
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
        Todo[posicion(genderId)].addAll(await getGenderMovies(genderId));
  }
  Future<List<Movie>> getGenderMovies(String genderId) async {
      Paginas[posicion(genderId)]++;


    var jsonData =
        await _getJsonData('/movies/filter/$genderId', Paginas[posicion(genderId)]);
    var GenreResponse = ListaPeliculas.fromJson(jsonData);
  
 PPrint('GET Genders Y LA PAGINA ES ${Paginas[posicion(genderId)]}');
   // notifyListeners();
    return GenreResponse.results;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.http(
      _baseURL,
      '/movies/search/$query',
    );
    final response = await http.get(url, headers: {'auth-token': prefs.Token});
    PPrint(prefs.Token);

    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String SearchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
  
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      debouncer.value = SearchTerm;
    });
    Future.delayed(const Duration(milliseconds: 1001))
        .then((_) => timer.cancel());
  }
    int  posicion(String Idgenero){
    List<String> IdGeneros=[];
    for(int i=0;i<gener.length;i++){
      IdGeneros.add(gener[i].id) ;
    } 

    return IdGeneros.indexOf(Idgenero);
  }

}
