import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'إذاعة علام',
      debugShowCheckedModeBanner: false,
      home: PodcastHomeScreen(),
    );
  }
}

class PodcastHomeScreen extends StatefulWidget {
  @override
  _PodcastHomeScreenState createState() => _PodcastHomeScreenState();
}

class _PodcastHomeScreenState extends State<PodcastHomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _setupAudioPlayer() async {
    // Uncomment the following line to fetch audio from an API
    // String audioUrl = await _fetchAudioFromAPI(); // Fetch audio URL from API

    // Use the local audio file instead of fetching from an API
    const audioUrl = 'assets/Audio/radio.mp3'; // Local audio file path
    try {
      await _audioPlayer.setAsset(audioUrl); // Use setAsset for local audio
    } catch (e) {
      _showErrorDialog('فشل في تحميل ملف الصوت. الرجاء التحقق من المسار أو المحاولة لاحقًا.');
    }

    // Listen for player state changes
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  // Example function to fetch audio URL from an API
  Future<String> _fetchAudioFromAPI() async {
    // Replace with your actual API URL
    final response = await http.get(Uri.parse('https://yourapi.com/api/audio/1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['audioUrl']; // Adjust based on your API's response structure
    } else {
      throw Exception('فشل في جلب البيانات من الخادم');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _togglePlayback() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 80.0,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.circle_notifications,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Add notification functionality here
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
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _togglePlayback,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16.0),
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 64.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'اذاعة علام',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Allam radio',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/logo-white.png',
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(width: 8.0),
                        SvgPicture.asset(
                          'assets/icons/شعار وزارة الإعلام SVG.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'رعاة اذاعة علام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}