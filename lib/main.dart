import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/home/home_page.dart';
import 'package:web_lms/ui/login/login_controller.dart';
import 'package:web_lms/ui/login/login_page.dart';

void main() {
  print('-----}-------------> Listen on ' + NetworkUtils.baseUrl);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "LMS",
      defaultTransition: Transition.cupertino,
      smartManagement: SmartManagement.keepFactory,
      showPerformanceOverlay: false,
      supportedLocales: const <Locale>[
        Locale('vi', 'VN'),
        Locale('en', 'EN'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        indicatorColor: Colors.white,
        canvasColor: Colors.white,
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: const TextSelectionThemeData(),
      ),
      home: LoginPage(),
    );
  }
}
