// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioController with ChangeNotifier {
//   bool _isRecordPlaying = false,
//       isRecording = false,
//       isSending = false,
//       isUploading = false;
//   DateTime start = DateTime.now();
//   DateTime end = DateTime.now();
//   String _total = "";
//   String get total => _total;
//   var completedPercentage = 0.0;
//   var currentDuration = 0;
//   var totalDuration = 0;

//   bool get isRecordPlaying => _isRecordPlaying;
//   bool get isRecordingValue => isRecording;
//   AudioPlayerService? _audioPlayerService = AudioPlayerAdapter();
//   void onInit() {
//     _audioPlayerService!.getAudioPlayer.onDurationChanged.listen((duration) {
//       totalDuration = duration.inMicroseconds;
//     });

//     _audioPlayerService!.getAudioPlayer.onPositionChanged.listen((duration) {
//       currentDuration = duration.inMicroseconds;
//       completedPercentage =
//           currentDuration.toDouble() / totalDuration.toDouble();
//     });

//     _audioPlayerService!.getAudioPlayer.onPlayerComplete.listen((event) async {
//       await _audioPlayerService!.getAudioPlayer.seek(Duration.zero);
//       _isRecordPlaying = false;
//     });

//     // notifyListeners();
//   }

//   void onClose() {
//     _audioPlayerService!.dispose();
//   }

//   Future<void> changeProg() async {
//     if (isRecordPlaying) {
//       _audioPlayerService!.getAudioPlayer.onDurationChanged.listen((duration) {
//         totalDuration = duration.inMicroseconds;
//       });

//       _audioPlayerService!.getAudioPlayer.onPositionChanged.listen((duration) {
//         currentDuration = duration.inMicroseconds;
//         completedPercentage =
//             currentDuration.toDouble() / totalDuration.toDouble();
//       });
//     }

//     notifyListeners();
//   }

//   void onPressedPlayButton(var content) async {
//     if (isRecordPlaying) {
//       await _pauseRecord();
//     } else {
//       _isRecordPlaying = true;
//       await _audioPlayerService!.play(content);
//     }

//     notifyListeners();
//   }

//   calcDuration() {
//     var a = end.difference(start).inSeconds;
//     format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
//     _total = format(Duration(seconds: a));
//     notifyListeners();
//   }

//   Future<void> _pauseRecord() async {
//     _isRecordPlaying = false;
//     await _audioPlayerService!.pause();

//     notifyListeners();
//   }
// }

// abstract class AudioPlayerService {
//   void dispose();
//   Future<void> play(String url);
//   Future<void> resume();
//   Future<void> pause();
//   Future<void> release();

//   AudioPlayer get getAudioPlayer;
// }

// class AudioPlayerAdapter implements AudioPlayerService {
//   late AudioPlayer _audioPlayer;

//   @override
//   AudioPlayer get getAudioPlayer => _audioPlayer;

//   AudioPlayerAdapter() {
//     _audioPlayer = AudioPlayer();
//   }

//   @override
//   void dispose() async {
//     await _audioPlayer.dispose();
//   }

//   @override
//   Future<void> pause() async {
//     await _audioPlayer.pause();
//   }

//   @override
//   Future<void> play(String url) async {
//     await _audioPlayer.play(UrlSource(url));
//   }

//   @override
//   Future<void> release() async {
//     await _audioPlayer.release();
//   }

//   @override
//   Future<void> resume() async {
//     await _audioPlayer.resume();
//   }
// }

// class AudioDuration {
//   static double calculate(Duration soundDuration) {
//     if (soundDuration.inSeconds > 60) {
//       return 70;
//     } else if (soundDuration.inSeconds > 50) {
//       return 65;
//     } else if (soundDuration.inSeconds > 40) {
//       return 60;
//     } else if (soundDuration.inSeconds > 30) {
//       return 55;
//     } else if (soundDuration.inSeconds > 20) {
//       return 50;
//     } else if (soundDuration.inSeconds > 10) {
//       return 45;
//     } else {
//       return 40;
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioController extends ChangeNotifier {
//   AudioPlayer audioPlayer = AudioPlayer();

//   bool _isPlaying = false;
//   bool get isPlaying => _isPlaying;

//   double _progress = 0.0;
//   double get progress => _progress;

//   Duration? _duration = Duration();
//   Duration get duration => _duration!;

//   AudioController() {
//     // Initialize the audio player
//     audioPlayer.onPlayerStateChanged.listen((PlayerState state) async {
//       if (state == PlayerState.playing) {
//         print("isplaying start");
//         _isPlaying = true;
//         _duration = await audioPlayer.getDuration();
//         notifyListeners();
//       } else if (state == PlayerState.stopped) {
//         _isPlaying = false;
//         _progress = 0.0;
//         notifyListeners();
//       }
//     });

//     audioPlayer.onPositionChanged.listen((Duration position) {
//       _progress = position.inMilliseconds.toDouble() /
//           _duration!.inMilliseconds.toDouble();
//       notifyListeners();
//     });
//   }

//   Future<void> playAudio(String url) async {
//     await audioPlayer.play(
//       UrlSource(url),
//     );
//     print("click play");
//   }

//   Future<void> pauseAudio() async {
//     await audioPlayer.pause();
//   }

//   Future<void> stopAudio() async {
//     await audioPlayer.stop();
//   }
// }
