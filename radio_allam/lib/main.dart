import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_audio_handler.dart';
import 'screens/home_screen.dart';

void main() {
  // Register CustomAudioHandler with GetX
  Get.put(CustomAudioHandler());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podcast App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}