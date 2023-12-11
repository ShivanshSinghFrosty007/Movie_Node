import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class playerPage extends StatefulWidget {
  const playerPage({super.key, required this.video});

  final String video;

  @override
  State<playerPage> createState() => _playerPageState();
}

class _playerPageState extends State<playerPage> {
  late VideoPlayerController controller;
  late ChewieController chewieController;

  static const videoBaseUrl = "http://192.168.0.100:5000/qwerty123/video/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse(videoBaseUrl + widget.video))
          ..initialize();
    chewieController = ChewieController(
      videoPlayerController: controller,
      fullScreenByDefault: true,
      allowFullScreen: true,
    );
    setState(() {});
  }

  @override
  dispose() {
    chewieController.pause();
    chewieController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }
}
