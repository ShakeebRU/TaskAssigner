import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/providers/add_task_provider.dart';
import 'package:taskapp/providers/chat_provider.dart';
import 'package:taskapp/providers/done_task_provider.dart';
import 'package:taskapp/providers/history_provider.dart';
import 'package:taskapp/providers/home_screen_provider.dart';
import 'package:taskapp/providers/login_provider.dart';
import 'package:taskapp/providers/new_home_screen_provider.dart';
import 'package:taskapp/screens/auth/login_screen.dart';
import 'package:taskapp/screens/main_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool containsKey = false;
  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    containsKey = prefs.getString("auth") != null ? true : false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
            create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider<AddTaskProvider>(
            create: (context) => AddTaskProvider()),
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
        ChangeNotifierProvider<NewHomeScreenProvider>(
            create: (context) => NewHomeScreenProvider()),
        ChangeNotifierProvider<HistoryProvider>(
            create: (context) => HistoryProvider()),
        ChangeNotifierProvider<DoneTaskProvider>(
            create: (context) => DoneTaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: containsKey ? const MainScreen() : const LoginScreen(),
        // home: const LoginScreen(),
      ),
    );
  }
}
