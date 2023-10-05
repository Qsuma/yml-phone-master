import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:yml/widgets/raw_listener.dart';

import '../../models/movie.dart';
import '../../models/route_animation.dart';
import '../../screens/details_screens.dart';

class ChewiePlayer extends StatefulWidget {

  final Movie movie;
  //final VideoPlayerController videoPlayerController;
  const ChewiePlayer(
      {super.key,
      //required this.videoPlayerController,
      required this.movie,});

  @override
  State<ChewiePlayer> createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  
   bool isPlaying = true;



  


  

  _ChewiePlayerState();
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  
  @override
  void initState(){
    
  super.initState();
  
  videoPlayerController = VideoPlayerController.networkUrl(
                              //**quitar el replace
                              Uri.parse(widget.movie.video.replaceAll('localhost', '192.168.72.239')
                              ),
                              httpHeaders: {
                                'Range': 'bytes = 0-1023',
                                'auth-token': prefs.Token
                              },
                            );
                      
 chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      // ignore: prefer_const_constructors
     // errorBuilder: (context, errorMessage) =>  Center(
     //   child: CircularProgressIndicator(),
     // ),
      autoPlay: true,
      looping: true,
    );    
  }

   @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
           leading:  IconButton(
                   splashRadius: 20,
              focusColor: const Color.fromARGB(134, 132, 132, 132),
              color: Colors.red,
               icon: const Icon(Icons.arrow_back),
               onPressed: () {
                Navigator.pop(context);
               },
             ),
          
          title: Text(widget.movie.title),
        ),
        //backgroundColor: Colors.black87,
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Chewie(controller: chewieController)));
  }

 
}
