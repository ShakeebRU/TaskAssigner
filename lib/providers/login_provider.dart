import 'package:flutter/material.dart';
import 'package:taskapp/models/user_model.dart';
import '../Utils/utils.dart';
import '../https/http_requests.dart';
import '../screens/bottom_navigation.dart';
import '../screens/main_screen.dart';
import '../utils/preferences.dart';

class LoginProvider with ChangeNotifier {
  Future<void> checkLogin(
      String email, String password, BuildContext context) async {
    dynamic body = {'username': email, 'password': password};
    // body = jsonEncode(body);
    dynamic response =
        await NetworkAPIService.getPostApiResponseData(Utils.loginApi, body);
    if (response.containsKey("status") && response['status']) {
      UserModel userData = UserModel.fromJson(response);
      // print(userData);
      // final controller =
      //     Provider.of<HomeScreenProvider>(context, listen: false);
      // controller.data = UserModel.fromJson(jsn);
      Preferences.init().then((value) => value.saveCridentials(userData));
      Utils.flushBarSuccessfulMessage("Login Successfuly", context);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MainScreen();
      }));
    } else {
      // if (response.containKey("message")) {
      Utils.flushBarErrorMessage(response["message"], context);
    }
  }
}
