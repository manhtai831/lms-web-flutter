import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/file_student.dart';
import 'package:web_lms/ui/list_point/list_point_controller.dart';

class AddPointController extends BaseController {
  FileStudent? pFileStudent;
  List<TextEditingController> edtController = [];
  var error = <String?>[].obs;

  @override
  initialData() {
    for (int i = 0; i < 3; i++) {
      edtController.add(TextEditingController());
      error.add(null);
    }
    pFileStudent = Get.arguments;

    edtController[0].text =
        pFileStudent?.point == null ? '' : '${pFileStudent?.point}';
    edtController[1].text = pFileStudent?.note ?? '';
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse =
        await client.updateFileStudent(getJsonObjectRequest());
    if (checkError(baseResponse)) {
      ListPointController listPointController = Get.find();
      listPointController.getData();
      Get.back();
      Utils.snackBar(message: 'Cập nhật thành công');
    }
  }

  request() async {
    error[0] = Utils.validate(s: edtController[0].text);
    if (Utils.checkValidate(l: error)) {
      await getData();
    }
  }

  @override
  getJsonObjectRequest() {
    return FileStudent(
        id: pFileStudent?.id,
        note: edtController[1].text,
        point: int.tryParse(edtController[0].text));
  }
}
