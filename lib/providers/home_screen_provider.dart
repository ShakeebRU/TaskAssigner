// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:taskapp/models/user_model.dart';

import '../models/active_tasks_list.dart';
import '../utils/preferences.dart';
import '../utils/utils.dart';

class HomeScreenProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  bool _isSearch = false;
  bool isSearch() => _isSearch;
  String searchoption = "Emploee Name";
  ActiveTasksModel? searchList = ActiveTasksModel.fromJson({"listdata": []});
  void setIsSearch(bool val) {
    _isSearch = val;
    notifyListeners();
  }

  disposeControllers() {
    searchController.dispose();
    remarksController.dispose();
  }

  ActiveTasksModel? tasksList;
  void seacrhList() {
    if (searchController.text == "") {
      searchList = tasksList;
    } else {
      if (searchoption == "Emploee Name") {
        final list = tasksList!.listdata
            .where((element) => element.employeeName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
        searchList!.listdata = list;
      } else {
        final list = tasksList!.listdata
            .where((element) => element.taskDetail
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
        searchList!.listdata = list;
      }
    }
    notifyListeners();
  }

  Future<bool> getTasks() async {
    UserModel? userData;
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    // print(userData!.userID);
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    // print("${userData!.userID}");
    final response = await http.get(
        Uri.parse(Utils.getActiveTasks +
            "?userid=${userData!.userID}&usertype=${userData!.userType}"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      tasksList = ActiveTasksModel.fromJson(jsonData);
      seacrhList();
    } else {
      // Handle API error
      // Utils.flushBarErrorMessage("check internet connection and try again ",context);
      print("Error : ${response.statusCode}");
      print("Error : ${response.body}");
    }
    return true;
  }

  void showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Search by:'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Emploee Name');
              },
              child: Text(
                'Emploee Name',
                style: TextStyle(
                    color: searchoption == "Emploee Name"
                        ? Utils.backgroudColor
                        : Colors.black),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Task Description');
              },
              child: Text(
                'Task Description',
                style: TextStyle(
                    color: searchoption == "Task Description"
                        ? Utils.backgroudColor
                        : Colors.black),
              ),
            ),
          ],
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {
        searchoption = selectedOption;
        print('Selected option: $selectedOption');
      }
    });
  }

  Future<bool> cencelTask(
      int taskId, String remarks, BuildContext context) async {
    UserModel? userData;
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    // print(userData!.userID);
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    // print("${userData!.userID}");
    final response = await http.post(
        Uri.parse("${Utils.cencelTask}?taskid=$taskId&remarks=$remarks"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // await Future.delayed(const Duration(seconds: 1));
      await submitAlertCustom(context);
      if (Navigator.of(context).canPop()) {
        Navigator.pop(context);
      }
    } else {
      errorCustom(response.body, context);
      print("Error : ${response.statusCode}");
      print("Error : ${response.body}");
    }
    return true;
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
                  child: Lottie.network(
                      "https://lottie.host/205f9a22-3e08-4884-8fb1-31b3ea473735/CHLMhdKkEo.json")),
            ),
            Padding(padding: EdgeInsets.only(top: 5.0)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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

  void errorCustom(String msg, BuildContext context) {
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
                },
                child: Text(
                  'Close!',
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                ))
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}
