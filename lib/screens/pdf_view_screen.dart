import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskapp/utils/utils.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfPath;
  PDFViewerScreen({required this.pdfPath});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  Future<void> downloadAndSavePDF(String pdfUrl) async {
    try {
      // Send an HTTP GET request to download the PDF
      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        // Get the app's external storage directory (usually accessible to the user)
        Directory? externalDir = await getExternalStorageDirectory();

        if (externalDir != null) {
          // Generate a unique file name for the downloaded PDF
          String fileName =
              'downloaded_${DateTime.now().millisecondsSinceEpoch}.pdf';

          // Combine the directory path and file name to create the complete file path
          String filePath = '${externalDir.path}/$fileName';

          // Create a File object for the downloaded PDF
          File pdfFile = File(filePath);

          // Write the downloaded PDF content to the file
          await pdfFile.writeAsBytes(response.bodyBytes);
          Utils.flushBarSuccessfulMessage(
              "File Downloaded succesfully", context);

          // You now have the downloaded PDF stored in 'pdfFile'
        } else {
          Utils.flushBarErrorMessage(
              "Erro while downloading try again later", context);

          // Handle the case where the external storage directory is not available
          print('External storage directory not available.');
        }
      } else {
        Utils.flushBarErrorMessage(
            "Erro while downloading try again later", context);

        // Handle HTTP request error
        print('Error downloading PDF: ${response.statusCode}');
      }
    } catch (e) {
      Utils.flushBarErrorMessage(
          "Erro while downloading try again later", context);

      // Handle any other errors that may occur during the download
      print('Error downloading PDF: $e');
    }
  }

  Future<String?> downloadPDF(String pdfUrl) async {
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

      return tempFile.path;
    } catch (e) {
      print('Error downloading PDF: $e');
      return null;
    }
  }

  Future<void> sharePDFFile(String pdfPath) async {
    if (await File(pdfPath).exists()) {
      await Share.shareFiles([pdfPath], text: 'Sharing PDF file');
    } else {
      print('PDF file does not exist at the specified path.');
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
          title: const Text(
            "PDF File View",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await downloadAndSavePDF(widget.pdfPath);
                },
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () async {
                  String? path = await downloadPDF(widget.pdfPath);
                  await sharePDFFile(path!);
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ))
          ],
        ),
        body: FutureBuilder<String?>(
            future: downloadPDF(widget.pdfPath),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Erro while downloading try agin later"),
                );
              } else if (snapshot.hasData) {
                return PDFView(
                  filePath: snapshot.data,
                  autoSpacing: false,
                  pageFling: false,
                  pageSnap: true,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
