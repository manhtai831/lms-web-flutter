import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/subject.dart';
import 'package:get/get.dart';
import 'package:web_lms/ui/list_subject/list_subject_controller.dart';

class AddSubjectController extends BaseController {
  Subject? pSubject;
  List<TextEditingController> edtController = [];
  var isActive = false.obs;
  var imageCurrent = Rxn();
  var avatar;
  int? idDepartment;
  var error = <String?>[].obs;

  @override
  initialData() {
    pSubject = Get.arguments;
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    edtController[0].text = pSubject?.name ?? '';
    edtController[1].text = pSubject?.description ?? '';
    edtController[4].text = pSubject?.department?.name ?? '';
    idDepartment = pSubject?.department?.id;
    if (pSubject?.status == 0) {
      isActive.value = false;
    } else if (pSubject?.status == 1) {
      isActive.value = true;
    }
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse;
    if (pSubject != null) {
      baseResponse = await client.updateSubject(getJsonObjectRequest());
    } else {
      baseResponse = await client.createSubject(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      ListSubjectController listDepartController = Get.find();
      listDepartController.getData();
      Get.back();
      Utils.snackBar(
          message: pSubject != null
              ? 'Cập nhật môn học thành công'
              : 'Thêm môn học thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    if (edtController[4].text.trim().isEmpty) {
      idDepartment = -1;
    }
    return Subject(
        id: pSubject?.id,
        name: edtController[0].text,
        description: edtController[1].text,
        idDepartment: idDepartment,
        data: avatar,
        status: isActive.value ? 1 : 0);
  }

  sugestion(String pattern) async {
    BaseDepartment baseSemester = BaseDepartment(title: pattern.toString());
    await baseSemester.getData();
    return baseSemester.listData;
  }

  valueSelected(value) {
    idDepartment = value.id;
  }

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }
}
