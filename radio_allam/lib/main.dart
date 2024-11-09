import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
import 'custom_audio_handler.dart';
import 'screens/home_screen.dart';
=======
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
>>>>>>> a65a552742d5b151454178a896ebc44ac4631b97

void main() {
  // Register CustomAudioHandler with GetX
  Get.put(CustomAudioHandler());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Podcast App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
=======
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
  bool _isLoading = false; // للتحقق من حالة التحميل
  List<String> _audioUrls = []; // لتخزين روابط الصوت
  int _currentIndex = 0; // لتتبع المقطع الحالي

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
    _fetchAudioList(); // جلب البيانات عند بدء التطبيق
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _setupAudioPlayer() async {
    try {
      if (_audioUrls.isNotEmpty) {
        await _audioPlayer
            .setUrl(_audioUrls[_currentIndex]); // شغل أول رابط من القائمة
        await _audioPlayer.play(); // تأكد من بدء التشغيل تلقائيًا
      }
    } catch (e) {
      _showErrorDialog(
          'فشل في تحميل ملف الصوت. الرجاء التحقق من الرابط أو المحاولة لاحقًا.');
    }

    // الاستماع لتغيرات حالة المشغل، وتشغيل المقطع التالي بعد الانتهاء من المقطع الحالي
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // إذا انتهى المقطع الحالي
        _playNextAudio();
      }
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  // جلب قائمة روابط الصوت من الخادم
  Future<void> _fetchAudioList() async {
    setState(() {
      _isLoading = true; // عند بدء تحميل البيانات
    });

    try {
      final response = await http
          .get(Uri.parse('https://radioallam.devadnan.net/fetch.php'));
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data.containsKey('episodes')) {
          setState(() {
            _audioUrls = List<String>.from(data['episodes']
                .map((episode) => episode['episode_url'])); // حفظ روابط الصوت
            _isLoading = false; // تم الانتهاء من التحميل
          });

          if (_audioUrls.isNotEmpty) {
            await _audioPlayer
                .setUrl(_audioUrls[_currentIndex]); // تشغيل أول مقطع صوتي
            await _audioPlayer.play();
          }
        } else {
          _showErrorDialog('المفتاح "episodes" غير موجود في البيانات.');
        }
      } else {
        throw Exception('فشل في جلب البيانات من الخادم');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('خطأ في جلب البيانات: $e');
    }
  }

  void _playNextAudio() async {
    if (_currentIndex < _audioUrls.length - 1) {
      _currentIndex++; // الانتقال إلى المقطع التالي
      await _audioPlayer
          .setUrl(_audioUrls[_currentIndex]); // تحميل الرابط الجديد
      await _audioPlayer.play(); // تشغيل المقطع الجديد
    } else {
      // إذا انتهت المقاطع، يمكن إيقاف التشغيل أو إعادة التشغيل من البداية
      setState(() {
        _currentIndex = 0; // العودة إلى أول مقطع في القائمة
      });
      await _audioPlayer.setUrl(_audioUrls[0]); // إعادة تشغيل أول مقطع
      await _audioPlayer.play();
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
                    // إضافة وظيفة الإشعارات هنا
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
>>>>>>> a65a552742d5b151454178a896ebc44ac4631b97
    );
  }
}