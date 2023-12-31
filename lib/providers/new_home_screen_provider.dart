import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskapp/screens/main_screen.dart';
import '../models/result_model.dart';
import '../models/staff_controller_model.dart';
import '../models/staff_list_model.dart';
import '../models/user_model.dart';
import '../utils/preferences.dart';
import '../utils/utils.dart';

class NewHomeScreenProvider with ChangeNotifier {
  UserModel? userData;
  TextEditingController messegeController = TextEditingController();
  late StaffListModel staffList;
  List<String> selectedStaffList = [];
  List<StaffControllerModel> staffController = [];
  Future<StaffListModel> getStaff() async {
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    final response1 =
        await http.get(Uri.parse(Utils.getStaffList), headers: header);
    if (response1.statusCode == 200) {
      final jsonData = json.decode(response1.body);
      staffList = StaffListModel.fromJson(jsonData);
    } else {
      // Handle API error
      print("Error : ${response1.statusCode}");
      staffList = StaffListModel.fromJson({"listdata": []});
    }
    return staffList;
  }

  List<XFile>? pickedImage;
  Future<void> pickImage() async {
    final PermissionStatus status = await Permission.camera.request();
    // final PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedImage1 = await picker.pickMultiImage();
      pickedImage = pickedImage1;
      notifyListeners();
    } else if (status.isDenied) {
      // Handle denied permission
      print('Permission denied');
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission
      print('Permission permanently denied');
    }
  }

  String choice = "";
  List<String> pdfList = [];
  String str = "";
  int? selectedCustumerId;
  String messegeText = "";
  Future<String> imageToBase64(XFile imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future uplaodAudioImage(BuildContext context) async {
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    if (pickedImage != null) {
      // str = await imageToBase64(pickedImage!);
    }
    Map<String, dynamic> data = {
      "userID": userData!.userID,
      "detailCode": selectedCustumerId,
      "taskDetail": messegeController.text,
      "stafflist": staffController.length == 0 ? null : staffController,
      "messageType": choice == "pdf"
          ? "pdf"
          : pickedImage != null
              ? "Image"
              : str != ""
                  ? "Audio"
                  : "Text",
      "imageAudio": {
        "computerNo": 0,
        "imageBase64": str,
        "audioTranslate": "",
        "type": choice == "pdf"
            ? "pdf"
            : pickedImage != null
                ? "Image"
                : str != ""
                    ? "Audio"
                    : "Text"
      }
    };
    print("data : ${jsonEncode(data)}");
    Map<String, String> header = {
      'Authorization': 'Bearer ${userData!.token}',
      'Content-Type': 'application/json'
    };
    // print(data);
    Response response = await post(Uri.parse(Utils.uploadSingletask),
        headers: header, body: jsonEncode(data));
    if (response.statusCode == 200) {
      // print("response : ${response.body}");
      final jsonData = json.decode(response.body);
      ResultModel result1 = ResultModel.fromJson(jsonData);
      if (result1.status) {
        // Utils.flushBarSuccessfulMessage("Uploaded Successfully", context);
        if (pickedImage != null) {
          for (int i = 0; i < pickedImage!.length; i++) {
            String image = await imageToBase64(pickedImage![i]);
            Map<String, dynamic> data1 = {
              "computerNo": int.parse(result1.returnId),
              "imageBase64": "$image",
              "audioTranslate": "string",
              "type": "string",
              "subID": i,
              "imageURL": "string"
            };

            print("data : ${jsonEncode(data1)}");
            Map<String, String> header1 = {
              'Authorization': 'Bearer ${userData!.token}',
              'Content-Type': 'application/json'
            };
            // print(data);
            Response response1 = await post(Uri.parse(Utils.uploadImagesTask),
                headers: header1, body: jsonEncode(data1));
            print(response1.body);
          }
        }
        if (choice == "pdf") {
          print("________Welcome__________");
          for (int i = 0; i < pdfList.length; i++) {
            Map<String, dynamic> data1 = {
              "computerNo": int.parse(result1.returnId),
              "imageBase64": "${pdfList[i]}",
              "audioTranslate": "string",
              "type": "string",
              "subID": i,
              "imageURL": "string"
            };

            print("data : ${jsonEncode(data1)}");
            Map<String, String> header1 = {
              'Authorization': 'Bearer ${userData!.token}',
              'Content-Type': 'application/json'
            };
            // print(data);
            Response response1 = await post(Uri.parse(Utils.uploadPDFTask),
                headers: header1, body: jsonEncode(data1));
            print(response1.body);
          }
        }
        choice = "";
        pdfList = [];
        messegeController.clear();
        pickedImage = null;
        str = "";
        staffController = [];
        selectedStaffList = [];
        print(result1.returnId);

        await submitAlertCustom(context);
        // Future.delayed(const Duration(seconds: 2));
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        await errorCustom(response.body, context);
      }
      // print(jsonData);
    } else {
      // Handle API error
      await errorCustom(response.body, context);
      print("Error : ${response.statusCode}");
    }
  }

  Future<void> submitAlertCustom(BuildContext context) async {
    Dialog doneDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200.0,
              width: 200.0,
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Lottie.asset("assets/done.json")),
            ),
            const Padding(padding: EdgeInsets.only(top: 5.0)),
            TextButton(
                onPressed: () {
                  //  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                },
                child: const Text(
                  'close!',
                  style: TextStyle(color: Colors.green, fontSize: 16.0),
                ))
          ],
        ),
      ),
    );
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => doneDialog);
  }

  Future<void> errorCustom(String msg, BuildContext context) async {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Lottie.network(
                      "https://assets10.lottiefiles.com/packages/lf20_O6BZqckTma.json")),
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            Text("Reason: $msg"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => const Home()));
                },
                child: Text(
                  'Close!',
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ))
          ],
        ),
      ),
    );
    await showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  Future<bool> postTask(int taskId, BuildContext context) async {
    UserModel? userData;
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    // print(userData!.userID);
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    // print("${userData!.userID}");
    final response = await http.post(
        Uri.parse(
            "${Utils.aknowledge}?taskid=$taskId&remarks=empty&ratingpoints=0"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      // Utils.flushBarSuccessfulMessage("updated Task Successfully", context);
      // Future.delayed(Duration(seconds: 1));
      await submitAlertCustom(context);
      if (Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }
    } else {
      // ignore: unnecessary_string_interpolations
      await errorCustom(response.body, context);
      print("Error : ${response.statusCode}");
      print("Error : ${response.body}");
    }
    return true;
  }
}
