import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskapp/utils/preferences.dart';
import 'package:http/http.dart' as http;
import '../models/images_list_model.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';
import 'image_preview.dart';

// ignore: must_be_immutable
class ImagesWidget extends StatefulWidget {
  int taskId;
  ImagesWidget({super.key, required this.taskId});

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  List<String> images = [];
  Future<List<String>> getTaskImages() async {
    UserModel? userData;
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    final response = await http.get(
        Uri.parse(Utils.getTasksImages + "?taskid=${widget.taskId}"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ImagesListModel data = ImagesListModel.fromJson(jsonData);
      images = [];
      data.list.forEach((element) {
        images.add(element.imageURL);
      });
      // print(data.list.length);
    } else {
      print("Error : ${response.statusCode}");
      print("Error : ${response.body}");
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<String>>(
        future: getTaskImages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("No Image to Show"),
            );
          } else if (snapshot.hasData) {
            return Container(
                height: 90,
                width: width,
                // child: SingleChildScrollView(
                //     scrollDirection:
                //         Axis.horizontal,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return images.length == 0
                          ? const Center(
                              child: Text("No Image to show"),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ImagePreviewScreen(
                                    image:
                                        "${Utils.endPoint + "/" + images[index]}",
                                  );
                                }));
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    // color: Colors.amber,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${Utils.endPoint + "/" + images[index]}"))),
                              ),
                            );
                    })
                // ),
                );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
