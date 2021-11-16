import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/ui/home/home_controller.dart';
import 'package:web_lms/ui/home/home_page.dart';
import 'package:web_lms/ui/login/login_controller.dart';
import 'package:web_lms/ui/login/login_page.dart';

void main() {
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        // fontFamily: "SFUIDisplay",
      ),
      home: LoginPage(),
    );
  }
}
