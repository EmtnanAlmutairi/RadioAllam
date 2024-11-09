import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';

class Live extends StatelessWidget {
  final PodcastController podcastController = Get.put(PodcastController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مباشر',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                podcastController.playRadio('رابط_البث_المباشر'); // استبدل برابط البث المباشر
              },
              child: Text('استمع الآن'),
            ),
          ],
        ),
      ),
    );
  }
}