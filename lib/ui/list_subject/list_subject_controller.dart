import 'package:web_lms/core/api_common.dart';
import 'package:web_lms/core/base_controller.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/network/base_page_response.dart';
import 'package:web_lms/core/network/base_response.dart';
import 'package:web_lms/model/subject.dart';
import 'package:get/get.dart';

class ListSubjectController extends BaseController {
  var listSubject = <Subject>[].obs;
  TextEditingController edtController = TextEditingController();

  @override
  initialData() async {
    await super.initialData();
  }

  @override
  getDataSuccessFromAPI() async {
    BaseResponse? baseResponse = await client.getListSubject();
    if (checkError(baseResponse)) {
      listSubject.clear();
      BasePageResponse basePageResponse =
          BasePageResponse.fromJson(baseResponse?.data);
      basePageResponse.data!.forEach((element) {
        listSubject.add(Subject.fromJson(element));
      });
    }
  }

  search() async {
    BaseSubject baseSubject = BaseSubject(title: edtController.text);
    await baseSubject.getData();
    listSubject.clear();
    listSubject.value = baseSubject.listData ?? [];
  }

  delete(int i) async {
    BaseResponse? baseResponse = await client.deleteSubject(Subject(id: i));
    if (checkError(baseResponse)) {
      getData();
      Get.back();
      Utils.snackBar(message: 'Xóa môn học thành công');
    }
  }
}
