import 'package:flutter/cupertino.dart';
import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/core/utils.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/ui/list_class/list_class_controller.dart';
import 'package:web_lms/ui/list_subject/list_subject_controller.dart';

class AddClassController extends BaseController {
  ClassModel? pClass;
  List<TextEditingController> edtController = [];
  int? idSubject;
  var error = <String?>[].obs;

  @override
  initialData() async {
    pClass = Get.arguments;
    for (int i = 0; i < 10; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    edtController[0].text = pClass?.name ?? '';
    edtController[1].text = pClass?.description ?? '';
    edtController[4].text = pClass?.subject?.name ?? '';
    idSubject = pClass?.subject?.id;
  }

  @override
  getDataSuccessFromAPI() async {
    print('abc');
    BaseResponse? baseResponse;
    if (pClass != null) {
      baseResponse = await client.updateClass(getJsonObjectRequest());
    } else {
      baseResponse = await client.createClass(getJsonObjectRequest());
    }

    if (checkError(baseResponse)) {
      ListClassController listDepartController = Get.find();
      listDepartController.getData();
      Get.back();
      Utils.snackBar(
          message: pClass != null
              ? 'Cập nhật lớp học thành công'
              : 'Thêm lớp học thành công');
    }
  }

  @override
  getJsonObjectRequest() {
    return ClassModel(
      id: pClass?.id,
      name: edtController[0].text,
      description: edtController[1].text,
      idSubject: idSubject,
    );
  }

  sugestion(String pattern) async {
    BaseSubject baseSemester = BaseSubject(title: pattern.toString());
    await baseSemester.getData();
    return baseSemester.listData;
  }

  valueSelected(value) {
    idSubject = value.id;
  }

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }
}
