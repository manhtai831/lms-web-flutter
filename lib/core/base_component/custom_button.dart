import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class CustomButton extends StatefulWidget {
  Function? onTab;
  Widget? child;
  String? title;
  double? width, height;
  Color? background;
  BorderRadius? radious;
  Alignment? alignment;

  CustomButton(
      {this.onTab,
      this.background,
      this.child,
      this.radious,
      this.title,
      this.padding,
      this.width,
      this.alignment,
      this.height});

  EdgeInsetsGeometry? padding;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.background ?? ColorResource.colorPrimary,
      child: InkWell(
        onTap: () async {
          setState(() {
            isLoading = true;
          });

          await widget.onTab?.call();
          setState(() {
            isLoading = false;
          });
        },
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.radious ?? BorderRadius.circular(8),
          ),
          height: widget.height,
          padding: widget.padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          alignment: widget.alignment ?? Alignment.centerLeft,
          child: isLoading
              ? Utils.loading(height: 22, color: ColorResource.white, width: 70)
              : widget.child ??
                  Text(
                    widget.title ?? '',
                    textAlign: TextAlign.center,
                    style:
                        AppResource.s15b.copyWith(color: ColorResource.white),
                  ),
        ),
      ),
    );
  }
}
