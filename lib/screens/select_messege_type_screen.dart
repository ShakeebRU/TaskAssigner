import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/add_task_provider.dart';
import 'package:taskapp/screens/text_screen.dart';
import 'package:taskapp/screens/text_to_speech.dart';
import 'package:taskapp/screens/voice_screen.dart';

import '../utils/utils.dart';
import 'image_pick_screen.dart';
import 'pdf_task_screen.dart';

class SelectMessageTypes extends StatefulWidget {
  const SelectMessageTypes({super.key});

  @override
  State<SelectMessageTypes> createState() => _SelectMessageTypesState();
}

class _SelectMessageTypesState extends State<SelectMessageTypes> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddTaskProvider>(context, listen: false).fetchData();
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
          "Select Message Type",
          style: TextStyle(color: Colors.white),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TextToSpeech();
                }));
              },
              child: Container(
                height: height * 0.1,
                width: width * 0.7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 219, 163, 230),
                      Utils.backgroudColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Utils.lightbackgroudColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic,
                        size: width * 0.08,
                        color: Colors.white,
                      ),
                      Text(
                        "Voice to Text",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const voiceScreen();
                }));
              },
              child: Container(
                height: height * 0.1,
                width: width * 0.7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 219, 163, 230),
                      Utils.backgroudColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Utils.lightbackgroudColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic,
                        size: width * 0.08,
                        color: Colors.white,
                      ),
                      Text(
                        "Audio",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TextScreen();
                }));
              },
              child: Container(
                height: height * 0.1,
                width: width * 0.7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 219, 163, 230),
                      Utils.backgroudColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Utils.lightbackgroudColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.text_format,
                        size: width * 0.08,
                        color: Colors.white,
                      ),
                      Text(
                        "Text",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ImagePickScreen();
                }));
              },
              child: Container(
                height: height * 0.1,
                width: width * 0.7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 219, 163, 230),
                      Utils.backgroudColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Utils.lightbackgroudColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: width * 0.08,
                        color: Colors.white,
                      ),
                      Text(
                        "Image",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PDFScreen();
                }));
              },
              child: Container(
                height: height * 0.1,
                width: width * 0.7,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 219, 163, 230),
                      Utils.backgroudColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Utils.lightbackgroudColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.document_scanner,
                        size: width * 0.08,
                        color: Colors.white,
                      ),
                      Text(
                        "PDF",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
