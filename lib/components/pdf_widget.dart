import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskapp/utils/preferences.dart';
import 'package:http/http.dart' as http;
import '../models/images_list_model.dart';
import '../models/user_model.dart';
import '../screens/pdf_view_screen.dart';
import '../utils/utils.dart';
import 'image_preview.dart';

// ignore: must_be_immutable
class PDFWidgetScreen extends StatefulWidget {
  int taskId;
  PDFWidgetScreen({super.key, required this.taskId});

  @override
  State<PDFWidgetScreen> createState() => _PDFWidgetScreenState();
}

class _PDFWidgetScreenState extends State<PDFWidgetScreen> {
  List<String> pdfs = [];

  Future<File?> downloadPDF(String pdfUrl) async {
    Dio dio = Dio();
    try {
      // Send a GET request to download the PDF
      Response response = await dio.get(pdfUrl,
          options: Options(responseType: ResponseType.bytes));

      // Get the app's temporary directory to save the downloaded PDF
      Directory tempDir = await getTemporaryDirectory();
      String tempFilePath = '${tempDir.path}/downloaded.pdf';

      // Write the downloaded PDF to the temporary file
      File tempFile = File(tempFilePath);
      await tempFile.writeAsBytes(response.data, flush: true);

      return tempFile;
    } catch (e) {
      print('Error downloading PDF: $e');
      return null;
    }
  }

  Future<List<String>> getTaskPDFs() async {
    UserModel? userData;
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    final response = await http.get(
        Uri.parse(Utils.getTasksPDFs + "?taskid=${widget.taskId}"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ImagesListModel data = ImagesListModel.fromJson(jsonData);
      pdfs = [];
      print("data : ${data.list.length}");
      for (var element in data.list) {
        pdfs.add(element.imageURL);
        print("check 1");
      }
      print("task id : ${widget.taskId}");
      print("pdf length : ${data.list.length}");
    } else {
      print("Error : ${response.statusCode}");
      print("Error : ${response.body}");
    }
    return pdfs;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<List<String>>(
        future: getTaskPDFs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: const Text("No PDFs to Show"),
            );
          } else if (snapshot.hasData) {
            return Container(
              height: 90,
              width: width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: pdfs.length,
                itemBuilder: (context, index) {
                  return pdfs.length == 0
                      ? const Center(
                          child: Text("No PDF to show"),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PDFViewerScreen(
                                pdfPath:
                                    "${Utils.endPoint + "/" + pdfs[index]}", // Replace with your PDF viewer widget
                              );
                            }));
                          },
                          child: Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/pdf.png"), // Replace with an icon for PDF files
                              ),
                            ),
                          ),
                        );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
