import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class Utils {
  static SizedBox space(double width, double height) {
    return SizedBox(width: width, height: height);
  }

  static snackBar({String? message, String? title}) {
    return Get.snackbar(
      title ?? 'Thông báo', // title
      message ?? '', // message
      icon: const Icon(
        Icons.notifications,
        color: ColorResource.white,
      ),
      maxWidth: Get.width / 2,
      shouldIconPulse: true,
      barBlur: 20,
      margin: const EdgeInsets.only(top: 16),

      backgroundColor: ColorResource.black.withOpacity(0.2),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
  }

  static String concatUrl(String url) {
    print('AAAAAAAAAAA ' + NetworkUtils.baseUrl + url);
    return NetworkUtils.baseUrl + url;
  }
}
