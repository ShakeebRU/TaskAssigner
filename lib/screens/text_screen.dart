import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/new_home_screen_provider.dart';
import '../utils/utils.dart';
import 'customer_list_screen.dart';
import 'new_home_screen.dart';
import 'selection_screen.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
            "Upload Text",
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
        body: ListView(
          shrinkWrap: true,
          children: [
            Consumer<NewHomeScreenProvider>(
              builder: (context, controller, child) => Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
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
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            controller: _textEditingController,
                            onChanged: (value) {
                              controller.messegeController.text =
                                  _textEditingController.text;
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                                hintText: 'Type your message',
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.15,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: FloatingActionButton(
                              onPressed: () async {
                                controller.messegeText =
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
                                      "Enter Some Text", context);
                                }
                              },
                              tooltip: 'Listen',
                              child: const Icon(Icons.send),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
