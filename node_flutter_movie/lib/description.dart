import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:node_flutter_movie/player.dart';

class descPage extends StatefulWidget {
  const descPage(
      {super.key,
      required this.videoLink,
      required this.desc,
      required this.image});

  final String videoLink;
  final String desc;
  final String image;

  @override
  State<descPage> createState() => _descPageState();
}

class _descPageState extends State<descPage> {
  static const imageBaseUrl = "http://192.168.0.100:5000/qwerty123/image/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller = VideoPlayerController.networkUrl(
    //     Uri.parse(imageBaseUrl + widget.videoLink))
    //   ..initialize();
    // controller.addListener(() {
    //   setState(() {});
    // });
    // // controller.play();
    // chewieController = ChewieController(
    //     videoPlayerController: controller,
    //     aspectRatio: controller.value.aspectRatio,
    //     customControls: progressBar());
    // chewieController.play();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("images/playerback.jpg"),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.black,
                        height: 210,
                        width: MediaQuery.sizeOf(context).width,
                        child: Image.network(
                          imageBaseUrl + widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.play_circle,
                          size: 80,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => playerPage(
                                video: widget.videoLink,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.desc,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
