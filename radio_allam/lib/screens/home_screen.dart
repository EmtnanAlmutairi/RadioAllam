import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import '../controllers/podcast_controller.dart';
import 'live.dart';
import 'podcast_list.dart';
import '../menu.dart';
=======
import 'package:radio_allam/controllers/podcast_controller.dart';
//import 'package:radio_allam/live.dart'; // تأكد من استيراد ويدجت Live
import 'package:radio_allam/PodcastList.dart';
import 'package:radio_allam/menu.dart';
//import 'package:radio_allam/Frame3.dart';

>>>>>>> a65a552742d5b151454178a896ebc44ac4631b97
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
<<<<<<< HEAD
                  Live(),
                  SizedBox(height: 16),
                  PodcastList(),
=======
                  SizedBox(height: 10),
                  TextField(
                    controller: searchController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن إذاعة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                  //Live(), // أضف ويدجت Live هنا
                  SizedBox(height: 5),
                  PodcastList(), // أضف قائمة البودكاست هنا
>>>>>>> a65a552742d5b151454178a896ebc44ac4631b97
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