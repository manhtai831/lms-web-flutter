import 'dart:collection';

import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/file_student.dart';

class DetailFileStudentController extends BaseController {
  var dFileStudent = FileStudent().obs;
  FileStudent? pFileStudent;

  int? idClass;
  int? idGroupType;
  @override
  initialData() async {
    idClass = Get.arguments[0];
    idGroupType = Get.arguments[1];
    pFileStudent = Get.arguments[2];
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    Map<String, dynamic> classMap = HashMap();
    classMap['id'] = pFileStudent?.id;
    BaseResponse? baseResponse = await client.getDetailFileStudent(m: classMap);
    if (checkError(baseResponse)) {
      dFileStudent.value = FileStudent.fromJson(baseResponse?.data);
    }
  }
}
