import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/local_service/shared_pref.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/ui/login/login_page.dart';

import 'dart:html' as html;

void main() {
  print('-----}-------------> Listen on ' + NetworkUtils.baseUrl);
  HttpOverrides.global = MyHttpOverrides();
  html.window.onBeforeUnload.listen((event) async {
    await SharedPref.clear();
  });
  runApp(const _MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Trang quản trị",
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
