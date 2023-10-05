import 'dart:convert';
import 'package:http/http.dart' as http;


import '../screens/details_screens.dart';
import '../src/preferencias_usuario.dart';

class UserProvider {
  final _us = prefs.usuario;
  final _pas = prefs.password;
  final _global = PreferenciasUsuario();
  Future<Map<String, dynamic>> registerUser(
      String nombre, String apellido, String correo, String password) async {
    final authData = {
      'name': nombre,
      'lastname': apellido,
      'email': correo,
      'password': password
      //'returnSecureToken' : true
    };

    final response = await http.post(
        Uri.parse('http://yml-live.com:3003/auth/signup'),
        body: authData);
   
    Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp.containsKey('valid')) {
      _global.Token = decodedResp['valid'].toString();
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
    // final url = 'http://app-b4b84fdd-2d5f-4011-bad7-5b43052f49df.cleverapps.io/auth/signup';
    // final headers = {'Content-Type': 'application/json'};
    // final body = jsonEncode({'nombre': nombre, 'apellido': apellido,'correo': correo, 'password': password});
    // final response = await http.post(url as Uri, headers: headers, body: body);
  }

  Future<Map<String, dynamic>> loginUser(String correo, String password) async {
    Map<String, String> authData = {'email': correo, 'password': password};
    if (_us.isNotEmpty && _pas.isNotEmpty) {
      authData = {'email': _us, 'password': _pas};
     
    }

    //'returnSecureToken' : true
    json.encode(authData);

    final response = await http.post(
        Uri.parse('http://yml-live.com:3003/auth/signin'),
        body: authData);
   
    final Map<String, dynamic> decodedResp = json.decode(response.body);
    if (decodedResp.containsKey('token')) {
      _global.Token = decodedResp['token'];
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
  }
}
