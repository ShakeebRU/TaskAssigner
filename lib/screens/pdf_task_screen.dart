import 'dart:convert';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/new_home_screen_provider.dart';
import '../utils/utils.dart';
import 'customer_list_screen.dart';
import 'new_home_screen.dart';
import 'selection_screen.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  List<PlatformFile> _selectedFiles = [];
  List<String> convertFilesToBase64(List<PlatformFile> files) {
    List<String> base64Strings = [];

    for (var file in files) {
      List<int> bytes = io.File(file.path!).readAsBytesSync();
      String base64String = base64Encode(bytes);
      base64Strings.add(base64String);
    }

    return base64Strings;
  }

  void _pickPDFFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.files);
      });
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFiles.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Upload PDF",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedFiles.length != 0
                ? const Text('Selected PDF files:')
                : const SizedBox.shrink(),
            _selectedFiles.length != 0
                ? Column(
                    children: _selectedFiles
                        .map((file) => ListTile(
                              title: Text(file.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _removeFile(file);
                                },
                              ),
                            ))
                        .toList(),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                  onPressed: _pickPDFFiles,
                  child: const Text(
                    'Select PDF Files',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                _selectedFiles.length != 0
                    ? ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.purple)),
                        onPressed: () async {
                          final controller = Provider.of<NewHomeScreenProvider>(
                              context,
                              listen: false);
                          controller.choice = "pdf";
                          List<String> dataList =
                              convertFilesToBase64(_selectedFiles);
                          controller.pdfList = dataList;
                          dataList = [];
                          String? choice =
                              await DialogUtils.showStringListDialog(context);
                          if (choice != null) {
                            if (choice.toLowerCase() != "customers") {
                              print("NewHomeScreen");
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const NewHomeScreen();
                              }));
                            } else {
                              print("CustomerScreen");
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const CustomerListScreen();
                              }));
                            }
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
