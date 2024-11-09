import 'package:get/get.dart';
import '../custom_audio_handler.dart';

class PodcastController extends GetxController {
  final CustomAudioHandler audioHandler = Get.find<CustomAudioHandler>();
  var isPlaying = false.obs;

  Future<void> playRadio(String streamUrl) async {
    await audioHandler.playUrl(streamUrl);
    isPlaying.value = true;
  }

  Future<void> pause() async {
    await audioHandler.pause();
    isPlaying.value = false;
  }

  Future<void> stop() async {
    await audioHandler.stop();
    isPlaying.value = false;
  }

  bool get isPlayerPlaying => audioHandler.isPlaying;
}