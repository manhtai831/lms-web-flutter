import 'package:flutter/material.dart';

import '../status.dart';
import '../utils.dart';

class BaseView extends StatefulWidget {
  BaseView({this.status, this.child, Key? key}) : super(key: key);
  Status? status;
  Widget? child;

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    if (widget.status == Status.loading) {
      return Utils.loading();
    } else if (widget.status == Status.fail) {
      return Utils.error();
    } else {
      return widget.child ?? Container();
    }
  }
}
