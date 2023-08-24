import 'package:flutter/material.dart';
import 'package:taskapp/screens/auth/login_screen.dart';
import 'package:taskapp/utils/preferences.dart';

import '../utils/utils.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          // backgroundColor: Utils.backgroudColor,
          // leading: IconButton(
          //     onPressed: () {
          //       // Navigator.of(context).pop();
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back_ios_new,
          //       color: Colors.white,
          //     )),
          title: const Text(
            "Settings",
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
        body: Column(
          children: [
            ListTile(
              onTap: () async {
                await Preferences.init()
                    .then((value) => value.deleteCridentials());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
            )
          ],
        ));
  }
}
