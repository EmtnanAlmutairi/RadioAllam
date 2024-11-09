import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';

class PodcastPlayer extends StatelessWidget {
  final PodcastController podcastController = Get.find<PodcastController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Podcast Player')),
      body: Center(
        child: Obx(() {
          return IconButton(
            icon: Icon(podcastController.isPlayerPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (podcastController.isPlayerPlaying) {
                podcastController.pause();
              } else {
                // You might want to add a way to determine which podcast to play
              }
            },
          );
        }),
      ),
    );
  }
}