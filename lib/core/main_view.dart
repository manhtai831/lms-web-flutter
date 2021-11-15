import 'package:flutter/material.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(boxShadow: [BoxShadow(color: ColorResource.white)]),
    );
  }
}
