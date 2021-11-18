import 'package:web_lms/core/base_controller.dart';
import 'package:get/get.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/class_model.dart';

class ListClassController extends BaseController {
  var listCLass = <ClassModel>[].obs;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListClass();
    if (checkError(baseResponse)) {
      listCLass.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listCLass.add(ClassModel.fromJson(element));
      });
    }
  }

  delete(int i) async {
    BaseResponse? baseResponse = await client.deleteClass(ClassModel(id: i));
    if (checkError(baseResponse)) {
      getData();
      Get.back();
      Utils.snackBar(message: 'Xóa lớp học thành công');
    }
  }
}
