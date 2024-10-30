import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_allam/controllers/podcast_controller.dart';
import 'package:radio_allam/live.dart'; // تأكد من استيراد ويدجت Live
import 'package:radio_allam/PodcastList.dart';
import 'package:radio_allam/menu.dart';
import 'package:radio_allam/Frame3.dart';

class HomeScreen extends StatelessWidget {
  final PodcastController podcastController = Get.put(PodcastController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // اجعل AppBar مثبتًا
            expandedHeight: 80.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.circle_notifications,
                    color: Colors.black,
                    size: 30,
                  ), // أيقونة التنبيهات
                  onPressed: () {
                    // إضافة وظيفة التنبيهات هنا
                  },
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            centerTitle: false,
            elevation: 10,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                  Live(), // أضف ويدجت Live هنا
                  SizedBox(height: 5),
                  PodcastList(), // أضف قائمة البودكاست هنا
                ],
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: podcastController.radioChannels.length,
            itemBuilder: (context, index) {
              final channel = podcastController.radioChannels[index];
              return GestureDetector(
                onTap: () {
                  podcastController.playRadio(channel.streamUrl);
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.network(
                          channel.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              channel.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Obx(() => Text(
                              podcastController.isPlaying.value
                                  ? 'يعمل الآن'
                                  : 'اضغط للتشغيل',
                              style: TextStyle(color: Colors.grey),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
       bottomNavigationBar: Menu(), // Include your Menu widget here
    );
  }
}
