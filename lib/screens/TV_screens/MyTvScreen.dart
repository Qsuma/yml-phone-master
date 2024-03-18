
import 'dart:async';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:yml/globals/globals.dart';
import 'package:yml/widgets/raw_listener.dart';
import 'package:yml/widgets/reproductor/Modulo_Stream_Windows.dart';

import '../../screens/details_screens.dart';

class MyTvScreen extends StatefulWidget {

  final String url;

  const MyTvScreen({super.key, required this.url});
  
  @override
  _MyTvScreenState createState() => _MyTvScreenState();
}
class _MyTvScreenState extends State<MyTvScreen> {
  
  late VideoPlayerController _controller;
  bool menuVisible =false;
   late bool error;
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();
play(){
  _controller.play();
  Timer( const Duration(seconds: 3), () {setState(() {
    menuVisible= false;
  }); });
}


_listener() {
  }
  @override
  @override
  void initState() {
    super.initState();

    // Configura el controlador para que se inicialice automáticamente
    _controller = VideoPlayerController.networkUrl(
      
      Uri.parse(widget.url.replaceAll('yml-live.com', 'yml-live.me')),
      httpHeaders: {
        'Range': 'bytes =  0-1023',
        'auth-token': prefs.Token,
      },
    );

    // Agrega un listener para manejar los errores
    _controller.addListener(() {
      if (_controller.value.hasError) {
        error = true;
        PPrint("Error al inicializar el controlador de video: ${_controller.value.errorDescription}");
        // Aquí podrías implementar una lógica para manejar el error, como mostrar un diálogo al usuario
      }
    });

    // Intenta inicializar el controlador y maneja los errores
    _controller.initialize().then((_) {
      // Una vez inicializado, establece el estado de reproducción en bucle
      _controller.setLooping(false);
      _controller.play();
      

      // Actualiza el estado de la UI
      setState(() {});
    }).catchError((error) {
      print('ERROR $error');
     showDialog(context: context, builder:(context) => AlertDialog(
            backgroundColor: Colors.white70.withOpacity(1),
            title: Center(
                child: Text(
              'Error al Reproducir',
              style: const TextStyle(color: Colors.red),
            )),
            content: Text(
              'Error:${error}',
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: const Center(
                    child: Text(
                      'Ok',
                      style: TextStyle(fontSize: 17),
                    ),
                  ))
            ],
          ),);
      // Aquí podrías implementar una lógica para manejar el error, como mostrar un diálogo al usuario
    });
  }

  @override
  void dispose() {
    // Elimina los listeners y libera los recursos
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: RawKeyboardListener(
        autofocus: true,
        focusNode: focusNode6,
         onKey:  (RawKeyEvent event) async {
          
             if (event is RawKeyDownEvent) {
         
                if(event.logicalKey.keyLabel!="Media Play Pause"){
                  setState(() {
                    menuVisible =true;
                  });
                }

               if(event.logicalKey.keyLabel=="Media Play Pause"){
                
                _controller.value.isPlaying ? _controller.pause() : play();
                 setState(() {
                super.setState(() {
                 
                });
              });
              }
             
              else if(event.logicalKey.keyLabel=="Media Rewind"){
                 // PAra Atras
                 var position=  await  _controller.position;

                 _controller.seekTo(Duration(seconds: position!.inSeconds-5));
                // _controller.value.isPlaying ? _controller.pause() : _controller.play();
               }
              else if(event.logicalKey.keyLabel=="Media Fast Forward"){
                 // PAra Alante
                 var position=  await _controller.position;

                _controller.seekTo(Duration(seconds: position!.inSeconds+5));
               }
             

             }
             },
    child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(height:MediaQuery.of(context).size.height,width: double.infinity,
          child: VideoPlayer(_controller),
                ),
         (menuVisible)? _ControlsOverlay(controller: _controller,focusNode1: focusNode1,focusNode2: focusNode2,focusNode3: focusNode3,):const SizedBox(),
         (menuVisible)? VideoProgressIndicator(   _controller, allowScrubbing: true):const SizedBox(),
         Positioned(
          top: 10,
          left: 10,
           child: ShortcutController(
            focusNode: focusNode,
             widget: MaterialButton(
              focusNode: focusNode,
             
               focusColor:const Color.fromARGB(187, 163, 162, 162),
              onPressed: () {
              
              setState(() {
                menuVisible =! menuVisible;
              });
             }, child:(menuVisible)?const Icon(Icons.fullscreen):const Icon(Icons.fullscreen_exit)),
           ),
         )
        
        
        ],
      ),

      )
    );
  }
 
}
class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller, required this.focusNode1, required this.focusNode2, required this.focusNode3})
      : super(key: key);

  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final FocusNode focusNode3;
  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          color: Colors.black26,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  ShortcutController(
                    focusNode: widget.focusNode1,
                    widget: MaterialButton(
                      focusColor: const Color.fromARGB(187, 163, 162, 162),
                      onPressed: () async{
                        var position=   await widget.controller.position;
                  
                        widget.controller.seekTo(Duration(seconds: position!.inSeconds-5));
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ShortcutController(
                        focusNode: widget.focusNode2,
                        widget: MaterialButton(
                        focusColor: const Color.fromARGB(187, 163, 162, 162),
                          
                                          child: widget.controller.value.isPlaying? const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30.0,
                                          ): const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 30.0,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              
                                            });
                        widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
                                          },
                                        ),
                      ),
                     
                  const SizedBox(width: 20,),
                  ShortcutController(
                    focusNode: widget.focusNode3,
                    widget: MaterialButton(
                      focusColor: const Color.fromARGB(187, 163, 162, 162),
                      onPressed: () async{
                        var position=   await widget.controller.position;
                  
                        widget.controller.seekTo(Duration(seconds: position!.inSeconds+5));
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                 
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }
}