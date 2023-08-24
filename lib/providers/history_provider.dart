import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taskapp/models/user_model.dart';

import '../models/active_tasks_list.dart';
import '../utils/preferences.dart';
import '../utils/utils.dart';

class HistoryProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool _isSearch = false;
  bool isSearch() => _isSearch;
  String searchoption = "Emploee Name";
  ActiveTasksModel? searchList = ActiveTasksModel.fromJson({"listdata": []});
  void setIsSearch(bool val) {
    _isSearch = val;
    notifyListeners();
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
        Uri.parse(Utils.getHistoryTasks + "?userid=${userData!.userID}"),
        headers: header);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      tasksList = ActiveTasksModel.fromJson(jsonData);
      seacrhList();
    } else {
      // Handle API error
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
}
