import 'package:flutter/material.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddATypeController extends BaseController {
  FileFolder? pFileFolder;
  List<TextEditingController> edtController = [];
  int? idClass;
  int? idGroupType;

  @override
  initialData() async {
    idClass = Get.arguments[0];
    idGroupType = Get.arguments[1];
    if (Get.arguments.length > 2) {
      pFileFolder = Get.arguments[2];
    }

    for (int i = 0; i < 7; i++) {
      edtController.add(TextEditingController());
    }
    edtController[0].text = pFileFolder?.name ?? '';
    edtController[1].text = pFileFolder?.name ?? '';
    edtController[2].text = TimeUtils.convertTimeToFormated(
        pFileFolder?.startTime ?? '',
        TimeUtils.locateDatetime2,
        TimeUtils.dateFormat);
    edtController[3].text = TimeUtils.convertTimeToFormated(
        pFileFolder?.startTime ?? '',
        TimeUtils.locateDatetime2,
        TimeUtils.timeFomart);
    edtController[4].text = TimeUtils.convertTimeToFormated(
        pFileFolder?.endTime ?? '',
        TimeUtils.locateDatetime2,
        TimeUtils.dateFormat);
    edtController[5].text = TimeUtils.convertTimeToFormated(
        pFileFolder?.endTime ?? '',
        TimeUtils.locateDatetime2,
        TimeUtils.timeFomart);
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pFileFolder != null) {
      baseResponse = await client.updateFileFolder(getJsonObjectRequest());
    } else {
      baseResponse = await client.createFileFolder(getJsonObjectRequest());
    }
    if (checkError(baseResponse)) {
      ListFileFolderController fileFolderController = Get.find();
      fileFolderController.getListFileFolder(idGroupType: idGroupType);
      fileFolderController.visibleView[3] = false;
      Get.back();
      Utils.snackBar(
          message: pFileFolder != null
              ? 'Cập nhật danh mục thành công'
              : 'Thêm danh mục thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return FileFolder(
        id: pFileFolder?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        startTime: '${edtController[2].text} ${edtController[3].text}',
        endTime: '${edtController[4].text} ${edtController[5].text}',
        idGroupType: idGroupType,
        idClass: idClass);
  }

  datePicker(int i) async {
    DateTime? date = await DateTimeUtils.showDatePickerDialog(Get.context!,
        initialDateValue: TimeUtils.convertStringToDate(
            edtController[i].text, TimeUtils.dateFormat));
    if (date != null) {
      edtController[i].text =
          TimeUtils.convertDateTimeToFormat(date, TimeUtils.dateFormat);
    }
  }

  timePicker(int i) async {
    TimeOfDay? date = await DateTimeUtils.showTimePickerDialog(Get.context!);
    if (date != null) {
      edtController[i].text =
          date.hour.toString() + ':' + date.minute.toString() + ':00';
    }
  }
}
