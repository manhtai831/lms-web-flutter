import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/status.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/model/subject.dart';

class ListQuizController extends BaseController {
  TextEditingController edtController = TextEditingController();
  var listQuestion = <Question>[].obs;
  var listSubject = <Subject>[].obs;
  int? idMonHoc;
  var status1 = Status.loading.obs;

  @override
  initialData() async {
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListSubject();
    if (checkError(baseResponse)) {
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      for (int i = 0; i < basePageResponse.data!.length; i++) {
        Subject subject = Subject.fromJson(basePageResponse.data![i]);
        if (i == 0) {
          listSubject.add(subject);
          pickSubject(subject);
        } else {
          listSubject.add(subject);
        }
      }
    }
  }

  getListQuestion() async {
    Map<String, dynamic> map = HashMap();
    if (idMonHoc != null) map['idMonHoc'] = idMonHoc;
    BaseResponse? baseResponse = await client.getListQuestion(m: map);
    if (checkError(baseResponse)) {
      listQuestion.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listQuestion.add(Question.fromJson(element));
      });
    }
    status1.value = Status.success;
  }

  deleteQuestion(int i) async {
    BaseResponse? baseResponse = await client.deleteQuestion(Question(id: i));
    if (checkError(baseResponse)) {
      Get.back();
      getListQuestion();
      Utils.snackBar(message: 'Xóa câu hỏi thành công');
    }
  }

  pickSubject(Subject element) async {
    status.value = Status.loading;
    listSubject.forEach((element) {
      element.isChoose.value = false;
    });
    element.isChoose.value = true;
    idMonHoc = element.id;
    await getListQuestion();
  }
}
