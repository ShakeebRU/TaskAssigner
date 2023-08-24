import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/new_home_screen_provider.dart';
import '../utils/utils.dart';
import 'new_home_screen.dart';

class ImagePickScreen extends StatefulWidget {
  const ImagePickScreen({super.key});

  @override
  State<ImagePickScreen> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePickScreen> {
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
            "Upload Image",
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
          builder: (context, controller, child) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (controller.pickedImage != null)
                  Image.file(
                    File(controller.pickedImage!.path),
                    width: width * 0.9,
                    height: height * 0.6,
                    fit: BoxFit.cover,
                  )
                else
                  const Text('No image selected.'),
                const SizedBox(height: 20),
                controller.pickedImage != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // await controller.pickImage();
                              controller.pickedImage = null;
                              setState(() {});
                            },
                            child: const Row(
                              children: [Text('Cencel'), Icon(Icons.delete)],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // await controller.pickImage();
                              // await controller.uplaodAudioImage(context);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const NewHomeScreen();
                              }));
                            },
                            child: const Row(
                              children: [Text('Submit'), Icon(Icons.check)],
                            ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          await controller.pickImage();
                        },
                        child: const Text('Pick Image'),
                      ),
              ],
            ),
          ),
        ));
  }
}
