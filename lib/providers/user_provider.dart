import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:yml/models/device.dart';


import '../screens/details_screens.dart';
import '../src/preferencias_usuario.dart';


class UserProvider extends ChangeNotifier {
List<DeviceElement> devices=[];
 
  final _us = prefs.usuario;
    final _id = prefs.deviceId;
  final _pas = prefs.password;
  final _device =prefs.model;
  final _global = PreferenciasUsuario();
  UserProvider();
  Future<Map<String, dynamic>> registerUser(
      String nombre, String apellido, String correo, String password) async {
    final authData = {
      'name': nombre,
      'lastname': apellido,
      'email': correo,
      'password': password
    };

    final response = await http.post(
        Uri.parse('http://yml-live.me:3003/auth/signup'),
        body: authData);
   
    Map<String, dynamic> decodedResp = json.decode(response.body);
    

    if (decodedResp.containsKey('valid')) {
      _global.Token = decodedResp['valid'].toString();
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
    
  }
   peticionDevices (String correo, String password,String device,String device_id) async {
    Map<String, String> authData = {'email': correo, 'password': password,'device':device,'device_id': device_id};
     if (_us.isNotEmpty && _pas.isNotEmpty && _id.isNotEmpty && _device.isEmpty ) {
      authData = {'email': _us, 'password': _pas,'device':_device, 'device_id': _id};
     }
      json.encode(authData);
         final response = await http.post(
        Uri.parse('http://yml-live.me:3003/auth/signin'),

        body: authData);
        final Map<String, dynamic> decodedResp = json.decode(response.body);
        return List<DeviceElement>.from(decodedResp['device'].map((x) => DeviceElement.fromJson(x)));
  }
 
 
  Future<Map<String, dynamic>> loginUser(String correo, String password,String device,String device_id) async {
    Map<String, String> authData = {'email': correo, 'password': password,'device':device,'device_id': device_id};
    if (_us.isNotEmpty && _pas.isNotEmpty && _id.isNotEmpty && _device.isEmpty ) {
      authData = {'email': _us, 'password': _pas,'device':_device, 'device_id': _id};
     }

    json.encode(authData);

    final response = await http.post(
        Uri.parse('http://yml-live.me:3003/auth/signin'),

        body: authData);
    final Map<String, dynamic> decodedResp = json.decode(response.body);
   if(decodedResp.containsKey('token')){
    _global.Token = decodedResp['token'];
    return { 'ok':true};
    }else {
      if(decodedResp.containsKey('device')){
    
    

      devices =List<DeviceElement>.from(decodedResp['device'].map((x) => DeviceElement.fromJson(x)));
      prefs.Devices = jsonEncode(devices);
      return {'ok': false,'mensaje': 'Demasiados dispositivos Vinculados'};}
      else return{'ok': false, 'mensaje': decodedResp['message']};
   
   
   
   
   
    
}

     }
  Future<void> Deletedevice(String correo,String device,String device_id) async {
    Map<String, String> authData = {'email': correo, 'device':device,'device_id': device_id};
    

    json.encode(authData);

    final response = await http.post(
        Uri.parse('http://yml-live.me:3003/user/del-device'),

        body: authData);
     }
  
  }