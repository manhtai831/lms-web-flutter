import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/base_component/custom_button.dart';
import 'package:web_lms/core/resource/app_resource.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/core/utils.dart';

class ConfirmDialog extends StatefulWidget {
  String? message;
  Function? onConfirm;

  ConfirmDialog({Key? key, this.message, this.onConfirm}) : super(key: key);

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 220,
        width: Get.width / 3,
        decoration: const BoxDecoration(color: ColorResource.white),
        child: Scaffold(
          backgroundColor: ColorResource.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerDialog(title: 'Thông báo'),
              Utils.space(0, 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.message ?? '',
                  style: AppResource.s15r,
                ),
              ),
              Utils.space(0, 16),
              Container(
                width: double.infinity,
                height: 1,
                color: ColorResource.grey,
              ),
              Utils.space(0, 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    onTab: () => Get.back(),
                    title: 'Không',
                    background: ColorResource.grey,
                  ),
                  Utils.space(16, 0),
                  CustomButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    onTab: () {
                      Get.back();
                      widget.onConfirm?.call();
                    },
                    title: 'Có',
                    background: ColorResource.colorPrimary,
                  ),
                  Utils.space(32, 0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget headerDialog({String? title}) {
  return Container(
    height: 70,
    color: ColorResource.colorPrimary,
    child: Row(
      children: [
        Utils.space(16, 0),
        Expanded(
          child: Text(
            title ?? '',
            style: AppResource.s15b
                .copyWith(fontSize: 18, color: ColorResource.white),
          ),
        ),
        Material(
          color: ColorResource.transparent,
          child: InkWell(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.close,
                color: ColorResource.white,
              ),
            ),
          ),
        ),
        Utils.space(16, 0),
      ],
    ),
  );
}
