import 'package:flutter/material.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(boxShadow: [BoxShadow(color: ColorResource.white)]),
    );
  }
}
