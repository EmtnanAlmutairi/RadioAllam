import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class CustomAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  CustomAudioHandler() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        playing: _player.playing,
        processingState: AudioProcessingState.values[_player.processingState.index],
      ));
    });
  }

  Future<void> playUrl(String url) async {
    try {
      await _player.setUrl(url);
      _player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  bool get isPlaying => _player.playing;

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    final url = params['url'] as String;
    await playUrl(url);
  }

  @override
  Future<void> onStop() async {
    await stop();
  }
}