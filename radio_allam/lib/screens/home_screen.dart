import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_allam/controllers/podcast_controller.dart';

class HomeScreen extends StatelessWidget {
  final podcast_controller = Get.put(RadioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Radio'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjust aspect ratio for card size
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: podcast_controller.radioChannels.length,
          itemBuilder: (context, index) {
            final channel = podcast_controller.radioChannels[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: GestureDetector(
                onTap: () {
                  podcast_controller.playRadio(channel.streamUrl);
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Obx(() => Text(
                            podcast_controller.isPlaying.value ? 'Now Playing' : 'Tap to Play',
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
      ),
    );
  }
}
