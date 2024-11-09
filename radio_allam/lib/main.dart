import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
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
  List<String> audioUrls = []; // List of audio URLs
  int currentAudioIndex = 0;

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
    try {
      audioUrls = await _fetchAudioFromAPI(); // Fetch audio URLs from API
      if (audioUrls.isNotEmpty) {
        await _audioPlayer.setUrl(audioUrls[currentAudioIndex]); // Set the first audio URL
      }
    } catch (e) {
      _showErrorDialog('فشل في تحميل قائمة الصوتيات. الرجاء المحاولة لاحقًا.');
    }

    // Listen for player state changes
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  // Fetch a list of audio URLs from the API (example)
  Future<List<String>> _fetchAudioFromAPI() async {
    // Replace with your actual API URL
    final response = await http.get(Uri.parse('https://yourapi.com/api/audio'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Assuming the response contains a list of audio URLs under 'audioUrls'
      List<String> urls = List<String>.from(data['audioUrls']);
      return urls;
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

  // Play the next audio in the list
  void _playNextAudio() async {
    if (currentAudioIndex < audioUrls.length - 1) {
      setState(() {
        currentAudioIndex++;
      });
      await _audioPlayer.setUrl(audioUrls[currentAudioIndex]);
      await _audioPlayer.play();
    } else {
      _showErrorDialog('لا توجد حلقات أخرى للاستماع إليها.');
    }
  }

  // Play the previous audio in the list
  void _playPreviousAudio() async {
    if (currentAudioIndex > 0) {
      setState(() {
        currentAudioIndex--;
      });
      await _audioPlayer.setUrl(audioUrls[currentAudioIndex]);
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
                        IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: _playPreviousAudio,
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next),
                          onPressed: _playNextAudio,
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
