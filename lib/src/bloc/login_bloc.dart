import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:yml/src/bloc/validators.dart';

class LoginBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get nameStream =>
      _nameController.stream.transform(validarNombre);
  Stream<String> get lastNameStream =>
      _lastNameController.stream.transform(validarApellidos);

  // COmbinación de Streams con RXDart'

  Stream<bool> get loginFormValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);
  Stream<bool> get registerFormValidStream => Rx.combineLatest4(nameStream,
      lastNameStream, emailStream, passwordStream, (n, ln, e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastName => _lastNameController.sink.add;

  // Obtener  el último valor ingresado por los streams

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get name => _nameController.value;
  String get lastName => _lastNameController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _lastNameController.close();
  }
}
