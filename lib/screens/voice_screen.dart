import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../providers/new_home_screen_provider.dart';
import '../utils/utils.dart';
import 'new_home_screen.dart';

class voiceScreen extends StatefulWidget {
  const voiceScreen({super.key});

  @override
  State<voiceScreen> createState() => _voiceScreenState();
}

class _voiceScreenState extends State<voiceScreen> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  TextEditingController _textEditingController = TextEditingController();
  bool readySend = false;
  final FlutterSoundPlayer _audioPlayer1 = FlutterSoundPlayer();
  bool _isRecording = false;
  String _recognizedText = '';
  bool _isPlaying = false;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _initRecorder();
    _initSpeech();
    // _setupAudioPlayerListener();
  }

  // void _setupAudioPlayerListener() {
  //   if (_audioPlayer1.isStopped) {
  //     print("Stopppppppped");
  //   }
  // }

  Future<void> _initRecorder() async {
    await _audioRecorder.openRecorder();
    await _startRecording();
  }

  Future<void> _startRecording() async {
    await _audioRecorder.openRecorder();
    if (await Permission.microphone.request().isGranted) {
      await _audioRecorder.startRecorder(
        toFile: 'temp_audio.mp4',
        codec: Codec.aacMP4,
      );
      setState(() {
        _isRecording = true;
      });
    }
  }

  String recordedFilePath = "";
  Duration? duration;
  Future<void> _stopRecording() async {
    recordedFilePath = await _audioRecorder.stopRecorder() ?? "";

    await _playRecording();
    _isLoading = true;
    // Future.delayed(duration!);
    // await _playRecording();
    setState(() {
      _isRecording = false;
    });
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(
      pauseFor: const Duration(seconds: 40),
      // listenFor: Duration(seconds: 10),
      listenMode: stt.ListenMode.confirmation,
      onResult: _onSpeechResult,
      localeId: 'en_US', // Replace 'en_US' with the language code you want
    );
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      String _lastWords = result.recognizedWords;
      _recognizedText = _lastWords;
      _textEditingController.text = _recognizedText;
      print("speech result");
    });
  }

  Future<void> _playRecording() async {
    if (_isPlaying) {
      await _audioPlayer1.stopPlayer();
      await _stopListening();
      _isLoading = false;
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _startListening();
      await _audioPlayer1.openPlayer();
      duration = await _audioPlayer1.startPlayer(
          fromURI: 'temp_audio.mp4',
          codec: Codec.aacMP4,
          whenFinished: () async {
            await _stopListening();
            String s = await convertAudio();
            final controller1 =
                Provider.of<NewHomeScreenProvider>(context, listen: false);
            controller1.str = s;
            controller1.messegeText = _textEditingController.text;
            controller1.messegeController.text = _textEditingController.text;
            // if (controller1.messegeText != "") {
            // await controller1.uplaodAudioImage(context);
            // _textEditingController.clear();
            await Future.delayed(Duration(seconds: 5));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const NewHomeScreen();
            }));
            // } else {
            //   Utils.flushBarErrorMessage("Record message again", context);
            // }
          });
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<String> convertAudio() async {
    String str = "";
    String filePath = '${recordedFilePath}';
    if (filePath != "") {
      List<int> audioBytes = File(filePath).readAsBytesSync();
      return base64Encode(audioBytes);
    }
    return "";
    // try {
    // File audioFile = File('temp_audio.mp4');
    // Uint8List audioData = await audioFile.readAsBytes();
    // str = base64.encode(audioData);
    // } catch (error) {
    //   print(error);
    // }
    // return str;
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5FFFF),
          // backgroundColor: Utils.backgroudColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            "Upload Voice",
            style: TextStyle(color: Colors.white),
          ),
          flexibleSpace: Container(
            // height: height * 0.1,
            // width: width,
            decoration: const BoxDecoration(
                color: Utils.backgroudColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
        ),
        body: Consumer<NewHomeScreenProvider>(
          builder: (context, controller, child) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.4,
                      padding: const EdgeInsets.only(left: 5),
                      decoration: ShapeDecoration(
                        color: const Color.fromARGB(255, 227, 213, 230),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50,
                              color: Color.fromARGB(255, 227, 213, 230)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: _textEditingController,
                        onChanged: (value) {
                          controller.messegeController.text =
                              _textEditingController.text;
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            hintText: 'Your message', border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.15,
                    ),
                    RippleAnimation(
                      size: Size(width * 0.17, width * 0.17),
                      repeat: true,
                      color: Utils.backgroudColor,
                      minRadius: _isRecording ? 90 : 0,
                      ripplesCount: 6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (_textEditingController.text == "") {
                              if (_isRecording) {
                                await _stopRecording();
                              } else {
                                await _startRecording();
                              }
                            } else {
                              String s = await convertAudio();
                              controller.str = s;
                              controller.messegeText =
                                  _textEditingController.text;
                              if (controller.messegeText != "") {
                                // await controller.uplaodAudioImage(context);
                                // _textEditingController.clear();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const NewHomeScreen();
                                }));
                              } else {
                                Utils.flushBarErrorMessage(
                                    "Record message again", context);
                              }
                            }
                          },
                          tooltip: 'Listen',
                          child: Icon(_textEditingController.text == ""
                              ? _isRecording
                                  ? Icons.mic
                                  : Icons.mic_off
                              : Icons.send),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
