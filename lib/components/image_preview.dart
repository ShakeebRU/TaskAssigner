import 'package:flutter/material.dart';
import 'package:googleapis/admob/v1.dart';

class ImagePreviewScreen extends StatefulWidget {
  String image;
  ImagePreviewScreen({super.key, required this.image});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
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
