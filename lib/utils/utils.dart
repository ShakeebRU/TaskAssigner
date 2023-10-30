import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

class Utils {
  //auth
  static String endPoint = "http://59.103.76.148:9010";
  static String loginApi = "$endPoint/api/Login/login";
  static String getTaskTypeList = "$endPoint/api/Setup/gettasktypelist";
  static String getCustomerList = "$endPoint/api/Setup/getcustomerlist";
  static String getStaffList = "$endPoint/api/Setup/gettaskstafflist";
  static String createtask = "$endPoint/api/Task/taskmaininsert";
  static String getActiveTasks = "$endPoint/api/SingleTask/getactivetasklist";
  static String getTasksImages = "$endPoint/api/SingleTask/gettaskimageslist";
  static String getHistoryTasks = "$endPoint/api/SingleTask/getclosedtasklist";
  static String uploadAudioImage = "$endPoint/api/Task/taskinsertimageaudio";
  static String uploadSingletask = "$endPoint/api/SingleTask/taskmaininsert";
  static String uploadImagesTask = "$endPoint/api/SingleTask/taskinsertimage";
  static String cencelTask = "$endPoint/api/SingleTask/taskmaincancel";
  static String doneTask = "$endPoint/api/SingleTask/getdonetasklist";
  static String postTask = "$endPoint/api/SingleTask/taskmainpost";
  static String aknowledge = "$endPoint/api/SingleTask/taskmaindone";
  static const backgroudColor = Colors.purple;
  static const lightbackgroudColor = Color.fromARGB(255, 219, 163, 230);

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.red,
          forwardAnimationCurve: Curves.decelerate,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          message: message,
        )..show(context));
  }

  static void flushBarSuccessfulMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          backgroundColor: Colors.green,
          forwardAnimationCurve: Curves.decelerate,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          flushbarPosition: FlushbarPosition.TOP,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 3),
          message: message,
        )..show(context));
  }
}
