import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/podcast_controller.dart';
import 'live.dart';
import 'podcast_list.dart';
import '../menu.dart';
class HomeScreen extends StatelessWidget {
  final PodcastController podcastController = Get.put(PodcastController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إذاعة علام'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Live(),
                  SizedBox(height: 16),
                  PodcastList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Menu(),
    );
  }
}