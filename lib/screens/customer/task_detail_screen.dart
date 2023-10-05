import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import '../../components/rating_widget.dart';
import '../../models/active_tasks_list.dart';
import '../../providers/new_home_screen_provider.dart';
import '../../utils/utils.dart';

class TaskDetailScreen extends StatefulWidget {
  final Listdata data;
  TaskDetailScreen({super.key, required this.data});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayer = AudioPlayer();
  double progress = 0.00;
  Duration? _duration = const Duration();
  Duration _position = const Duration();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (state == PlayerState.stopped || state == PlayerState.paused) {
        setState(() {
          isPlaying = false;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
        progress = _position.inMicroseconds.toDouble() /
            _duration!.inMicroseconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _playAudio(String url) async {
    try {
      // _duration = await audioPlayer.setUrl(url);

      await audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
      });
    } catch (error) {
      print(" error : $error");
    }
  }

  Future<void> _pauseAudio() async {
    await audioPlayer.pause();
    isPlaying == false;
    setState(() {});
  }

  Future<void> _stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      _position = Duration();
      isPlaying == false;
    });
  }

  Widget audioWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Utils.lightbackgroudColor,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () async {
              if (isPlaying == false) {
                await _playAudio(widget.data.docURL);
              } else {
                await _stopAudio();
              }
            },
            icon: Icon(
              isPlaying == false ? Icons.play_arrow : Icons.stop,
              size: 30,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
          width: MediaQuery.of(context).size.width * 0.3,
          child: LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: Colors.grey,
            color: Colors.white,
            value: progress,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')} / '
          '${_duration!.inMinutes}:${(_duration!.inSeconds % 60).toString().padLeft(2, '0')}',
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF5FFFF),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
        title: const Center(
          child: Text(
            "Task Details",
            style: TextStyle(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          height: height * 0.15,
          // width: width,
          decoration: const BoxDecoration(
              color: Utils.backgroudColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Utils.backgroudColor)),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(width * 0.05),
        child: SingleChildScrollView(
          // color: Utils.lightbackgroudColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Date : ",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Text(
                    widget.data.taskDateString,
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text("Task type : "),
              //     Text(widget.data.messageType.toString()),
              //   ],
              // ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Task",
              //       style: TextStyle(fontSize: 20, color: Colors.black),
              //     ),
              //   ],
              // ),
              Text(
                "Task Message",
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              widget.data.taskDetail.toString() != ""
                  ? Container(
                      width: width * 0.8,
                      color: Utils.lightbackgroudColor,
                      child: Text(
                        maxLines: 20,
                        widget.data.taskDetail.toString(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    )
                  : const SizedBox.shrink(),
              widget.data.messageType.toString().toLowerCase() == "audio"
                  ? audioWidget()
                  : const SizedBox.shrink(),
              widget.data.messageType.toString().toLowerCase() == "image"
                  ? Image.network(widget.data.docURL)
                  : const SizedBox.shrink(),
              // Container(
              //   height: height * 0.07,
              //   width: width * 0.4,
              //   margin: const EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //       color: Utils.lightbackgroudColor,
              //       border: Border.all(color: Utils.backgroudColor),
              //       borderRadius:
              //           const BorderRadius.all(Radius.circular(25))),
              //   child: const Center(child: Text("Aknowledge")),
              // )
              ElevatedButton(
                  style: const ButtonStyle(
                      side: MaterialStatePropertyAll(
                          BorderSide(color: Utils.backgroudColor))),
                  onPressed: () async {
                    final controller = Provider.of<NewHomeScreenProvider>(
                        context,
                        listen: false);
                    await controller.postTask(widget.data.taskID, context);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Acknowledge"))
            ],
          ),
        ),
      ),
    );
  }
}
