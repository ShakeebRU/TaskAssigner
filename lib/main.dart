import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/models/user_model.dart';
import 'package:taskapp/providers/add_task_provider.dart';
import 'package:taskapp/providers/chat_provider.dart';
import 'package:taskapp/providers/done_task_provider.dart';
import 'package:taskapp/providers/history_provider.dart';
import 'package:taskapp/providers/home_screen_provider.dart';
import 'package:taskapp/providers/login_provider.dart';
import 'package:taskapp/providers/new_home_screen_provider.dart';
import 'package:taskapp/screens/auth/login_screen.dart';
import 'package:taskapp/screens/main_screen.dart';
import 'providers/audio_controller.dart';
import 'screens/customer/home_screen.dart';
import 'utils/preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserModel? containsKey;
  void checkLogin() async {
    containsKey = await Preferences.init().then((value) => value.getAuth());
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
        // ChangeNotifierProvider<AudioController>(
        //     create: (context) => AudioController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: containsKey != null
            ? containsKey!.userType.toLowerCase() == "customer"
                ? const HomeScreenCustumer()
                : const MainScreen()
            : const LoginScreen(),
        // home: const LoginScreen(),
      ),
    );
  }
}
