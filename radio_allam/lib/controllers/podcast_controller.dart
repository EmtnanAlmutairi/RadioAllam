import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_allam/models/radio_channel.dart';

class PodcastController extends GetxController {
  final player = AudioPlayer();

  var isPlaying = false.obs;

  // Sample radio channels
  List<RadioChannel> radioChannels = [
    RadioChannel(
      name: 'Quran Radio',
      imageUrl: 'https://play-lh.googleusercontent.com/Ro2dsngw_FPS8LYtpJ3lkmjQFb7wq8gzJZ428cPW7MRcySds39dFxLckl_THUEJkt20', // Replace with actual image URL
      streamUrl: 'https://qurango.net/radio/madina', // Replace with actual stream URL
    ),
    RadioChannel(
      name: 'Sunnah Radio',
      imageUrl: 'https://static.mytuner.mobi/media/tvos_radios/fusju6jxwccw.jpg', // Replace with actual image URL
      streamUrl: 'https://qurango.net/radio/sunna',
    ),
  ];

  // Play selected radio channel
  Future<void> playRadio(String streamUrl) async {
    try {
      await player.setUrl(streamUrl);
      player.play();
      isPlaying.value = true;
    } catch (e) {
      print("Error playing radio: $e");
    }
  }

  // Stop the radio
  void stopRadio() {
    player.stop();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
