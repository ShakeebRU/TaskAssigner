import 'package:flutter/material.dart';
import 'package:taskapp/screens/auth/login_screen.dart';
import 'package:taskapp/screens/done_task_screen.dart';
import 'package:taskapp/screens/home_screen.dart';
import 'package:taskapp/screens/new_home_screen.dart';
import '../utils/preferences.dart';
import '../utils/size_config.dart';
import '../utils/utils.dart';
import 'history_screen.dart';
import 'select_messege_type_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF5FFFF),
        // backgroundColor: Utils.backgroudColor,
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          height: height * 0.15,
          // width: width,
          decoration: const BoxDecoration(
              color: Utils.backgroudColor,
              // gradient: LinearGradient(colors: [
              //   Utils.lightbackgroudColor,
              //   Utils.backgroudColor,
              //   Utils.backgroudColor
              // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SelectMessageTypes()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 219, 163, 230),
                              Utils.backgroudColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.lightbackgroudColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image(
                            //   //   height:50* SizeConfig.heightMultiplier,
                            //   width: 30 * SizeConfig.widthMultiplier,
                            //   height: 27 * SizeConfig.widthMultiplier,
                            //   image: AssetImage(Images.employ_ic),
                            // ),

                            Text(
                              'Create Task',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.create_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.teal[100],
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 219, 163, 230),
                              Utils.backgroudColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.lightbackgroudColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image(
                            //   //   height:50* SizeConfig.heightMultiplier,
                            //   width: 30 * SizeConfig.widthMultiplier,
                            //   height: 27 * SizeConfig.widthMultiplier,
                            //   image: AssetImage(Images.employ_ic),
                            // ),

                            Text(
                              'Active Tasks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.task_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoneTaskScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.teal[100],
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 219, 163, 230),
                              Utils.backgroudColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.lightbackgroudColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image(
                            //   //   height:50* SizeConfig.heightMultiplier,
                            //   width: 30 * SizeConfig.widthMultiplier,
                            //   height: 27 * SizeConfig.widthMultiplier,
                            //   image: AssetImage(Images.employ_ic),
                            // ),

                            Text(
                              'Completed Tasks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.task_outlined,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoryScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.teal[100],
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 219, 163, 230),
                              Utils.backgroudColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.lightbackgroudColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image(
                            //   //   height:50* SizeConfig.heightMultiplier,
                            //   width: 30 * SizeConfig.widthMultiplier,
                            //   height: 27 * SizeConfig.widthMultiplier,
                            //   image: AssetImage(Images.employ_ic),
                            // ),

                            Text(
                              'History',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.history,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Preferences.init()
                            .then((value) => value.deleteCridentials());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        // color: Colors.teal[100],
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 219, 163, 230),
                              Utils.backgroudColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Utils.lightbackgroudColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Image(
                            //   //   height:50* SizeConfig.heightMultiplier,
                            //   width: 30 * SizeConfig.widthMultiplier,
                            //   height: 27 * SizeConfig.widthMultiplier,
                            //   image: AssetImage(Images.employ_ic),
                            // ),

                            Text(
                              'Logout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.logout,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
