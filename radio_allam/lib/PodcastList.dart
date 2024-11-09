import 'package:flutter/material.dart';
import 'package:radio_allam/Frame3.dart';
import 'package:radio_allam/PodcastDetailScreen.dart';

class PodcastList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final podcasts = [
      {
        'title': 'اذاعة علام',
        'subtitle': 'mbcfm',
        'duration': '40 دقيقة',
        'imagePath': 'assets/images/logo.png',
        'audioUrl': 'assets/Audio/radio.mp3', // Example URL
      },
    ];

    return SingleChildScrollView(
      child: Column(
        children: podcasts.map((podcast) {
          return GestureDetector(
            onTap: () {
              print("Tapped podcast: ${podcast['title']}, URL: ${podcast['audioUrl']}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PodcastDetailScreen(
                    title: podcast['title']!,
                    subtitle: podcast['subtitle']!,
                    duration: podcast['duration']!,
                    imagePath: podcast['imagePath']!,
                    audioUrl: podcast['audioUrl']!,
                  ),
                ),
              );
            },
            child: Frame3(
              title: podcast['title']!,
              subtitle: podcast['subtitle']!,
              duration: podcast['duration']!,
              imagePath: podcast['imagePath']!,
            ),
          );
        }).toList(),
      ),
    );
  }
}