import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';


const HtmlEscape htmlEscape = HtmlEscape();






class VideoLocalWindows extends StatefulWidget {
  final String genreID;
 


  const VideoLocalWindows({super.key, required this.genreID, });
  @override
  VideoLocalWindowsState createState() => VideoLocalWindowsState();
}

class VideoLocalWindowsState extends State<VideoLocalWindows> {


  Player player = Player(
    id: 0,
    videoDimensions: const VideoDimensions(0, 0),
  );
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(100, 0);
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

      player.open(Media.asset('assets/video/${widget.genreID}.mp4') ,autoStart: true);
 
      player.errorStream.listen((event) {
        debugPrint('libVLC error.');
      });
      devices = Devices.all;
      Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
      equalizer.setPreAmp(10.0);
      equalizer.setBandAmp(31.25, 10.0);
      player.setEqualizer(equalizer);
      
      
  

    }
  } 
  
  @override
  Widget build(BuildContext context) {


   
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
 
        return  Expanded(
          child: Video(fit: BoxFit.fill,
                        
                        player: player,
                        width: width,
                        height: height,
                        volumeThumbColor:Colors.red[300],
                        volumeActiveColor: Colors.red[300],
                        showControls: false,
                        
                      ),
        )
   ;
  }

  
}