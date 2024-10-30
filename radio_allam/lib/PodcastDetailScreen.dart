import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PodcastDetailScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String imagePath;
  final String audioUrl;

  PodcastDetailScreen({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.imagePath,
    required this.audioUrl,
  });

  @override
  _PodcastDetailScreenState createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
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

  void _setupAudioPlayer() async {
    print("Setting up audio player with URL: ${widget.audioUrl}");
    try {
      await _audioPlayer.setUrl(widget.audioUrl);
      print("Audio URL set successfully.");
    } catch (e) {
      print("Error setting up audio player: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load the audio file. Please check the URL or try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _togglePlayback() async {
    if (_audioPlayer.playerState.processingState == ProcessingState.idle) {
      try {
        await _audioPlayer.setUrl(widget.audioUrl);
      } catch (e) {
        print("Error setting up audio player: $e");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load the audio file. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    }

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                widget.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.duration,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _togglePlayback,
              child: Text(_isPlaying ? 'Pause' : 'Play'),
            ),
          ],
        ),
      ),
    );
  }
}