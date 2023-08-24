import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

import '../providers/add_task_provider.dart';
import '../utils/utils.dart';

class SpeechRecognitionScreen extends StatefulWidget {
  @override
  _SpeechRecognitionScreenState createState() =>
      _SpeechRecognitionScreenState();
}

class _SpeechRecognitionScreenState extends State<SpeechRecognitionScreen> {
  FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  stt.SpeechToText _speechToText = stt.SpeechToText();
  TextEditingController _textEditingController = TextEditingController();
  bool readySend = false;
  final FlutterSoundPlayer _audioPlayer1 = FlutterSoundPlayer();
  bool _isRecording = false;
  String _recognizedText = '';
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _initRecorder();
    _initSpeech();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder.openRecorder();
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
    // Future.delayed(duration!);
    // await _playRecording();
    setState(() {
      _isRecording = false;
    });
  }

  void _initSpeech() async {
    await _speechToText.initialize();
    await _startRecording();
    setState(() {});
  }

  Future<void> _startListening() async {
    await _speechToText.listen(
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
    });
  }

  Future<void> _playRecording() async {
    if (_isPlaying) {
      await _audioPlayer1.stopPlayer();
      await _stopListening();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _startListening();
      await _audioPlayer1.openPlayer();
      duration = await _audioPlayer1.startPlayer(
        fromURI: 'temp_audio.mp4',
        codec: Codec.aacMP4,
      );
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
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
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
            "Chat",
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
        body: Consumer<AddTaskProvider>(
          builder: (context, controller, child) => Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  // child: Text(
                  //   _lastWords,
                  //   style: const TextStyle(fontSize: 20.0),
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height * 0.065,
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
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: _textEditingController,
                          readOnly: true,
                          decoration: const InputDecoration(
                              hintText: 'Type your message',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
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
                            // print("dATAENCODED  : $s");
                            controller.str = s;
                            controller.messegeText =
                                _textEditingController.text;
                            if (controller.messegeText != "") {
                              // await controller.uplaodAudioImage(context);
                              // _textEditingController.clear();
                            } else {
                              Utils.flushBarErrorMessage(
                                  "record messege again", context);
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
                  ],
                ),
              )
            ],
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       _isRecording
          //           ? ElevatedButton(
          //               onPressed: _stopRecording,
          //               child: Text('Stop Recording'),
          //             )
          //           : ElevatedButton(
          //               onPressed: _startRecording,
          //               child: Text('Start Recording and Recognizing'),
          //             ),
          //       SizedBox(height: 20),
          //       Text('Recognized Text: $_recognizedText'),
          //       // SizedBox(height: 20),
          //       // ElevatedButton(
          //       //   onPressed: ,
          //       //   child: Text(_isPlaying ? 'Stop Playback' : 'Play Recording'),
          //       // ),
          //     ],
          //   ),
          // ),
        ));
  }
}
