import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/core/resource/color_resource.dart';
import 'package:web_lms/model/base_item.dart';
import 'package:web_lms/ui/semester/list_semester_page.dart';

class Utils {
  static SizedBox space(double width, double height) {
    return SizedBox(width: width, height: height);
  }

  static Container line({double? width, double? height}) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 1,
      color: ColorResource.grey.withOpacity(0.3),
    );
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

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.snackBar(message: 'Can not open file');
      throw 'Could not launch $url';
    }
  }

  static Widget empty() {
    return const Center(
      child: Text('Không có dữ liệu'),
    );
  }

  static List<TableRow> emptyTable() {
    return <TableRow>[
      TableRow(
        children: [
          tableCell(text: 'Không có dữ liệu'),
        ],
      ),
    ];
  }

  static Widget loading({double? height, Color? color}) {
    return SizedBox(
      height: height ?? Get.height / 2,
      width: height,
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? ColorResource.colorPrimary,
        ),
      ),
    );
  }

  static Widget error() {
    return const Center(
      child: Text('Đã có lỗi xảy ra'),
    );
  }

  static List<BaseItem> typeRepository() {
    return [
      BaseItem(id: 0, title: 'Tài liệu'),
      BaseItem(id: 1, title: 'Khác'),
    ];
  }

  static String? validate({String? s}) {
    if (s != null) {
      if (s.trim().isEmpty) {
        return 'Không được để trống';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static bool checkValidate({List<String?>? l}) {
    int count = 0;
    if (l != null) {
      l.forEach((element) {
        if (element != null) {
          count++;
        }
      });
    }
    if (count == 0) {
      return true;
    }
    return false;
  }
}
