import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/date_time/date_time_utils.dart';
import 'package:web_lms/core/date_time/time_utils.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/network/network_utils.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/ui/list_file_folder/list_file_folder_controller.dart';

class AddATypeController extends BaseController {
  FileFolder? pFileFolder;
  List<TextEditingController> edtController = [];
  int? idClass;
  int? idSubject;
  int? idGroupType;
  int? idType;
  var listQuestion = <Question>[].obs;
  var isQuiz = false.obs;
  BaseQuestion? baseQuestion;
  var error = <String?>[].obs;

  @override
  initialData() async {
    idClass = Get.arguments[0];
    idGroupType = Get.arguments[1];
    if (Get.arguments.length > 2) {
      pFileFolder = Get.arguments[2];
    }
    if (Get.arguments.length > 3) {
      idSubject = Get.arguments[3];
    }
    if (Get.arguments.length > 4) {
      idType = Get.arguments[4];
    }
    for (int i = 0; i < 7; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    if (pFileFolder?.type == 'QUIZ') {
      isQuiz.value = true;
      await getQuestion();
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

  getQuestion() async {
    Map<String, dynamic> map = HashMap();
    map['idDanhMuc'] = idType;
    client = await NetworkUtils.getClientInstance();
    BaseResponse? baseResponse = await client.getAllQuestionsByType(m: map);
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse!.data);
      basePageResponse.data!.forEach((element) {
        listQuestion.add(Question.fromJson(element));
      });
    }
  }

  @override
  getJsonObjectRequest() {
    List<int> listIdQuestion = [];
    listQuestion.forEach((element) {
      listIdQuestion.add(element.id!);
    });
    return FileFolder(
        id: pFileFolder?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        startTime: '${edtController[2].text} ${edtController[3].text}',
        endTime: '${edtController[4].text} ${edtController[5].text}',
        idGroupType: idGroupType,
        listIdQuestion: listIdQuestion,
        type: isQuiz.value ? 'QUIZ' : '',
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

  Future<dynamic> suggestion(pattern) async {
    baseQuestion =
        BaseQuestion(content: pattern.toString(), idMonHoc: idSubject);
    baseQuestion!.listData.clear();

    await baseQuestion!.getData();
    await handleDelay(1000);
    return baseQuestion!.listData;
  }

  suggestionSelected(Question suggestion) {
    suggestion.isChoose.value = !suggestion.isChoose.value;
    listQuestion.clear();
    print(suggestion);

    baseQuestion!.listData.forEach((element) {
      print(element);
      if (element.isChoose.value) {
        listQuestion.add(element);
      } else {
        listQuestion.remove(element);
      }
    });
  }

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    error[2] = Utils.validate(s: edtController[2].text);
    error[3] = Utils.validate(s: edtController[3].text);
    error[4] = Utils.validate(s: edtController[4].text);
    error[5] = Utils.validate(s: edtController[5].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }
}
