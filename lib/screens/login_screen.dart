import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yml/screens/device_screen.dart';
import 'package:yml/widgets/raw_listener.dart';


import '../generated/l10n.dart';
import '../models/route_animation.dart';
import '../providers/movie_providers.dart';
import '../providers/user_provider.dart';
import '../src/bloc/login_bloc.dart';
import '../src/bloc/provider.dart';
import '../src/preferencias_usuario.dart';
import '../widgets/alarms_dialog.dart';
import 'screens/HomeScreen.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final prefs = PreferenciasUsuario();
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');


  bool showpass = true;
  final userRegisterProvider = UserProvider();
  @override
  void initState() {
     super.initState();

    
   
  
   
    final username = prefs.usuario;
    final password = prefs.password;
    _usernameController.text = username;
    _passwordController.text = password;
     if(username!=''){

       _loginRegistered();

    }
  
  }
 Future<String> obtenerModeloDispositivo() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //print('Modelo del dispositivo: ${androidInfo.model}');
    return androidInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Modelo del dispositivo: ${iosInfo.utsname.machine}');
    return iosInfo.model;
  }
  WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
  
return windowsInfo.productName;
}
  Future<String> _IdDevice () async {
     final deviceInfo = DeviceInfoPlugin();
 if(Platform.isWindows){WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
  
return windowsInfo.productId;}
  String deviceId = await FlutterUdid.udid;
 // Wakelock.enable();
  return deviceId;
  }
_loginRegistered() async{
   String deviceId = await _IdDevice();
   String model = await obtenerModeloDispositivo();

    //aqui va el coso dese de cargar mientras espera
//TODO: ENVIAR ID
    Map info = await userRegisterProvider.loginUser(_usernameController.text, _passwordController.text,model,deviceId);

    if (info['ok']) {
      if (prefs.Rememberme) {
        SharedPreferences.getInstance().then((prefs) {
        prefs.setString('deviceId', deviceId);
          prefs.setString('deviceId', deviceId);
          prefs.setString('usuario', _usernameController.text);
          prefs.setString('password', _passwordController.text);
     
        });
      } else {
        SharedPreferences.getInstance().then((prefs) {
           prefs.setString('usuario', '');
          prefs.setString('password', '');
        });
      }
       // ignore: use_build_context_synchronously
       Navigator.pushReplacement(
        context,
        crearRuta(
            FutureBuilder(
              future: Provider.of<MoviesProviders>(context,listen: false).getEstrenosMovies(),
              builder: (context, snapshot){if(snapshot.hasData){return const HomeSreen();}else {
                return Container ( color:Colors.black ,  child: const Center(child: CircularProgressIndicator(),));
              }},
            ),
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      );
    } else if(info.containsValue('Demasiados dispositivos Vinculados')){
        SharedPreferences.getInstance().then((prefs) {
         prefs.setString('deviceId', deviceId);
          prefs.setString('deviceId', deviceId);
          
        });
    // ignore: use_build_context_synchronously
    Navigator.push(
                      context,
                      crearRuta(
                    Dispositivos(Usuario:_usernameController.text )
                    ,
                         
                          const Duration(milliseconds: 300)),
                    );
      }else {
      Alarm().showAlarm(
          context, ClassLocalizations.of(context).wrongPassCorreo, info['mensaje']);
    }

}
  
  @override
  void dispose() {
  
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: true, 
        body: Container(
          child: Stack(
              children: <Widget>[_crearFondo(context),  _login_form(context)],
            ),
        ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
   
    final fondoMorado = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: <Color>[Colors.black, Colors.redAccent])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return SingleChildScrollView(
      
      child: Stack(
        children: <Widget>[
          fondoMorado,
          Positioned(top: 90.0, left: 30.0, child: circulo),
          Positioned(top: -40.0, right: -30.0, child: circulo),
          Positioned(top: -50.0, right: -10.0, child: circulo),
          Positioned(top: 120.0, right: 20.0, child: circulo),
          Positioned(top: -50.0, left: -20.0, child: circulo),
          Container(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  
                  width: MediaQuery.of(context).size.width *0.1,
                  child:  const Image(image: AssetImage('assets/icon.png')),
                ),
                const SizedBox(height: 10.0, width: double.infinity),
                const Text(
                  'YML-LIVE',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _login_form(BuildContext context) {
    final bloc = ProviderP.of(context);
    final size = MediaQuery.of(context).size;
//saqui

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      
      child: Column(
        children: <Widget>[
          // distancia
          Container(height:200,),
          
          Container(
            width: (Platform.isWindows)? size.width * 0.33   :(size.width>500)? size.width* 0.50 :size.width * 0.85,
            margin: const EdgeInsets.symmetric(vertical: 30.0),
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 0.5),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ClassLocalizations.of(context).iniciarSesion,
                      style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ), 
                 
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                _crearEmail(bloc),
                const SizedBox(
                  height: 30.0,
                ),
                _crearPassword(bloc),
                const SizedBox(
                  height: 10.0,
                ),
                _checkbox(),
                const SizedBox(
                  height: 10.0,
                ),
                _crearBoton(bloc),
              ],
            ),
          ),
          //TeXTO A pantalla de registro
          /*Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ClassLocalizations.of(context).noTienesCuenta),
              GestureDetector(
                child: Text(
                  ClassLocalizations.of(context).registrate,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
                ),
                onTap: () {
                 // Navigator.pushReplacementNamed(context, 'register');
                },
              )
            ],
          ),
        */],
      ),
    );
  }

  Row _checkbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: prefs.Rememberme,
          onChanged: (value) => setState(() {
            prefs.Rememberme = !prefs.Rememberme;
          }),
        ),
        Text(ClassLocalizations.of(context).recordar)
      ],
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: ClassLocalizations.of(context).aquiCorreo,
              labelText: ClassLocalizations.of(context).correo,
              errorText: snapshot.error?.toString(),
              suffixIcon: const Icon(Icons.alternate_email),
            ),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(

              // aqui es donde se va a hacer
              controller: _passwordController,
              obscureText: showpass,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: '**********',
                  labelText: ClassLocalizations.of(context).password,
                  errorText: snapshot.error?.toString(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      !showpass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showpass = !showpass;
                      });
                    },
                  )),
              onChanged: bloc.changePassword),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc,) {
    String botontext = ClassLocalizations.of(context).login;
    return StreamBuilder(
      stream: bloc.loginFormValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 0.0),
            onPressed: snapshot.hasData
                ? () {
                    _login(bloc, context);
                   // Alarm().showAlarm(
                    //    context, ClassLocalizations.of(context).espere, '!!!');
                  }
                : null,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              child: Text(botontext),
            ),
          );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
   String deviceId = await _IdDevice();
   String model = await obtenerModeloDispositivo();
    //aqui va el coso dese de cargar mientras espera
//TODO: ENVIAR ID
    Map info = await userRegisterProvider.loginUser(_usernameController.text, _passwordController.text,model,deviceId);

    if (info['ok']) {
      if (prefs.Rememberme) {
        SharedPreferences.getInstance().then((prefs) {
        prefs.setString('deviceId', deviceId);
          prefs.setString('deviceId', deviceId);
          prefs.setString('usuario', _usernameController.text);
          prefs.setString('password', _passwordController.text);
     
        });
      } else {
        SharedPreferences.getInstance().then((prefs) {
           prefs.setString('usuario', '');
          prefs.setString('password', '');
        });
      }
       Navigator.pushReplacement(
        context,
        crearRuta(
            FutureBuilder(
              future: Provider.of<MoviesProviders>(context,listen: false).getEstrenosMovies(),
              builder: (context, snapshot){if(snapshot.hasData){return const HomeSreen();}else {
                return Container ( color:Colors.black ,  child: const Center(child: CircularProgressIndicator(),));
              }},
            ),
            //RegisterScreen(),
            const Duration(milliseconds: 700)),
      );
    } else if(info.containsValue('Demasiados dispositivos Vinculados')){
        SharedPreferences.getInstance().then((prefs) {
         prefs.setString('deviceId', deviceId);
          prefs.setString('deviceId', deviceId);
          
        });
    Navigator.push(
                      context,
                      crearRuta(
                    Dispositivos(Usuario:_usernameController.text )
                    ,
                         
                          const Duration(milliseconds: 300)),
                    );
      }else {
      Alarm().showAlarm(
          context, ClassLocalizations.of(context).wrongPassCorreo, info['mensaje']);
    }

    /*.then((value) {
      if (screensize.width >= 500) {
        Navigator.push(
            context,
            crearRuta(
                HomeScreenTV(
                  height: 0.8,
                  width: 0.6,
                ),
                Duration(milliseconds: 700)));
      } //animcion abajo
      else
        Navigator.push(
          context,
          crearRuta(
              HomeScreen(height: 0.5, width: 0.6),
              //RegisterScreen(),e
              Duration(milliseconds: 700)),
        );
    });
*/
    //if ( == 200) {

    //}
    // else {

    // }
  }
}
/*class prov extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => MoviesProviders(),
        lazy: false,
      ),
    ]);
  }
}*/
