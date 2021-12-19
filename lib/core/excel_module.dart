import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:web_lms/core/export_all.dart';

class ExcelModule {
  static Excel createExcel() {
    return Excel.createExcel();
  }

  static void insertRow(
      {Excel? excel, String? sheetName, List? listData, int? index}) {
    excel?.insertRowIterables(
        sheetName ?? 'sheet 1', listData ?? [], index ?? -1);
  }

  static void saveFile({Excel? excel}) async {
    // Save the Changes in file

    List<int>? endValue = excel?.encode();

    // File(appDocDir ?? '')
    //   ..createSync(recursive: true)
    //   ..writeAsBytesSync(endValue ?? []);
    Utils.snackBar(message: 'Tính năng đang được hoàn thiện');
  }
}
