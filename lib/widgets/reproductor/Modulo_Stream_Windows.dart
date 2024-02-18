
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';


import '../../models/movie.dart';
const HtmlEscape htmlEscape = HtmlEscape();






class DartVLCExample extends StatefulWidget {
  final Movie movie;
 


  const DartVLCExample({super.key, required this.movie});
  @override
  DartVLCExampleState createState() => DartVLCExampleState();
}

class DartVLCExampleState extends State<DartVLCExample> {


  Player player = Player(
    id: 0,
    videoDimensions: const VideoDimensions(0, 0),
  );
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(0, 0);
  List<Media> medias = <Media>[
  ];
  List<Device> devices = <Device>[];
  TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();
  double bufferingProgress = 0.0;
  Media? metadataCurrentMedia;
     bool isPlaying =true; 
     

  @override
  void initState() {

    super.initState();    
String unescaped = widget.movie.video;
String Url = htmlEscape.convert(unescaped);
    if (mounted) {
      player.currentStream.listen((value) {
        setState(() => current = value);
      });
      player.positionStream.listen((value) {
        setState(() => position = value);
      });
      player.playbackStream.listen((value) {
        setState(() => playback = value);
      });
      player.generalStream.listen((value) {
        setState(() => general = value);
      });
      player.videoDimensionsStream.listen((value) {
        setState(() => videoDimensions = value);
      });
      player.bufferingProgressStream.listen(
        (value) {
          setState(() => bufferingProgress = value);
        },
      );

      player.open(Media.network(Uri.parse(widget.movie.video.replaceAll('yml-live.com', 'yml-live.me'))),autoStart: true);
 
      player.errorStream.listen((event) {
        debugPrint('libVLC error.');
      });
      devices = Devices.all;
      Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
      equalizer.setPreAmp(10.0);
      equalizer.setBandAmp(31.25, 10.0);
      player.setEqualizer(equalizer);
      
      
      Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height-70, left: 20, right: 20),
          
          content: const Center(child: Text('¡Doble Clic para salir de Pantalla Completa!'))),
      );
    });

    }
  } 
  
  @override
  Widget build(BuildContext context) {
    bool isTablet;
    bool isPhone;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
 
        return  Scaffold(
          
          
                appBar:(!isPlaying)? AppBar(
                  actions: [IconButton(onPressed: (){
                    setState(() {
              
                    if(isPlaying){}

                isPlaying =true;  
                super.setState(() {
                
                });
                
                          });
                  }, icon:const Icon(Icons.fullscreen))],
                  leading: IconButton(
                  
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            player.stop();
            Navigator.pop(context);
          },
        ), 
          
                ):null,
              body:  GestureDetector(
                onDoubleTap: () {
                    setState(() {
                    isPlaying= !isPlaying;
                   });
                },
                child: Video(
                        
                        player: player,
                        width: width,
                        height: height,
                        volumeThumbColor:Colors.red[300],
                        volumeActiveColor: Colors.red[300],
                        showControls: !isPhone,
                        
                      ),
              ),
            );
  }

  
}