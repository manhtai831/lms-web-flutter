import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class CustomButton extends StatefulWidget {
  Function? onTab;
  Widget? child;
  String? title;
  double? width, height;
  Color? background;
  BorderRadius? radious;

  CustomButton(
      {this.onTab,
      this.background,
      this.child,
      this.radious,
      this.title,
      this.padding,
      this.width,
      this.height});

  EdgeInsetsGeometry? padding;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.background ?? ColorResource.colorPrimary,
      child: InkWell(
        onTap: () => widget.onTab?.call(),
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.radious ?? BorderRadius.circular(8),
          ),
          height: widget.height,
          padding: widget.padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          alignment: Alignment.centerLeft,
          child: widget.child ??
              Text(
                widget.title ?? '',
                textAlign: TextAlign.center,
                style: AppResource.s15b.copyWith(color: ColorResource.white),
              ),
        ),
      ),
    );
  }
}
