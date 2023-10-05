import 'package:audioplayers/audioplayers.dart';
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
import 'customer_list_screen.dart';
import 'new_home_screen.dart';
import 'selection_screen.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  TextEditingController _textEditingController = TextEditingController();
  bool readySend = false;
  final FlutterSoundPlayer _audioPlayer1 = FlutterSoundPlayer();
  bool _isRecording = false;
  String _recognizedText = '';
  bool _isPlaying = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(
      pauseFor: const Duration(seconds: 400),
      listenFor: const Duration(seconds: 400),
      listenMode: stt.ListenMode.confirmation,
      localeId: 'en_US', // Replace 'en_US' with the language code you want
      onResult: _onSpeechResult,
    );
    isLoading = true;
    setState(() {});
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    isLoading = false;
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
          builder: (context, controller, child) => ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                        minLines: null,
                        maxLines: null,
                        readOnly: false,
                        expands: true,
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
                    Center(
                      child: RippleAnimation(
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
                                if (isLoading) {
                                  await _stopListening();
                                } else {
                                  await _startListening();
                                }
                              } else {
                                controller.messegeText =
                                    _textEditingController.text;
                                controller.messegeController.text =
                                    _textEditingController.text;
                                if (controller.messegeText != "") {
                                  // await controller.uplaodAudioImage(context);
                                  // _textEditingController.clear();
                                  String? choice =
                                      await DialogUtils.showStringListDialog(
                                          context);
                                  if (choice != null) {
                                    if (choice.toLowerCase() != "customers") {
                                      print("NewHomeScreen");
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const NewHomeScreen();
                                      }));
                                    } else {
                                      print("CustomerScreen");
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return const CustomerListScreen();
                                      }));
                                    }
                                  }
                                } else {
                                  Utils.flushBarErrorMessage(
                                      "Record message again", context);
                                }
                              }
                            },
                            tooltip: 'Listen',
                            child: Icon(_textEditingController.text == ""
                                ? isLoading
                                    ? Icons.abc
                                    : Icons.mic_off
                                : Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
