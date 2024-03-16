import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.route, required this.aspectRatio});
final String route;
final double aspectRatio;
  @override
   // ignore: library_private_types_in_public_api
   _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
   initState()  {
    super.initState();
    _controller =  VideoPlayerController.asset(widget.route)..initialize().then((_) {});
    
        _controller.play();
        _controller.setLooping(true);
        setState(() { });
  }
 @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    setState(() {
      
    });
    return Center(
      
          child:
               AspectRatio(
                  aspectRatio: widget.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              ,
        );
  }

}