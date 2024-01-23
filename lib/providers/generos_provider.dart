// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/generos.dart';
import '../screens/details_screens.dart';
import 'generos_response.dart';

class GeneroProvider extends ChangeNotifier {
  final String _url = 'yml-live.me:3003';
  String end = '/movies/genres';
  List<Genero> Gneroos = [];
  GeneroProvider() {
    getGneroos();
  }

  Future<List<Genero>> getGneroos() async {
    final url = Uri.http(_url, end);
    final resp = await http.get(url, headers: {'auth-token': prefs.Token});

    final decodedData = json.decode(resp.body);
   
    final genders = Generos.fromJson(resp.body);

    Gneroos = genders.results;
    Gneroos.add(Genero(
        id: 'All',
        genre: 'Todas',
        isDeleted: false,
        updatedAt: DateTime(2017)));
    notifyListeners();
    return genders.results;
  }
}
