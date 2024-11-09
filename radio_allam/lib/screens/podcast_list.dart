import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';
import '../models/radio_channel.dart';

class PodcastList extends StatelessWidget {
  final PodcastController podcastController = Get.put(PodcastController());

  final List<RadioChannel> podcasts = [
    RadioChannel(name: 'صباح السعودية', imageUrl: 'assets/images/arabia.jpg', streamUrl: 'assest/audio/radio.mp3'),
    RadioChannel(name: 'اخبار علام', imageUrl: 'assets/images/p2.png', streamUrl: 'assest/audio/TvQuran.com__108.mp3'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        final podcast = podcasts[index];
        return ListTile(
          title: Text(podcast.name),
          leading: Image.asset(podcast.imageUrl),
          onTap: () {
            podcastController.playRadio(podcast.streamUrl);
          },
        );
      },
    );
  }
}