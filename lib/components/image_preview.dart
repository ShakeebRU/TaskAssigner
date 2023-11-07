import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:googleapis/admob/v1.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskapp/utils/utils.dart';

class ImagePreviewScreen extends StatefulWidget {
  String image;
  ImagePreviewScreen({super.key, required this.image});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  Future<void> downloadAndSaveImage() async {
    final url =
        widget.image; // Replace with the image URL you want to download.
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File(
          '${appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await file.writeAsBytes(bytes);

      // Save the image to the gallery.
      final result = await ImageGallerySaver.saveFile(file.path);

      if (result != null && result['isSuccess']) {
        print('Image downloaded and saved to the gallery.');
        Utils.flushBarSuccessfulMessage("Image Downloaded", context);
      } else {
        print('Failed to save the image to the gallery.');
        Utils.flushBarSuccessfulMessage("Try Again Later", context);
      }
    } else {
      print('Failed to download the image.');
      Utils.flushBarSuccessfulMessage("Try Again Later", context);
    }
  }

  Future<void> downloadAndShareImage() async {
    final url = widget.image; // Replace with the image URL you want to share.
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File('${appDocDir.path}/downloaded_image.jpg');
      await file.writeAsBytes(bytes);

      // Use the share package to share the downloaded image.
      Share.shareFiles([file.path], text: 'Check out this image:');
    } else {
      print('Failed to download the image.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await downloadAndSaveImage();
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                await downloadAndShareImage();
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          widget.image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
