import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yml/widgets/video_local.dart';

class VideoSelecter extends StatefulWidget {
  const VideoSelecter({
    super.key, required this.genreID, required this.isTVorWidows,
    
  });
 final bool  isTVorWidows;
final String genreID;

  @override
  State<VideoSelecter> createState() => _VideoSelecterState();
}

class _VideoSelecterState extends State<VideoSelecter> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      bool isAndoid = Platform.isAndroid; 
     
     if(widget.isTVorWidows){return VideoHorizontal(genreId: widget.genreID,aspectRatio:100/20 , )  ;}
      else {    return VideoHorizontal(genreId: widget.genreID,aspectRatio:100/40)  ;}
    },);
    // return (Platform.isWindows)? VideoHorizontalTVyWindows(movie: widget.movie):
    //  OrientationBuilder(builder: (context, orientation) =>  VideoHorizontalCelular(movie: widget.movie, estaVirado: orientation != Orientation.portrait),);
  }
}


class VideoHorizontal extends StatefulWidget {
  const VideoHorizontal({
    super.key, required this.genreId, required this.aspectRatio,
  
  });

  final String genreId;
 // final bool estaVirado;
  final double aspectRatio;

  @override
  State<VideoHorizontal> createState() => _VideoHorizontalState();
}

class _VideoHorizontalState extends State<VideoHorizontal> {
  @override
  Widget build(BuildContext context) {
  
    
  final String ruta ='assets/video/${widget.genreId}.mp4';
  return SizedBox(
  height: 150,
  width: 100,
  child: VideoWidget(route: ruta, aspectRatio: widget.aspectRatio),
    );
      }
}